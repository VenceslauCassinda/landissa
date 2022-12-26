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
import 'package:yetu_gestor/dominio/entidades/caixa.dart';
import '../../../../../../../recursos/constantes.dart';

class LayoutAddSaidaCaixa extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorButoes _observadorButoes = ObservadorButoes();

  final Function(String valor, String motivo, bool entradaOuSaida)
      accaoAoFinalizar;

  String? valor;
  String? motivo;
  final String titulo;
  late BuildContext context;
  String opcaoRetiradaSelecionada = "";
  var entradaOuSaida = true.obs;

  LayoutAddSaidaCaixa(
      {required this.accaoAoFinalizar, required this.titulo, valor}) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: valor,
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Valor",
              metodoChamadoNaInsersao: (String novo) {
                valor = novo;
                _observadorCampoTexto.observarCampo(
                    novo, TipoCampoTexto.numero);
                if (novo.isEmpty) {
                  _observadorCampoTexto.mudarValorValido(
                      true, TipoCampoTexto.numero);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  valor ?? "",
                  motivo ?? ""
                ], [
                  _observadorCampoTexto.valorNumeroValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto.valorNumeroValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Valor inválido!",
                    );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Motivo:   "),
                MenuDropDown(
                  labelMenuDropDown: "Padrão",
                  metodoChamadoNaInsersao: (dado) {
                    if (dado.contains("Saldo")) {
                      opcaoRetiradaSelecionada = (Caixa.MOTIVO_SALDO);
                    } else {
                      opcaoRetiradaSelecionada = dado;
                    }
                  },
                  listaItens: [
                    "Padrão",
                    "Saldo",
                  ],
                ),
              ],
            ),
            CampoTexto(
              context: context,
              campoBordado: false,
              tipoCampoTexto: TipoCampoTexto.nome,
              icone: const Icon(Icons.text_fields),
              dicaParaCampo: "Observação",
              metodoChamadoNaInsersao: (String valorr) {
                motivo = valorr;
                _observadorCampoTexto.observarCampo(
                    valorr, TipoCampoTexto.nome);
                if (valorr.isEmpty) {
                  _observadorCampoTexto.mudarValorValido(
                      true, TipoCampoTexto.nome);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao(
                    [valor ?? "", motivo ?? ""],
                    [_observadorCampoTexto.valorNomeValido.value]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto.valorNomeValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Observação inválida!",
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    child: RadioListTile(
                        selected: entradaOuSaida.value,
                        title: Text("Entrada de Caixa"),
                        value: true,
                        groupValue: entradaOuSaida.value,
                        onChanged: (novo) {
                          entradaOuSaida.value = novo as bool;
                        }),
                  ),
                  Container(
                    width: 250,
                    child: RadioListTile(
                        title: Text("Saída de Caixa"),
                        value: false,
                        selected: !entradaOuSaida.value,
                        groupValue: entradaOuSaida.value,
                        onChanged: (novo) {
                          entradaOuSaida.value = novo as bool;
                        }),
                  ),
                ],
              );
            }),
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
                            valor!,
                            "$motivo$opcaoRetiradaSelecionada",
                            entradaOuSaida.value);
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
