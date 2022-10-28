import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../recursos/constantes.dart';

class LayoutBemVindo extends StatelessWidget {
  final String? nomeImagemFundo;
  const LayoutBemVindo({
    Key? key,
    required this.nomeImagemFundo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width,
          child: Image.asset(
            "lib/recursos/imagens/$nomeImagemFundo.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width,
          color: Colors.black.withOpacity(.65),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: Image.asset(
                  "lib/recursos/imagens/logo2.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                    "Gestão de Venda\nGestão de Stock\nGestão Financeira\nControlo de Entradas e Saídas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 50, right: 50),
                child: Text(
                    "Reduza o tempo gasto em atividades operacionais como preenchimento de planilhas, transcição de anotações em folhas e papéis para documentos online, compartilhamento de informações entre departamentos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text("\n\n\n\n\nTelefone\n+244 926 886 839",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text("\n\n\nVersão: 1.0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
