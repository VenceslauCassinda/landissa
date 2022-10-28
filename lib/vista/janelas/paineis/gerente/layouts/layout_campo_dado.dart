import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos_c.dart';

import '../../../../../recursos/constantes.dart';

class LayoutCampoDado extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorButoes _observadorButoes = ObservadorButoes();

  final Function(String? dado) accaoAoFinalizar;

  String? dado, label;
  late BuildContext context;

  LayoutCampoDado({this.dado, this.label, required this.accaoAoFinalizar}) {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorButoes = ObservadorButoes();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(label ?? "Dado")} A EDITAR",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: dado,
              context: context,
              campoBordado: false,
              icone: Icon(Icons.text_fields),
              dicaParaCampo: "insira o dado",
              metodoChamadoNaInsersao: (String valor) {
                dado = valor;
                _observadorCampoTexto.observarCampo(
                    valor, TipoCampoTexto.generico);
                if (valor.isEmpty) {
                  _observadorCampoTexto.mudarValorValido(
                      true, TipoCampoTexto.generico);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  dado ?? "",
                ], [
                  _observadorCampoTexto.valorNomeValido.value,
                  _observadorCampoTexto.valorNumeroTelefoneValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto.valorNomeValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Este Dado ainda é inválido!",
                    );
            }),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * .15,
                  child: ModeloButao(
                    tituloButao: "Cancelar",
                    corButao: primaryColor,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    metodoChamadoNoClique: () async {
                      fecharDialogoCasoAberto();
                    },
                  ),
                ),
                Obx(() {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * .15,
                    child: ModeloButao(
                      corButao: Colors.white.withOpacity(.8),
                      butaoHabilitado: _observadorButoes
                          .butaoFinalizarCadastroInstituicao.value,
                      tituloButao: dado == null ? "Finalizar" : "Actualizar",
                      metodoChamadoNoClique: () {
                        accaoAoFinalizar(dado);
                      },
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
