import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/receccao.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/componentes/item_receccao.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';
import '../../../../../../dominio/entidades/funcionario.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/item_entrada.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../../../../componentes/tab_bar.dart';
import '../../painel_funcionario_c.dart';
import 'painel_c.dart';

class PainelRecepcoes extends StatelessWidget {
  late RecepcoesC _c;
  var painelFuncionarioC;
  final Funcionario funcionario;
  Function? accaoAoVoltar;
  PainelRecepcoes(
      {Key? key,
      required this.funcionario,
      required this.painelFuncionarioC,
      this.accaoAoVoltar})
      : super(key: key) {
    initiC();
  }

  initiC() {
    try {
      _c = Get.find();
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(RecepcoesC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {
              _c.aoPesquisar(dado);
            },
            accaoAoSair: () {
              _c.terminarSessao();
            },
            accaoAoVoltar: () {
              accaoAoVoltar!();
            },
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: Obx(() {
                return Text(
                  "RECEPÇÕES(${_c.lista.length})",
                  style: TextStyle(color: primaryColor),
                );
              }),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              ModeloButao(
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Todas",
                metodoChamadoNoClique: () {
                  _c.pegarDados(limparExistente: true);
                },
              ),
              SizedBox(
                width: 20,
              ),
              ModeloButao(
                icone: Icons.check_box_outlined,
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Pagas",
                metodoChamadoNoClique: () {
                  _c.pegarRececcoesComFiltro(true);
                },
              ),
              SizedBox(
                width: 20,
              ),
              ModeloButao(
                corButao: primaryColor,
                icone: Icons.check_box_outline_blank_rounded,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Não Pagas",
                metodoChamadoNoClique: () {
                  _c.pegarRececcoesComFiltro(false);
                },
              ),
              SizedBox(
                width: 40,
              ),
              Visibility(
                visible: _c.funcionario.nivelAcesso == NivelAcesso.GERENTE,
                child: ModeloButao(
                  corButao: primaryColor,
                  icone: Icons.delete,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  tituloButao: "Limpar",
                  metodoChamadoNoClique: () {
                    _c.mostrarDialogoEliminar(context, true);
                  },
                  metodoChamadoNoLongoClique: () {
                    _c.mostrarDialogoEliminar(context, false);
                  },
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        "TOTAL DE RECEPÇÕES PAGAS HOJE: ${formatar(_c.totalPagoHoje.value)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    }),
                    Obx(() {
                      return Text(
                        "TOTAL DE RECEPÇÕES NÃO PAGAS: ${formatar(_c.totalNaoPago.value)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Expanded(
          child: Obx(
            () {
              var itens = _c.lista
                  .map((entrada) => ItemRececcao(
                        visaoGeral: false,
                        receccao: entrada,
                        aoClicar: () {},
                        aoPagar: ((receccao) {
                          _c.pagarRececcao(receccao);
                        }),
                      ))
                  .toList();
              if (itens.isEmpty) {
                return Center(child: Text("Sem dados!"));
              }
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: itens.length, itemBuilder: (c, i) => itens[i]),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: funcionario.nivelAcesso == NivelAcesso.GERENTE,
              child: Container(
                margin: EdgeInsets.all(20),
                child: ModeloButao(
                  corButao: primaryColor,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  tituloButao: "Relatório",
                  icone: Icons.message,
                  metodoChamadoNoClique: () {
                    _c.mostrarDialogoRelatorio(context);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: ModeloButao(
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Receber Produto",
                metodoChamadoNoClique: () {
                  _c.mostrarDialogoProdutos(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
