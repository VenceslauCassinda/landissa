import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/menu_drop_down.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';

import '../../../../../recursos/constantes.dart';

class LayoutReceberCompleto extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorCampoTexto _observadorCampoTexto2;
  late ObservadorCampoTexto _observadorCampoTexto3;
  late ObservadorCampoTexto _observadorCampoTexto4;
  late ObservadorButoes _observadorButoes = ObservadorButoes();
  var quantidadeTotal = 0.obs;
  var custoTotal = 0.0.obs;
  var precoCompra = 0.obs;
  var pagavel = false.obs;

  final Function(int quantidadePorLotes, int quantidadeLotes, double precoLote,
      double custo, bool pagavel) accaoAoFinalizar;

  String? quantidadePorLotes, quantidadeLotes, precoLote, custo = "0";
  final String titulo;
  late BuildContext context;
  final bool comOpcaoRetirada;

  LayoutReceberCompleto(
      {required this.accaoAoFinalizar,
      required this.titulo,
      quantidade,
      required this.comOpcaoRetirada}) {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorCampoTexto2 = ObservadorCampoTexto();
    _observadorCampoTexto3 = ObservadorCampoTexto();
    _observadorCampoTexto4 = ObservadorCampoTexto();
    _observadorButoes = ObservadorButoes();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                titulo,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: precoLote,
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Preço do Lote",
              metodoChamadoNaInsersao: (String valor) {
                precoLote = valor;
                actualizarDados();
                _observadorCampoTexto.observarCampo(
                    valor, TipoCampoTexto.preco);
                if (valor.isEmpty) {
                  _observadorCampoTexto.mudarValorValido(
                      true, TipoCampoTexto.preco);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  precoLote ?? "",
                  quantidadeLotes ?? "",
                  quantidadePorLotes ?? "",
                  custo ?? "",
                ], [
                  _observadorCampoTexto.valorPrecoValido.value,
                  _observadorCampoTexto2.valorNumeroValido.value,
                  _observadorCampoTexto3.valorNumeroValido.value,
                  _observadorCampoTexto4.valorPrecoValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto.valorPrecoValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Preço inválido!",
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: quantidadeLotes,
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Quantidade de Lotes",
              metodoChamadoNaInsersao: (String valor) {
                quantidadeLotes = valor;
                actualizarDados();
                _observadorCampoTexto2.observarCampo(
                    valor, TipoCampoTexto.numero);
                if (valor.isEmpty) {
                  _observadorCampoTexto2.mudarValorValido(
                      true, TipoCampoTexto.numero);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  precoLote ?? "",
                  quantidadeLotes ?? "",
                  quantidadePorLotes ?? "",
                  custo ?? "",
                ], [
                  _observadorCampoTexto.valorPrecoValido.value,
                  _observadorCampoTexto2.valorNumeroValido.value,
                  _observadorCampoTexto3.valorNumeroValido.value,
                  _observadorCampoTexto4.valorPrecoValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto2.valorNumeroValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Quantidade inválida!",
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: quantidadePorLotes,
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Quantidade de Unidades por Lotes",
              metodoChamadoNaInsersao: (String valor) {
                quantidadePorLotes = valor;
                actualizarDados();
                _observadorCampoTexto3.observarCampo(
                    valor, TipoCampoTexto.numero);
                if (valor.isEmpty) {
                  _observadorCampoTexto3.mudarValorValido(
                      true, TipoCampoTexto.numero);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  precoLote ?? "",
                  quantidadeLotes ?? "",
                  quantidadePorLotes ?? "",
                  custo ?? "",
                ], [
                  _observadorCampoTexto.valorPrecoValido.value,
                  _observadorCampoTexto2.valorNumeroValido.value,
                  _observadorCampoTexto3.valorNumeroValido.value,
                  _observadorCampoTexto4.valorPrecoValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto3.valorNumeroValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Quantidade inválida!",
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            CampoTexto(
              textoPadrao: custo == "0" ? null : custo,
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.numero,
              dicaParaCampo: "Custo de Aquisição",
              metodoChamadoNaInsersao: (String valor) {
                custo = valor;
                actualizarDados();
                _observadorCampoTexto4.observarCampo(
                    valor, TipoCampoTexto.preco);
                if (valor.isEmpty) {
                  _observadorCampoTexto4.mudarValorValido(
                      true, TipoCampoTexto.preco);
                }
                _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                  precoLote ?? "",
                  quantidadeLotes ?? "",
                  quantidadePorLotes ?? "",
                  custo ?? "",
                ], [
                  _observadorCampoTexto.valorPrecoValido.value,
                  _observadorCampoTexto2.valorNumeroValido.value,
                  _observadorCampoTexto3.valorNumeroValido.value,
                  _observadorCampoTexto4.valorPrecoValido.value,
                ]);
              },
            ),
            Obx(() {
              return _observadorCampoTexto4.valorPrecoValido.value == true
                  ? Container()
                  : LabelErros(
                      sms: "Custo inválido!",
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pagavel: "),
                Obx(() {
                  return Checkbox(
                      value: pagavel.value,
                      onChanged: (novo) {
                        pagavel.value = novo ?? false;
                      });
                }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return Text(
                "Quantidade Total: ${formatarInteiroComMilhares(quantidadeTotal.value)}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              );
            }),
            Obx(() {
              return Text(
                "Custo Total: ${formatar(custoTotal.value)}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              );
            }),
            Obx(() {
              return Text(
                "Preço de Compra(Unidade): ${formatarInteiroComMilhares(precoCompra.value)}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            int.parse(quantidadePorLotes!),
                            int.parse(quantidadeLotes!),
                            double.parse(precoLote!),
                            double.parse(custo!),
                            pagavel.value);
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

  void actualizarDados() {
    try {
      if (custo != null) {
        if (custo!.isEmpty) {
          custo = "0";
        }
      }
      if (precoLote != null &&
          quantidadeLotes != null &&
          quantidadePorLotes != null) {
        custoTotal.value = calcularCustoTotal();
      }
      if (quantidadeLotes != null && quantidadePorLotes != null) {
        quantidadeTotal.value = calcularQuantidadeTotal();
      }

      precoCompra.value = custoTotal.value ~/ quantidadeTotal.value;
    } catch (e) {}
  }

  int calcularQuantidadeTotal() =>
      int.parse(quantidadeLotes!) * int.parse(quantidadePorLotes!);

  double calcularCustoTotal() {
    return (int.parse(quantidadeLotes!) * double.parse(precoLote!)) +
        double.parse(custo!);
  }
}
