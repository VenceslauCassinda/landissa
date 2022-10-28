import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_caixa_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_venda_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida_caixa.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_venda.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida_caixa.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_venda.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/vista/aplicacao_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/recepcoes/layouts/layouts_produtos_completo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

import '../../../../../../contratos/casos_uso/manipular_item_venda_i.dart';
import '../../../../../../contratos/casos_uso/manipular_pagamento_i.dart';
import '../../../../../../contratos/casos_uso/manipular_preco_i.dart';
import '../../../../../../contratos/casos_uso/manipular_produto_i.dart';
import '../../../../../../contratos/casos_uso/manipular_stock_i.dart';
import '../../../../../../dominio/casos_uso/manipula_stock.dart';
import '../../../../../../dominio/casos_uso/manipular_cliente.dart';
import '../../../../../../dominio/casos_uso/manipular_item_venda.dart';
import '../../../../../../dominio/casos_uso/manipular_pagamento.dart';
import '../../../../../../dominio/casos_uso/manipular_preco.dart';
import '../../../../../../dominio/casos_uso/manipular_produto.dart';
import '../../../../../../dominio/casos_uso/manipular_saida.dart';
import '../../../../../../fonte_dados/provedores/provedor_cliente.dart';
import '../../../../../../fonte_dados/provedores/provedor_item_venda.dart';
import '../../../../../../fonte_dados/provedores/provedor_pagamento.dart';
import '../../../../../../fonte_dados/provedores/provedor_preco.dart';
import '../../../../../../fonte_dados/provedores/provedor_produto.dart';
import '../../../../../../fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../fonte_dados/provedores/provedor_stock.dart';

class HistoricoC extends GetxController {
  late ManipularProdutoI _manipularProdutoI;
  late ManipularStockI _manipularStockI;
  late ManipularVendaI _manipularVendaI;
  late ManipularItemVendaI _manipularItemVendaI;
  late PainelGerenteC _painelGerenteC;
  late ManipularPagamentoI _manipularPagamentoI;
  late ManipularSaidaCaixaI _manipularSaidaCaixaI;
  late ManipularSaidaI _manipularSaidaI;
  var vendas = 0.0.obs;
  var lucros = 0.0.obs;
  var saldo = 0.0.obs;
  var investimento = 0.0.obs;
  var caixaAtual = 0.0.obs;
  var totalSaidaCaixa = 0.0.obs;
  var totalEntradaCaixa = 0.0.obs;
  late ManipularPrecoI _manipularPrecoI;

  Funcionario? funcionario;

  RxList<DateTime> lista = RxList();
  List<DateTime> listaCopia = [];
  HistoricoC(this.funcionario) {
    _manipularSaidaCaixaI = ManipularSaidaCaixa(ProvedorSaidaCaixa());
    _manipularStockI = ManipularStock(ProvedorStock());
    _manipularProdutoI = ManipularProduto(
        ProvedorProduto(), _manipularStockI, ManipularPreco(ProvedorPreco()));
    _manipularPagamentoI = ManipularPagamento(ProvedorPagamento());
    _manipularPrecoI = ManipularPreco(ProvedorPreco());
    _manipularItemVendaI = ManipularItemVenda(
        ProvedorItemVenda(),
        ManipularProduto(ProvedorProduto(), _manipularStockI, _manipularPrecoI),
        ManipularStock(ProvedorStock()));
    _manipularSaidaI = ManipularSaida(ProvedorSaida(), _manipularStockI);
    _manipularVendaI = ManipularVenda(
        ProvedorVenda(),
        _manipularSaidaI,
        ManipularPagamento(ProvedorPagamento()),
        ManipularCliente(ProvedorCliente()),
        _manipularStockI,
        _manipularItemVendaI);
  }

  @override
  void onInit() async {
    await pegarCaixa();
    await pegarInvestimento();
    super.onInit();
  }

