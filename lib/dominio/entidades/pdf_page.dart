import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import '../../solucoes_uteis/pdf_api/widget/button_widget.dart';
import '../../solucoes_uteis/pdf_api/widget/title_widget.dart';

class PdfPage extends StatelessWidget {
  final String nomeRelatorio;
  final Function accaoAoCriarPdf;
  var carregando = false.obs;

  PdfPage(
      {Key? key,
      required this.accaoAoCriarPdf,
      required this.nomeRelatorio})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Gerar Relatório de $nomeRelatorio',
                ),
                const SizedBox(height: 48),
                Stack(
                  children: [
                    ButtonWidget(
                      text: 'Relatório em PDF',
                      onClicked: () {
                        carregando.value = false;
                        accaoAoCriarPdf();
                      },
                    ),
                  ],
                ),
                Obx(() {
                  return Visibility(
                    visible: carregando.value == true,
                    child: const LinearProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      );
}
