import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/menu_drop_down.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';

import '../../../../../recursos/constantes.dart';

class LayoutQuantidade extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorButoes _observadorButoes = ObservadorButoes();

  final Function(int quantidade, String? opcaoRetiradaSelecionada)
      accaoAoFinalizar;

  String? quantidade;
  final String titulo;
  late BuildContext context;
  final bool comOpcaoRetirada;
  String opcaoRetiradaSelecionada = Saida.MOTIVO_AJUSTE_STOCK;

  LayoutQuantidade(
      {required this.accaoAoFinalizar,
      required this.titulo,
      quantidade,
      required this.comOpcaoRetirada}) {
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
              titulo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: quantidade,
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Quantidade",
              metodoChamadoNaInsersao: (String valor) {
                quantidade = valor;
                _observadorCampoTexto.observarCampo(
                    valor, TipoCampoTexto.numero);
                if (valor.isEmpty) {
                  _observadorCampoTexto.mudarValorValido(
                      true, TipoCampoTexto.numero);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  quantidade ?? "",
                ], [
                  _observadorCampoTexto.valorNumeroValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto.valorNumeroValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Quantidade inválida!",
                    );
            }),
            Visibility(
              visible: comOpcaoRetirada,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: MenuDropDown(
                  labelMenuDropDown: opcaoRetiradaSelecionada,
                  metodoChamadoNaInsersao: (dado) {
                    opcaoRetiradaSelecionada = dado;
                  },
                  listaItens: [
                    (Saida.MOTIVO_AJUSTE_STOCK),
                    (Saida.MOTIVO_DESPERDICIO),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                      tituloButao: "Finalizar",
                      metodoChamadoNoClique: () {
                        accaoAoFinalizar(
                            int.parse(quantidade!), opcaoRetiradaSelecionada);
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
