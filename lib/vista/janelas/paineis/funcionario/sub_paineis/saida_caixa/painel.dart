import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';
import 'package:yetu_gestor/vista/componentes/item_saida_caixa.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/saida_caixa/painel_c.dart';

import '../../../../../../dominio/entidades/painel_actual.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../componentes/item_dinheiro_sobra.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_funcionario_c.dart';

class PainelSaidaCaixa extends StatelessWidget {
  late Funcionario funcionario;
  late var c;
  late PainelSaidaCaixaC saidaCaixaC;
  Function? accaoAoVoltar;

  PainelSaidaCaixa(this.c, this.funcionario, {this.accaoAoVoltar}) {
    iniciarDependencias();
  }

  void iniciarDependencias() {
    try {
      saidaCaixaC = Get.find();
      saidaCaixaC.funcionario = funcionario;
    } catch (e) {
      saidaCaixaC = Get.put(PainelSaidaCaixaC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(accaoNaInsercaoNoCampoTexto: (dado) {
            saidaCaixaC.aoPesquisar(dado);
          }, accaoAoSair: () {
            c.terminarSessao();
          }, accaoAoVoltar: () {
            if (accaoAoVoltar != null) {
              accaoAoVoltar!();
              return;
            }
            c.irParaPainel(PainelActual.INICIO);
          }),
        ),
        Visibility(
          visible: Responsidade.isMobile(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              children: [
                const Text(
                  "OPERAÇÕES DE CAIXA",
                  style: TextStyle(color: primaryColor, fontSize: 30),
                ),
                Spacer(),
                PopupMenuButton<int>(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Filtros"),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onSelected: ((value) {
                    if (value == 0) {
                      saidaCaixaC.pegarDadosSaldo();
                      return;
                    }
                    if (value == 1) {
                      saidaCaixaC.pegarDadosTudo();
                      return;
                    }
                  }),
                  itemBuilder: ((context) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            Text("Saídas de Saldo"),
                            Spacer(),
                            Icon(Icons.arrow_circle_up_outlined)
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Text("Todas"),
                            Spacer(),
                            Icon(Icons.all_inbox)
                          ],
                        ),
                      ),
                    ];
                  }),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: !Responsidade.isMobile(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              children: [
                const Text(
                  "OPERAÇÕES DE CAIXA",
                  style: TextStyle(color: primaryColor, fontSize: 30),
                ),
                Spacer(),
                ModeloButao(
                  corButao: primaryColor,
                  icone: Icons.arrow_circle_up_outlined,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  tituloButao: "Saída de Saldo",
                  metodoChamadoNoClique: () {
                    saidaCaixaC.pegarDadosSaldo();
                  },
                  metodoChamadoNoLongoClique: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                ModeloButao(
                  corButao: primaryColor,
                  icone: Icons.all_inbox,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  tituloButao: "Todas",
                  metodoChamadoNoClique: () {
                    saidaCaixaC.pegarDadosTudo();
                  },
                  metodoChamadoNoLongoClique: () {},
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Row(
            children: [
              Visibility(
                visible:
                    saidaCaixaC.funcionario.nivelAcesso == NivelAcesso.GERENTE,
                child: ModeloButao(
                  corButao: primaryColor,
                  icone: Icons.delete,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  tituloButao: "Limpar",
                  metodoChamadoNoClique: () {
                    saidaCaixaC.mostrarDialogoEliminar(context, true);
                  },
                  metodoChamadoNoLongoClique: () {
                    saidaCaixaC.mostrarDialogoEliminar(context, false);
                  },
                ),
              ),
              Spacer(),
              Obx(() {
                return Text(
                  "SALDO ACTUAL: ${formatar(saidaCaixaC.caixaAtual.value)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx((() {
              return ListView.builder(
                  itemCount: saidaCaixaC.lista.length,
                  itemBuilder: (c, i) => ItemSaidaCaixa(
                        saidaCaixa: saidaCaixaC.lista[i],
                        aoClicar: () {},
                        aoRemover: () {
                          saidaCaixaC
                              .mostrarDialodoRemover(saidaCaixaC.lista[i]);
                        },
                        visaoGeral:
                            funcionario.nivelAcesso == NivelAcesso.GERENTE,
                      ));
            })),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: ModeloButao(
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Relatório",
                icone: Icons.message,
                metodoChamadoNoClique: () {
                  saidaCaixaC.mostrarDialogoRelatorio(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: ModeloButao(
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Nova Operação",
                metodoChamadoNoClique: () {
                  saidaCaixaC.mostrarDialogoNovaValor(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
