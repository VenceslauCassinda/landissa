import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/componentes/item_investimento.dart';
import '../../../../../../dominio/entidades/painel_actual.dart';
import '../../../../../../dominio/entidades/pdf_page.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/tab_bar.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_gerente_c.dart';
import 'painel_c.dart';

class PainelRelatorio extends StatelessWidget {
  late PainelRelatorioC _c;
  final PainelGerenteC gerenteC;
  PainelRelatorio({
    Key? key,
    required this.gerenteC,
  }) {
    initiC();
  }

  initiC() {
    try {
      _c = Get.find();
    } catch (e) {
      _c = Get.put(PainelRelatorioC());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {},
            accaoAoSair: () {
              _c.terminarSessao();
            },
            accaoAoVoltar: () {
              gerenteC.irParaPainel(PainelActual.FUNCIONARIOS);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text(
                "RELATÓRIOS",
                style: TextStyle(color: primaryColor),
              )
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            _c.lista.isEmpty;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 4,
                    mainAxisSpacing: 10),
                children: [
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoGerarRelatorioEntrada(context);
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            size: 100,
                          ),
                          Text("Relatório de Entradas"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoGerarRelatorioSaidas(context);
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 100,
                          ),
                          Text("Relatório de Saídas"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoGerarRelatorioExistencial(context);
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.view_quilt_rounded,
                            size: 100,
                          ),
                          Text("Relatório de Existência"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoGerarRelatorioVendas(context);
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
                          Text("Relatório de Vendas"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoGerarRelatorioInvestimento(context);
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 100,
                          ),
                          Text("Relatório de Investimento"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _c.mostrarDialogoGerarRelatorioCaixa(context);
                    },
                    child: Card(
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.money,
                            size: 100,
                          ),
                          Text("Relatório de Caixa"),
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
