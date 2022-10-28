import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/recursos/constantes.dart';

import '../../componentes/bem_vindo.dart';
import 'janela_cadastro_c.dart';

class JanelaCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CorpoJanelaCadastro(),
      ),
    );
  }
}

class CorpoJanelaCadastro extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorCampoTexto _observadorCampoTexto2;
  late ObservadorButoes _observadorButoes = ObservadorButoes();

  late JanelaCadastroC _c;

  String nome = "", palavraPasse = "", confirmePalavraPasse = "";
  late BuildContext context;

  CorpoJanelaCadastro() {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorCampoTexto2 = ObservadorCampoTexto();
    _observadorButoes = ObservadorButoes();

    _c = Get.put(JanelaCadastroC());
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
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
                  const Text(
                    "CADASTRAR-SE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CampoTexto(
                    context: context,
                    campoBordado: false,
                    icone: Icon(Icons.text_fields),
                    dicaParaCampo: "Nome Completo",
                    metodoChamadoNaInsersao: (String valor) {
                      nome = valor;
                      _observadorCampoTexto.observarCampo(
                          valor, TipoCampoTexto.nome);
                      if (valor.isEmpty) {
                        _observadorCampoTexto.mudarValorValido(
                            true, TipoCampoTexto.nome);
                      }
                      _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                        nome,
                        palavraPasse,
                        confirmePalavraPasse
                      ], [
                        _observadorCampoTexto.valorNomeValido.value,
                        _observadorCampoTexto.valorNumeroTelefoneValido.value,
                        _observadorCampoTexto.valorPalavraPasseValido.value,
                        _observadorCampoTexto2.valorPalavraPasseValido.value
                      ]);
                    },
                  ),
                  Obx(() {
                    return _observadorCampoTexto.valorNomeValido.value == true
                        ? Container()
                        : LabelErros(
                            sms: "Este Nome ainda é inválido!",
                          );
                  }),
                  SizedBox(
                    height: 10,
                  ),
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
                        nome,
                        palavraPasse,
                        confirmePalavraPasse
                      ], [
                        _observadorCampoTexto.valorNomeValido.value,
                        _observadorCampoTexto.valorNumeroTelefoneValido.value,
                        _observadorCampoTexto.valorPalavraPasseValido.value,
                        _observadorCampoTexto2.valorPalavraPasseValido.value
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
                  const SizedBox(
                    height: 10,
                  ),
                  CampoTexto(
                    context: context,
                    campoBordado: false,
                    icone: Icon(Icons.lock),
                    tipoCampoTexto: TipoCampoTexto.palavra_passe,
                    dicaParaCampo: "Confirmar Palavra-Passe",
                    metodoChamadoNaInsersao: (String valor) {
                      confirmePalavraPasse = valor;
                      _observadorCampoTexto2.observarCampo(
                          valor, TipoCampoTexto.palavra_passe);
                      if (valor.isEmpty) {
                        _observadorCampoTexto2.mudarValorValido(
                            true, TipoCampoTexto.palavra_passe);
                      }
                      _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                        nome,
                        palavraPasse,
                        confirmePalavraPasse
                      ], [
                        _observadorCampoTexto.valorNomeValido.value,
                        _observadorCampoTexto.valorNumeroTelefoneValido.value,
                        _observadorCampoTexto.valorPalavraPasseValido.value,
                        _observadorCampoTexto2.valorPalavraPasseValido.value
                      ]);
                    },
                  ),
                  Obx(() {
                    return _observadorCampoTexto2
                                    .valorPalavraPasseValido.value ==
                                true &&
                            confirmePalavraPasse == palavraPasse
                        ? Container()
                        : LabelErros(
                            sms:
                                "Esta palavra-passe de ser igual ao campo anterior!",
                          );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      width: MediaQuery.of(context).size.width,
                      child: ModeloButao(
                        corButao: Colors.white.withOpacity(.8),
                        butaoHabilitado: _observadorButoes
                                .butaoFinalizarCadastroInstituicao.value &&
                            confirmePalavraPasse == palavraPasse,
                        tituloButao: "Finalizar",
                        metodoChamadoNoClique: () async {
                          await _c.orientarRealizacaoCadastro(
                              nome, palavraPasse);
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    width: MediaQuery.of(context).size.width,
                    child: ModeloButao(
                      corButao: primaryColor,
                      icone: Icons.arrow_downward,
                      butaoHabilitado: true,
                      metodoChamadoNoClique: () async {
                        voltar();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          flex: 8,
          child: LayoutBemVindo(
            nomeImagemFundo: "gestao2",
          ),
        )
      ],
    );
  }
}

class LinhaProgressoPequena extends StatelessWidget {
  LinhaProgressoPequena({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .5,
        child: LinearProgressIndicator());
  }
}
