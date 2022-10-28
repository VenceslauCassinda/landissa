import 'dart:io';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'pdf_api.dart';

class GeralPdf {
  static Future<File> generate(String titulo, List<String> cabecalho,
      List<List<String>> dados, DateTime data,
      {String? informacaoExtra}) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildTitle(titulo),
        buildHeader(data),
        SizedBox(height: 0.08 * PdfPageFormat.cm),
        Text(informacaoExtra ?? ""),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        buildInvoice(cabecalho, dados),
      ],
      footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(
        name:
            '${titulo.toUpperCase()} ${formatarMesOuDia(data.day)}-${formatarMesOuDia(data.month)}-${data.year}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(DateTime data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              Text("Data: ${formatarData(data, semHora: true )}"),
            ],
          ),
        ],
      );

  static Widget buildTitle(String titulo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(List<String> cabecalho, List<List<String>> data) {
    return Table.fromTextArray(
      headers: cabecalho,
      data: data,
      border: const TableBorder(
          left: BorderSide(),
          right: BorderSide(),
          top: BorderSide(),
          bottom: BorderSide(),
          horizontalInside: BorderSide(),
          verticalInside: BorderSide()),
      cellStyle: TextStyle(fontSize: 8),
      headerStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 8,
      ),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
      },
    );
  }

  static Widget buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(
              "Processado por: YETUGESTOR ERP, DA: OKU SANGA (SU) - SOLUÇÕES TECNOLÓGICAS",
              style: TextStyle(fontSize: 5)),
          Text("Desenvolvedor: VENCESLAU EVANDRO CASSINDA MOREIRA",
              style: TextStyle(fontSize: 5)),
          Divider(),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
