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
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';

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
  late JanelaCadastroC _c;
  late ValidacaoCampos _validacaoCampos;
  late ObservadorButoes _observadorButoes;

  var nome = "".obs, palavraPasse = "".obs, confirmePalavraPasse = "".obs;
  late BuildContext context;

  CorpoJanelaCadastro() {
    _validacaoCampos = ValidacaoCampos();
    _observadorButoes = ObservadorButoes();
    _c = Get.put(JanelaCadastroC());
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Visibility(
      visible: !Responsidade.isMobile(context),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: LayoutCadastro(
                nome: nome,
                observadorButoes: _observadorButoes,
                palavraPasse: palavraPasse,
                confirmePalavraPasse: confirmePalavraPasse,
                validacaoCampos: _validacaoCampos,
                c: _c),
          ),
          const Expanded(
            flex: 8,
            child: LayoutBemVindo(
              nomeImagemFundo: "gestao2",
            ),
          )
        ],
      ),
      replacement: LayoutCadastro(
          nome: nome,
          observadorButoes: _observadorButoes,
          palavraPasse: palavraPasse,
          confirmePalavraPasse: confirmePalavraPasse,
          validacaoCampos: _validacaoCampos,
          c: _c),
    );
  }
}

class LayoutCadastro extends StatelessWidget {
  const LayoutCadastro({
    Key? key,
    required this.nome,
    required ObservadorButoes observadorButoes,
    required this.palavraPasse,
    required this.confirmePalavraPasse,
    required ValidacaoCampos validacaoCampos,
    required JanelaCadastroC c,
  })  : _observadorButoes = observadorButoes,
        _validacaoCampos = validacaoCampos,
        _c = c,
        super(key: key);

  final RxString nome;
  final ObservadorButoes _observadorButoes;
  final RxString palavraPasse;
  final RxString confirmePalavraPasse;
  final ValidacaoCampos _validacaoCampos;
  final JanelaCadastroC _c;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              icone: const Icon(Icons.text_fields),
              dicaParaCampo: "Nome Completo",
              metodoChamadoNaInsersao: (String valor) {
                nome.value = valor;
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  nome.value,
                  palavraPasse.value,
                  confirmePalavraPasse.value
                ], [
                  _validacaoCampos.validarNome(nome.value),
                  _validacaoCampos.validarNumero(palavraPasse.value),
                  _validacaoCampos.validarNumero(confirmePalavraPasse.value),
                ]);
              },
            ),
            Obx(() {
              return _validacaoCampos.validarNome(nome.value) == true ||
                      nome.isEmpty
                  ? Container()
                  : LabelErros(
                      sms: "Este Nome ainda é inválido!",
                    );
            }),
            SizedBox(
              height: 20,
            ),
            CampoTexto(
              context: context,
              campoBordado: false,
              icone: Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Pin",
              campoOculto: true,
              metodoChamadoNaInsersao: (String valor) {
                palavraPasse.value = valor;
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  nome.value,
                  palavraPasse.value,
                  confirmePalavraPasse.value
                ], [
                  _validacaoCampos.validarNome(nome.value),
                  _validacaoCampos.validarNumero(palavraPasse.value),
                  _validacaoCampos.validarNumero(confirmePalavraPasse.value),
                ]);
              },
            ),
            Obx(() {
              return (_validacaoCampos.validarPin(palavraPasse.value) ==
                          true) ||
                      palavraPasse.isEmpty
                  ? Container()
                  : LabelErros(
                      sms: "O Pin deve ter mais de 7 caracteres!",
                    );
            }),
            const SizedBox(
              height: 10,
            ),
            CampoTexto(
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Confirmar Pin",
              campoOculto: true,
              metodoChamadoNaInsersao: (String valor) {
                confirmePalavraPasse.value = valor;
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  nome.value,
                  palavraPasse.value,
                  confirmePalavraPasse.value
                ], [
                  _validacaoCampos.validarNome(nome.value),
                  _validacaoCampos.validarNumero(palavraPasse.value),
                  _validacaoCampos.validarNumero(confirmePalavraPasse.value),
                ]);
              },
            ),
            Obx(() {
              return (confirmePalavraPasse.value == palavraPasse.value) ||
                      confirmePalavraPasse.isEmpty
                  ? Container()
                  : LabelErros(
                      sms: "Este Pin deve ser igual ao campo anterior!",
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
                      confirmePalavraPasse.value == palavraPasse.value,
                  tituloButao: "Finalizar",
                  metodoChamadoNoClique: () async {
                    await _c.orientarRealizacaoCadastro(
                        nome.value, palavraPasse.value);
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
