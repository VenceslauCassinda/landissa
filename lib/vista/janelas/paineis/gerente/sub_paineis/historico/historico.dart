import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';

import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_gerente_c.dart';
import 'historico_c.dart';

class PainelHistorico extends StatelessWidget {
  PainelHistorico({
    Key? key,
    required PainelGerenteC c,
    this.funcionario,
    this.accaoAoVoltar,
  })  : _funcionarioC = c,
        super(key: key) {
    initiC();
  }

  late HistoricoC _c;
  final PainelGerenteC _funcionarioC;
  final Funcionario? funcionario;
  Function? accaoAoVoltar;

  initiC() {
    try {
      _c = Get.find();
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(HistoricoC(funcionario));
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 10, right: 25),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 4,
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
                          Text("Caixa Atual: ${formatar(_c.caixaAtual.value)}"),
                          Text(
                              "Entradas de Caixa Acumuladas: ${formatar(_c.totalEntradaCaixa.value)}"),
                          Text(
                              "Saídas de Caixa Acumuladas: ${formatar((_c.totalSaidaCaixa.value * -1))}"),
                        ],
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     _c.pegarProdutosMaisSaidos();
                  //   },
                  //   child: Card(
                  //     elevation: 6,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.arrow_upward,
                  //           size: 100,
                  //         ),
                  //         Text("10 Produtos com maior Saída"),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          Text(
                              "Investimento Atual: ${formatar(_c.investimento.value)}"),
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
                            Icons.store,
                            size: 100,
                          ),
                          Text(
                              "Total Estimado de Vendas: ${formatar(_c.vendas.value)}"),
                          Text(
                              "Total Estimado de Lucro: ${formatar(_c.lucros.value)}"),
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
                            Icons.monetization_on,
                            size: 100,
                          ),
                          Text("Saldo: ${formatar(_c.saldo.value)}"),
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
