import 'dart:async';

import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_receccao_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipula_stock.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_entrada.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_preco.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_produto.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_receccao.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/receccao.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_entrada.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_preco.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_receccao.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_stock.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/utils.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/painel_funcionario_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/item_produto.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../../gerente/layouts/layout_receber_completo.dart';
import '../../../gerente/layouts/layout_relatorio_receccoes.dart';
import 'layouts/layouts_produtos_completo.dart';

class RecepcoesC extends GetxController {
  late ManipularRececcaoI _manipularRececcaoI;
  late ManipularProduto _manipularProduto;
  var lista = RxList<Receccao>();
  var listaCopia = <Receccao>[];
  late Funcionario funcionario;

  var totalNaoPago = 0.0.obs;
  var totalPagoHoje = 0.0.obs;

  RecepcoesC(this.funcionario) {
    var maipularStock = ManipularStock(ProvedorStock());
    _manipularProduto = ManipularProduto(
        ProvedorProduto(), maipularStock, ManipularPreco(ProvedorPreco()));
    _manipularRececcaoI = ManipularRececcao(ProvedorRececcao(),
        ManipularEntrada(ProvedorEntrada(), maipularStock), _manipularProduto);
  }
  @override
  void onInit() async {
    await pegarDados();
    super.onInit();
  }

  void aoPesquisar(String f) {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      if ((DateTime(cada.data!.year, cada.data!.month, cada.data!.day))
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase()) ||
          (cada.funcionario?.nomeCompelto ?? "")
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase()) ||
          (cada.funcionario?.nomeUsuario ?? "")
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase()) ||
          (cada.produto?.nome ?? "")
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase()) ||
          (cada.quantidadeRecebida)
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  Future<void> pegarDados({bool? limparExistente}) async {
    var hoje = DateTime.now();
    if (limparExistente == true) {
      lista.clear();
    }
    totalNaoPago.value = 0;
    List<Receccao> res = [];
    res = await _manipularRececcaoI.todas();
    for (var cada in res) {
      lista.add(cada);
      if (cada.pagavel == true && cada.paga == false) {
        totalNaoPago.value += cada.custoTotal;
      }
      if (cada.pagavel == true && cada.paga == true) {
        if (comapararDatas(cada.dataPagamento!, hoje)) {
          totalPagoHoje.value += cada.custoTotal;
        }
      }
    }
    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  Future<void> pegarRececcoesComFiltro(bool pagas) async {
    totalNaoPago.value = 0;
    lista.clear();
    List<Receccao> res = [];
    res = await _manipularRececcaoI.todas();
    for (var cada in res) {
      if (cada.pagavel == true && cada.paga == pagas) {
        lista.add(cada);
      }
      if (cada.pagavel == true && cada.paga == false) {
        totalNaoPago.value += cada.custoTotal;
      }
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  void terminarSessao() {
    PainelFuncionarioC c = Get.find();
    c.terminarSessao();
  }

  void irParaPainel(int indicePainel) {
    PainelFuncionarioC c = Get.find();
    c.irParaPainel(indicePainel);
  }

  void mostrarDialogoProdutos(BuildContext context) async {
    mostrarDialogoDeLayou(
        LayoutProdutosCompleto(
            aoClicarItem: (p) {
              voltar();
              mostrarDialogoReceberCompleto(p);
            },
            manipularProdutoI: _manipularProduto),
        layoutCru: true);
  }

  void mostrarDialogoReceberCompleto(Produto produto) {
    mostrarDialogoDeLayou(
        LayoutReceberCompleto(
            produto: produto,
            comOpcaoRetirada: false,
            accaoAoFinalizar: (int quantidadePorLotes,
                int quantidadeLotes,
                precoLote,
                double custo,
                bool pagavel,
                bool modoCompleto) async {
              var motivo = Entrada.MOTIVO_ABASTECIMENTO;
              fecharDialogoCasoAberto();
              await _receberProduto(
                  produto,
                  quantidadePorLotes,
                  quantidadeLotes,
                  precoLote,
                  custo,
                  pagavel,
                  motivo,
                  modoCompleto);
            },
            titulo: "Receber produto ${produto.nome}"),
        layoutCru: true);
  }

  Future<void> _receberProduto(
      Produto produto,
      int quantidadePorLotes,
      int quantidadeLotes,
      double precoLote,
      double custo,
      bool pagavel,
      String motivo,
      bool modoCompleto) async {
    var motivo = Entrada.MOTIVO_ABASTECIMENTO;
    var receccao2 = Receccao(
        paga: false,
        custoAquisicao: custo,
        precoLote: precoLote,
        pagavel: pagavel,
        quantidadeLotes: quantidadeLotes,
        quantidadePorLotes: quantidadePorLotes,
        produto: produto,
        funcionario: funcionario,
        estado: Estado.ATIVADO,
        idFuncionario: funcionario.id,
        idProduto: produto.id,
        data: DateTime.now());
    lista.insert(0, receccao2);
    if (receccao2.pagavel == true) {
      totalNaoPago.value += receccao2.custoTotal;
    }
    voltar();
    var id = await _manipularRececcaoI.receberProduto(
        produto,
        quantidadePorLotes,
        quantidadeLotes,
        precoLote,
        custo,
        funcionario,
        motivo,
        pagavel);
    lista[0].id = id;
  }

  void pagarRececcao(Receccao receccao) async {
    receccao.dataPagamento = DateTime.now();
    receccao.idPagante = funcionario.id;
    receccao.pagante = funcionario;

    try {
      await _manipularRececcaoI.actualizaRececcao(receccao);
      for (var i = 0; i < lista.length; i++) {
        if (lista[i].id == receccao.id) {
          totalNaoPago.value -= receccao.custoTotal;
          totalPagoHoje.value += receccao.custoTotal;
          lista[i] = receccao;
          break;
        }
      }
    } catch (e) {
      mostrarDialogoDeInformacao(
          "Não é possível pagar logo após uma recepção\nSaia da janela actual, volte e tente novamente!");
    }
  }

  void mostrarDialogoEliminar(BuildContext context, bool limparTudo) async {
    if (limparTudo == true) {
      mostrarDialogoDeLayou(
          LayoutConfirmacaoAccao(
              corButaoSim: primaryColor,
              pergunta: "Deseja mesmo limpar Tudo",
              accaoAoConfirmar: () async {
                voltar();
                lista.clear();
                await _manipularRececcaoI.removerTudo();
              },
              accaoAoCancelar: () {}),
          layoutCru: true);
      return;
    }
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje,
        firstDate: hoje.subtract(Duration(days: 365 * 3)),
        lastDate: hoje);
    if (dataSelecionada == null) {
      return;
    }
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            corButaoSim: primaryColor,
            pergunta:
                "Deseja mesmo limpar dados antes de ${formatarData(dataSelecionada, semHora: true)}",
            accaoAoConfirmar: () async {
              voltar();
              lista.removeWhere(
                  (element) => element.data!.isBefore(dataSelecionada));
              await _manipularRececcaoI.removerAntes(dataSelecionada);
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }

  void mostrarDialogoRelatorio(BuildContext context) async {
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje,
        firstDate: hoje.subtract(Duration(days: 365 * 2)),
        lastDate: hoje);
    if (dataSelecionada == null) {
      return;
    }

    mostrarDialogoDeLayou(
        LayoutRelatorioRececcoes(
            dataSelecionada: dataSelecionada,
            manipularRececcaoI: _manipularRececcaoI),
        layoutCru: true);
  }
}