  int mySortComparison(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  pegarProdutosMaisSaidos() async {
    mostrarCarregandoDialogoDeInformacao("Buscando dados");
    var res = <Produto>[];
    var produtos = await _manipularProdutoI.pegarLista();
    for (var produto in produtos) {
      var saidas = await _manipularSaidaI.pegarListaDoProduto(produto);
      var total = saidas.fold<int>(
          0,
          (previousValue, element) =>
              (element.quantidade ?? 0) + previousValue);
      produto.quantidade = total;
      mostrar(produto.nome);
      mostrar(produto.quantidade);
      res.add(produto);
    }

    res.sort((a, b) {
      return mySortComparison(a.quantidade, b.quantidade);
    });
    // res.removeRange(9, res.length - 1);
    voltar();
    mostrarDialogoDeLayou(LayoutProdutosCompleto(
        lista: RxList<Produto>(res),
        aoClicarItem: (p) {},
        manipularProdutoI: _manipularProdutoI));
  }

  pegarCaixa() async {
    caixaAtual.value = 0;
    totalEntradaCaixa.value = 0;
    totalSaidaCaixa.value = 0;
    var res = await _manipularSaidaCaixaI.pegarLista();
    for (var cada in res) {
      var valor = cada.valor ?? 0;
      if (valor >= 0) {
        totalEntradaCaixa.value += valor;
      } else {
        totalSaidaCaixa.value += valor;
      }
      if ((cada.motivo ?? "").toLowerCase().contains("saldo")) {
        saldo.value += valor;
      }
    }
    caixaAtual.value = totalEntradaCaixa.value - (totalSaidaCaixa.value * -1);
  }

  pegarInvestimento() async {
    investimento.value = 0;
    vendas.value = 0;
    lucros.value = 0;
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      var s = await _manipularStockI.pegarStockDoProdutoDeId(cada.id ?? -1);
      if (s != null) {
        investimento.value += (s.quantidade ?? 0) * (cada.precoCompra ?? 0);
      }
      var precos = await _manipularPrecoI.pegarPrecoProdutoDeId(cada.id ?? -1);
      var maiorPreco = 0;
      if (precos.length == 1) {
        maiorPreco = (precos[0].preco ?? 0).toInt();
      } else {
        maiorPreco = (precos[0].preco ?? 0) > (precos[1].preco ?? 0)
            ? (precos[0].preco ?? 0) ~/ (precos[0].quantidade ?? 0)
            : (precos[1].preco ?? 0) ~/ (precos[1].quantidade ?? 0);
      }

      var saidas = await _manipularSaidaI.pegarListaDoProduto(cada);
      var total = saidas.fold<int>(
          0,
          (previousValue, element) =>
              (element.quantidade ?? 0) + previousValue);
      vendas.value += total * maiorPreco;
      lucros.value += total * (maiorPreco - (cada.precoCompra ?? 0));
    }
  }

  void aoPesquisar(String f) {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      if ((DateTime(cada.year, cada.month, cada.day))
          .toString()
          .toLowerCase()
          .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  Future<List<DateTime>> pegarLista() async {
    var res = [];
    if (funcionario != null) {
      res =
          await _manipularVendaI.pegarListaDataVendasFuncionario(funcionario!);
    } else {
      res = await _manipularVendaI.pegarListaDataVendas();
    }
    for (var cada in res) {
      lista.add(cada);
    }
    listaCopia.clear();
    listaCopia.addAll(lista);
    return lista;
  }

  void terminarSessao() {
    PainelGerenteC c = Get.find();
    c.terminarSessao();
  }

  void seleccionarData(DateTime data, {Funcionario? funcionario}) {
    PainelGerenteC c = Get.find();
    c.irParaPainel(PainelActual.VENDAS_ANTIGA, valor: [data, funcionario]);
  }

  void mostrarDialogoApagarAntes(BuildContext context) async {
    var data = await showDatePicker(
        context: context,
        // locale: const Locale("pt", "PT"),
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (data != null) {
      mostrarDialogoDeLayou(
          LayoutConfirmacaoAccao(
              pergunta:
                  "Deseja mesmo apagar as vendas feitas antes de ${formatarMesOuDia(data.day)}/${formatarMesOuDia(data.month)}/${data.year}?",
              accaoAoConfirmar: () async {
                await _removerAntesData(data);
              },
              accaoAoCancelar: () {},
              corButaoSim: primaryColor),
          layoutCru: true);
    }
  }

  Future<void> _removerAntesData(DateTime data) async {
    lista.removeWhere((cada) => cada.isBefore(data));
    voltar();
    await _manipularVendaI.removerVendasAntesData(data);
  }

  void mostrarDialogoApagarTudo(BuildContext context) {
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            pergunta: "Deseja mesmo apagar todas as vendas feitas?",
            accaoAoConfirmar: () async {
              await _removerTodas();
            },
            accaoAoCancelar: () {},
            corButaoSim: primaryColor),
        layoutCru: true);
  }

  Future<void> _removerTodas() async {
    lista.clear();
    voltar();
    await _manipularVendaI.removerTodasVendas();
  }
}
