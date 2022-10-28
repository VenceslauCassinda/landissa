import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';

import '../../../../../contratos/casos_uso/manipular_receccao_i.dart';
import '../../../../../dominio/entidades/receccao.dart';
import '../../../../../recursos/constantes.dart';
import '../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../solucoes_uteis/pdf_api/geral_pdf.dart';
import '../../../../../solucoes_uteis/pdf_api/pdf_api.dart';

class LayoutRelatorioRececcoes extends StatelessWidget {
  LayoutRelatorioRececcoes({
    Key? key,
    required this.manipularRececcaoI,
    required this.dataSelecionada,
  }) : super(key: key) {
    pegarDado();
  }
  final DateTime dataSelecionada;
  final ManipularRececcaoI manipularRececcaoI;

  RxList<TableRow> dados = RxList<TableRow>([]);
  final List<Receccao> listaDaData = [];
  List<List<String>> itensParaPDF = [];
  var totalGasto = 0.0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (dados.length == 1) {
        if (listaDaData.isNotEmpty) {
          return Column(
            children: [
              Text("Aguarde..."),
              LinearProgressIndicator(),
            ],
          );
        }
        return Center(child: Text("Sem Dados"));
      }
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "DATA: ${formatarData(dataSelecionada, semHora: true)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Total Gasto: ${formatar(totalGasto)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .48,
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.black),
                  children: dados,
                ),
              ),
            ),
            Spacer(),
            ModeloButao(
              corButao: primaryColor,
              corTitulo: Colors.white,
              icone: Icons.arrow_upward,
              butaoHabilitado: true,
              tituloButao: "Gerar Arquivo PDF",
              metodoChamadoNoClique: () {
                gerarPDF();
              },
            ),
          ],
        ),
      );
    });
  }

  void pegarDado() async {
    var listaDaData =
        await manipularRececcaoI.pegarRececcoesDaData(dataSelecionada);
    totalGasto = listaDaData.fold<double>(
        0, (previousValue, element) => element.custoTotal + previousValue);
    dados.add(TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Produto",
          textAlign: TextAlign.center,
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Preço do Lote",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Qtd de Lotes",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Total",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Custo de Aquisição",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Custo Total",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Qtd de Unidades por Lotes",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Qtd Total de Unidades",
          textAlign: TextAlign.center,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Preço de Compra(Unitário)",
          textAlign: TextAlign.center,
        ),
      ),
    ]));

    for (var cada in listaDaData) {
      dados.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(cada.produto?.nome ?? "Sem Registo"),
        ),
        Center(child: Text(formatar(cada.precoLote ?? 0))),
        Center(
            child: Text(formatarInteiroComMilhares(cada.quantidadeLotes ?? 0))),
        Center(
            child:
                Text(formatar((cada.custoTotal - (cada.custoAquisicao ?? 0))))),
        Center(child: Text(formatar(cada.custoAquisicao ?? 0))),
        Center(child: Text(formatar(cada.custoTotal))),
        Center(
            child:
                Text(formatarInteiroComMilhares(cada.quantidadePorLotes ?? 0))),
        Center(
            child:
                Text(formatarInteiroComMilhares(cada.quantidadeRecebida))),
        Center(
            child: Text(formatarInteiroComMilhares(cada.precoCompraProduto))),
      ]));
      itensParaPDF.add([
        cada.produto?.nome ?? "Sem Registo",
        (formatar(cada.precoLote ?? 0)),
        (formatarInteiroComMilhares(cada.quantidadeLotes ?? 0)),
        (formatar(cada.custoTotal - (cada.custoAquisicao ?? 0))),
        (formatar(cada.custoAquisicao ?? 0)),
        (formatar(cada.custoTotal)),
        (formatarInteiroComMilhares(cada.quantidadePorLotes ?? 0)),
        (formatarInteiroComMilhares(cada.quantidadeRecebida)),
        (formatarInteiroComMilhares(cada.precoCompraProduto)),
      ]);
    }
  }

  void gerarPDF() async {
    try {
      var pdfFile = await GeralPdf.generate(
          "RELATÓRIO DE RECEPÇÕES",
          [
            "Produto",
            "Preço(Lote)",
            "Qtd(Lotes)",
            "Total",
            "Custo(Aquisição)",
            "Total",
            "Qtd de Uni.(Lotes)",
            "Qtd Total(Unidades)",
            "Preço(Unitário)",
          ],
          itensParaPDF,
          dataSelecionada,
          informacaoExtra: "Total Gasto: ${formatar(totalGasto)}");
      voltar();
      PdfApi.openFile(pdfFile);
    } catch (e) {
      mostrarDialogoDeInformacao(
          "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
    }
  }
}
