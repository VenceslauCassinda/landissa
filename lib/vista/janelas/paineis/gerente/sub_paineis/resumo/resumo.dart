import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';

import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_gerente_c.dart';
import 'resumo_c.dart';

class PainelResumo extends StatelessWidget {
  PainelResumo({
    Key? key,
    required PainelGerenteC c,
    this.funcionario,
    this.accaoAoVoltar,
  })  : _funcionarioC = c,
        super(key: key) {
    initiC();
  }

  late PainelResumoC _c;
  final PainelGerenteC _funcionarioC;
  final Funcionario? funcionario;
  Function? accaoAoVoltar;

  initiC() {
    try {
      _c = Get.find();
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(PainelResumoC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              if (accaoAoVoltar != null) {
                accaoAoVoltar!();
              }
              _funcionarioC.irParaPainel(PainelActual.INICIO);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Visibility(
          visible: Responsidade.isMobile(context),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              children: [
                const Text(
                  "RESUMO",
                  style: TextStyle(color: primaryColor, fontSize: 30),
                ),
                Spacer(),
                PopupMenuButton<int>(
                  child: Row(
                    children: [
                      Card(
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
                    ],
                  ),
                  onSelected: ((value) {
                    if (value == 0) {
                      _c.mostrarDialogoApagarAntes(context);
                      return;
                    }
                    if (value == 1) {
                      _c.mostrarDialogoApagarTudo(context);
                      return;
                    }
                  }),
                  itemBuilder: ((context) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: [
                            Text("Vendas Antes de"),
                            Spacer(),
                            Icon(Icons.delete)
                          ],
                        ),
                        onTap: () {},
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Text("Todas as Vendas"),
                            Spacer(),
                            Icon(Icons.delete_sweep)
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
          child: Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 0, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "RESUMO",
                  style: TextStyle(color: primaryColor, fontSize: 20),
                ),
                const Spacer(),
                Container(
                  width: 300,
                  child: ModeloButao(
                    corButao: primaryColor,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Vendas Antes de",
                    icone: Icons.delete,
                    metodoChamadoNoClique: () {
                      _c.mostrarDialogoApagarAntes(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  width: 300,
                  child: ModeloButao(
                    corButao: primaryColor,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Todas Vendas",
                    icone: Icons.delete_sweep,
                    metodoChamadoNoClique: () {
                      _c.mostrarDialogoApagarTudo(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Expanded(
          child: Obx(() {
            _c.lista.isEmpty;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: Responsidade.isMobile(context) ? 1 : 4,
                    mainAxisSpacing: 10),
                children: [
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 100,
                          ),
                          Obx(() {
                            if (_c.caixaAtual.value == -1) {
                              return CircularProgressIndicator();
                            }
                            return Text(
                                "Caixa Atual: ${formatar(_c.caixaAtual.value)}");
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 260,
                            child: ModeloButao(
                              corButao: primaryColor,
                              corTitulo: Colors.white,
                              butaoHabilitado: true,
                              icone: Icons.remove_red_eye,
                              tituloButao: "Operações Acumuladas",
                              metodoChamadoNoClique: () {
                                _c.mostrarDialogoEntradasAcumuladas(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.view_quilt_rounded,
                            size: 100,
                          ),
                          Obx(() {
                            if (_c.investimento.value == -1) {
                              return CircularProgressIndicator();
                            }
                            return Text(
                                "Investimento Atual: ${formatar(_c.investimento.value)}");
                          }),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoVendascumuladas(context);
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.store,
                            size: 100,
                          ),
                          Text(
                            "Neste Mês",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            if (_c.vendas.value == -1) {
                              return CircularProgressIndicator();
                            }
                            return Text(
                                "Total Estimado de Vendas: ${formatar(_c.vendas.value)}");
                          }),
                          Obx(() {
                            if (_c.lucros.value == -1) {
                              return CircularProgressIndicator();
                            }
                            return Text(
                                "Total Estimado de Lucro: ${formatar(_c.lucros.value)}");
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 260,
                            child: ModeloButao(
                              corButao: primaryColor,
                              corTitulo: Colors.white,
                              butaoHabilitado: true,
                              icone: Icons.remove_red_eye,
                              tituloButao: "Operações Acumuladas",
                              metodoChamadoNoClique: () {
                                _c.mostrarDialogoVendascumuladas(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.balance,
                            size: 100,
                          ),
                          Obx(() {
                            if (_c.saldo.value == -1) {
                              return CircularProgressIndicator();
                            }
                            return Text(
                                "Saldo ${_c.saldo.value >= 0 ? "Recebido" : "Tirado"}: ${formatar(_c.saldo.value <= 0 ? (_c.saldo.value * -1) : _c.saldo.value)}");
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 260,
                            child: ModeloButao(
                              corButao: primaryColor,
                              corTitulo: Colors.white,
                              butaoHabilitado: true,
                              icone: Icons.remove_red_eye,
                              tituloButao: "Operações Acumuladas",
                              metodoChamadoNoClique: () {
                                _c.mostrarDialogoSaldoAcumulado(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 260,
                            child: ModeloButao(
                              corButao: primaryColor,
                              corTitulo: Colors.white,
                              butaoHabilitado: true,
                              icone: Icons.remove_red_eye,
                              tituloButao: "Compras Acumuladas",
                              metodoChamadoNoClique: () {
                                _c.mostrarDialogoSaldoAcumulado(context,
                                    comprasAcomuladas: true);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
