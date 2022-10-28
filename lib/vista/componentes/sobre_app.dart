import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../solucoes_uteis/acessos.dart';

class SobreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            """
        Olá! Somos a Oku Sanga\n
        Somos uma empresa de produção e venda de Software.\n
        Criamos sistemas para seu negócio.\n
        Vendemos serviços em nossos sistemas.
        """,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.justify,
            style: TextStyle(
              inherit: true,
              fontSize: 10.sp,
            ),
          ),
          Text(
            """
        A App NossoStory, mais do que prestar a si um serviço gratuito de actualização de Estados(Histórias),
        é uma verdadeira demonstração do que nos falta para aprender e das nossas habilidades em T.I.
        """,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              inherit: true,
              fontSize: 10.sp,
            ),
          ),
          Text(
            """
        Críticas e Sujestões em nossos canais oficiais!\n
        Por favor! Siga, Partilhe, Curta!
        """,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.justify,
            style: TextStyle(
              inherit: true,
              fontSize: 10.sp,
            ),
          ),
          InkWell(
            onTap: () async {
              var ligacao = "";
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.facebook),
                SizedBox(
                  width: 20,
                ),
                Text("Facebook")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.twitter),
                SizedBox(
                  width: 20,
                ),
                Text("Twitter")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.whatsapp),
                SizedBox(
                  width: 20,
                ),
                Text("WhatsApp")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(Icons.mail),
                SizedBox(
                  width: 20,
                ),
                Text("Email")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(Icons.phone),
                SizedBox(
                  width: 20,
                ),
                Text("Telefone")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.youtube),
                SizedBox(
                  width: 20,
                ),
                Text("YouTube")
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await abrirLigacaoNoNavegador("ligacao");
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.linkedin),
                SizedBox(
                  width: 20,
                ),
                Text("LinkedIn do Desenvolvedor")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Versão: 1.0.1"),
          )
        ],
      ),
    );
  }
}
