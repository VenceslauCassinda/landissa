import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../recursos/constantes.dart';
import '../../aplicacao_c.dart';
import '../../componentes/bem_vindo.dart';
import '../../componentes/logo.dart';
import 'janela_login_c.dart';

class JanelaLogin extends StatelessWidget {
  late JanelaLoginC _c;
  JanelaLogin() {
    _c = Get.put(JanelaLoginC());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CorpoJanelaLogin(_c),
    );
  }
}

class CorpoJanelaLogin extends StatelessWidget {
  late JanelaLoginC _c;
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorButoes _observadorButoes;
  String nomeUsuario = "", palavraPasse = "";

  CorpoJanelaLogin(this._c) {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorButoes = ObservadorButoes();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(context);
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(100),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    child: Image.asset(
                      "lib/recursos/imagens/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CampoTexto(
                    context: context,
                    campoBordado: false,
                    tipoCampoTexto: TipoCampoTexto.generico,
                    icone: const Icon(Icons.text_fields),
                    dicaParaCampo: "Nome de Usuário",
                    metodoChamadoNaInsersao: (String valor) {
                      nomeUsuario = valor;
                      _observadorCampoTexto.observarCampo(
                          valor, TipoCampoTexto.generico);
                      if (valor.isEmpty) {
                        _observadorCampoTexto.mudarValorValido(
                            true, TipoCampoTexto.generico);
                      }
                      _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                        nomeUsuario,
                        palavraPasse
                      ], [
                        _observadorCampoTexto.valorPalavraPasseValido.value
                      ]);
                    },
                  ),
                  Obx(() {
                    return _observadorCampoTexto
                                .valorNumeroTelefoneValido.value ==
                            true
                        ? Container()
                        : LabelErros(
                            sms: "Este numero ainda é inválido!",
                          );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  CampoTexto(
                    context: context,
                    campoBordado: false,
                    icone: Icon(Icons.lock),
                    tipoCampoTexto: TipoCampoTexto.palavra_passe,
                    dicaParaCampo: "Palavra-Passe",
                    metodoChamadoNaInsersao: (String valor) {
                      palavraPasse = valor;
                      _observadorCampoTexto.observarCampo(
                          valor, TipoCampoTexto.palavra_passe);
                      if (valor.isEmpty) {
                        _observadorCampoTexto.mudarValorValido(
                            true, TipoCampoTexto.palavra_passe);
                      }
                      _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                        nomeUsuario,
                        palavraPasse
                      ], [
                        _observadorCampoTexto.valorPalavraPasseValido.value
                      ]);
                    },
                  ),
                  Obx(() {
                    return _observadorCampoTexto
                                .valorPalavraPasseValido.value ==
                            true
                        ? Container()
                        : LabelErros(
                            sms:
                                "A palavra-passe deve ter mais de 7 caracteres!",
                          );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ModeloButao(
                      corButao: primaryColor,
                      corTitulo: Colors.white,
                      butaoHabilitado: true,
                      tituloButao: "Entrar",
                      metodoChamadoNoClique: () async {
                        await _c.fazerLogin(nomeUsuario, palavraPasse);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ModeloButao(
                      corButao: Colors.white.withOpacity(.8),
                      tituloButao: "Cadastrar",
                      butaoHabilitado: true,
                      metodoChamadoNoClique: () {
                        AplicacaoC.irParaJanelaCadastro(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.facebook,
                          color: primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.twitter,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          flex: 8,
          child: LayoutBemVindo(
            nomeImagemFundo: "gestao",
          ),
        )
      ],
    );
  }
}
