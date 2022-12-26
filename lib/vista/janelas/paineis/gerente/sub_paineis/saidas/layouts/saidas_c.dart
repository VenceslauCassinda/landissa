import 'dart:developer';

import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_stock_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipula_stock.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_stock.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

import '../../../../../../../dominio/casos_uso/manipular_preco.dart';
import '../../../../../../../dominio/casos_uso/manipular_produto.dart';
import '../../../../../../../fonte_dados/provedores/provedor_preco.dart';
import '../../../../../../../fonte_dados/provedores/provedor_produto.dart';
import '../../../../../../../recursos/constantes.dart';
import '../../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../../../solucoes_uteis/pdf_api/geral_pdf.dart';
import '../../../../../../../solucoes_uteis/pdf_api/pdf_api.dart';
import '../../../../../../../solucoes_uteis/utils.dart';

class SaidasC extends GetxController {
  late ManipularSaidaI _manipularSaidaI;
  late ManipularStockI _manipularStockI;
  bool visaoGeral;

  var lista = RxList<Saida>();
  var listaCopia = <Saida>[];

  SaidasC({required this.visaoGeral}) {
    _manipularStockI = ManipularStock(ProvedorStock());
    _manipularSaidaI = ManipularSaida(ProvedorSaida(), _manipularStockI);
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
          (cada.produto?.nome ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (cada.quantidade ?? "").toString().contains(f.toLowerCase()) ||
          (cada.motivo ?? "")
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  Future<void> pegarDados() async {
    List<Saida> res = [];
    if (visaoGeral == true) {
      res = await _manipularSaidaI.pegarLista();
    } else {
      PainelGerenteC c = Get.find();
      Produto produto = (c.painelActual.value.valor as Produto);
      res = await _manipularSaidaI.pegarListaDoProduto(produto);
    }
    for (var cada in res) {
      lista.add(cada);
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  void terminarSessao() {
    PainelGerenteC c = Get.find();
    c.terminarSessao();
  }

  void irParaPainel(int indicePainel) {
    PainelGerenteC c = Get.find();
    c.irParaPainel(indicePainel);
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
                await _manipularSaidaI.removerTudo();
              },
              accaoAoCancelar: () {}),
          layoutCru: true);
      return;
    }
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje,
        firstDate: hoje.subtract(const Duration(days: 365 * 3)),
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
              await _manipularSaidaI.removerAntes(dataSelecionada);
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }

  void gerarRelatorio(BuildContext context) async {
    var hoje = DateTime.now();
    var dataInicio = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA INÍCIO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    var dataFim = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA DE TÉRMINO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: hoje);
    if (dataInicio == null || dataFim == null) {
      return;
    }
    if (dataInicio.isAfter(dataFim)) {
      mostrarDialogoDeInformacao(
          "O intervalo entre as data seleccionadas é invalido!");
      return;
    }
    mostrarCarregandoDialogoDeInformacao("Carregando...");
    var maniProduto = ManipularProduto(
        ProvedorProduto(), _manipularStockI, ManipularPreco(ProvedorPreco()));
    List<List<String>> listaItens = [];
    var todos = await _manipularSaidaI.pegarLista();
    for (var cada in todos) {
      if ((cada.data!.isAfter(dataInicio) ||
                  comapararDatas(cada.data!, dataInicio)) &&
              (cada.data!.isBefore(dataFim)) ||
          comapararDatas(cada.data!, dataFim)) {
        var produto = await maniProduto.pegarProdutoDeId(cada.idProduto ?? -1);
        listaItens.add([
          formatarInteiroComMilhares(cada.quantidade ?? 0).toString(),
          (produto?.nome ?? "SEM REGISTO"),
          (cada.motivo ?? "SEM REGISTO"),
          formatarData(cada.data!),
        ]);
      }
    }
    gerarPDF(listaItens, hoje, dataInicio, dataFim);
  }

  void gerarPDF(List<List<String>> dados, DateTime data, DateTime de,
      DateTime ate) async {
    try {
      var pdfFile = await GeralPdf.generate(
          "TABELA DE SAÍDAS",
          [
            "Quantidade",
            "Produto",
            "Motivo",
            "Data",
          ],
          dados,
          data,
          informacaoExtra:
              "Saídas entre ${formatarData(de, semHora: true)} até ${formatarData(ate, semHora: true)}");
      voltar();
      PdfApi.openFile(pdfFile);
    } catch (e) {
      mostrarDialogoDeInformacao(
          "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
    }
  }
}
