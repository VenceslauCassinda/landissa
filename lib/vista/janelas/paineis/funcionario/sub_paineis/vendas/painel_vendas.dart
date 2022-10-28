import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/tabelas/tabela_definicoes.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/painel_funcionario_c.dart';

import '../../../../../../../recursos/constantes.dart';
import '../../../../../componentes/pesquisa.dart';
import 'layouts/grosso/layout_entidade_grosso.dart';
import 'layouts/retalho/mesa_vendas_retalho.dart';
import 'layouts/vendas_c.dart';

class PainelVendas extends StatelessWidget {
  PainelVendas({
    Key? key,
    required this.data,
    required this.permissao,
    required this.funcionario,
    this.accaoAoVoltar,
    this.aoTerminarSessao,
    this.funcionarioC,
  }) {
    initiC();
  }

  PainelFuncionarioC? funcionarioC;

  final bool permissao;
  Function? accaoAoVoltar;
  Function? aoTerminarSessao;
  late VendasC _c;
  final DateTime data;
  final Funcionario? funcionario;

  initiC() {
    try {
      _c = Get.find();
      _c.data = data;
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(VendasC(data, funcionario));
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
              accaoNaInsercaoNoCampoTexto: (dado) {
                _c.aoPesquisarVenda(dado);
              },
              accaoAoSair: aoTerminarSessao,
              accaoAoVoltar: accaoAoVoltar),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Obx(() {
            return Text(
              "CAIXA: ${formatar(_c.totalCaixa.value)} KZ",
              style: const TextStyle(color: primaryColor, fontSize: 30),
            );
          }),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Obx(() {
            return Text(
              "RECEPÇÕES PAGAS: ${formatar(_c.receccoesPagas.value)} KZ",
              style: const TextStyle(color: primaryColor, fontSize: 30),
            );
          }),
        ),
        FutureBuilder<int>(
            future: _c.pegarTipoNegocio(),
            builder: (context, snapshot) {
              if (snapshot.data == TipoNegocio.RETALHO) {
                return Container();
              }
              return Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "DINHEIRO FÍSICO: ${formatar(_c.lista.fold<double>(0, (antigoV, cadaV) => ((cadaV.pagamentos ?? []).fold<double>(0, (antigoP, cadaP) {
                            if (cadaP.valor == null) {
                              return 0;
                            }
                            if ((cadaP.formaPagamento?.descricao ?? "")
                                    .toLowerCase()
                                    .contains('CASH'.toLowerCase()) ==
                                true) {
                              return (cadaP.valor ?? 0) + antigoP;
                            }
                            return antigoP;
                          }) + antigoV)))} KZ",
                      style: const TextStyle(color: primaryColor, fontSize: 30),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "DINHEIRO DIGITAL: ${formatar(_c.lista.fold<double>(0, (antigoV, cadaV) => ((cadaV.pagamentos ?? []).fold<double>(0, (antigoP, cadaP) {
                            if (cadaP.valor == null) {
                              return 0;
                            }
                            if ((cadaP.formaPagamento?.descricao ?? "")
                                    .toLowerCase()
                                    .contains('CASH'.toLowerCase()) ==
                                false) {
                              mostrar(cadaP.formaPagamento?.descricao);
                              mostrar(cadaP.valor);
                              return (cadaP.valor ?? 0) + antigoP;
                            }
                            return antigoP;
                          }) + antigoV)))} KZ",
                      style: const TextStyle(color: primaryColor, fontSize: 30),
                    ),
                  ),
                ],
              );
            }),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Obx(
            () => Text(
              "DÍVIDAS PAGAS: ${formatar(_c.totalDividaPagas.value)} KZ",
              style: const TextStyle(color: primaryColor, fontSize: 30),
            ),
          ),
        ),
        FutureBuilder<int>(
            future: _c.pegarTipoNegocio(),
            builder: (context, snapshot) {
              if (snapshot.data == TipoNegocio.RETALHO) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(data.day == DateTime.now().day && data.month == DateTime.now().month && data.year == DateTime.now().year) ? "HOJE" : "DATA"} - ${formatarMesOuDia(data.day)}/${formatarMesOuDia(data.month)}/${data.year}",
                        style:
                            const TextStyle(color: primaryColor, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        if (_c.lista.isEmpty) {
                          return Column(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .385,
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: MesaVendaRetalho(
                                      _c.lista, permissao, _c)),
                              const SizedBox(
                                height: 80,
                              ),
                              const Text("Nenhuma Venda!"),
                            ],
                          );
                        }
                        return Container(
                            height: MediaQuery.of(context).size.height * .500,
                            width: MediaQuery.of(context).size.width - 40,
                            child: MesaVendaRetalho(_c.lista, permissao, _c));
                      }),
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
        FutureBuilder<int>(
            future: _c.pegarTipoNegocio(),
            builder: (context, snapshot) {
              if (snapshot.data == TipoNegocio.RETALHO) {
                return Row(
                  children: [
                    Visibility(
                      visible: permissao,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: 200,
                        child: ModeloButao(
                          corButao: primaryColor,
                          icone: Icons.arrow_circle_down,
                          corTitulo: Colors.white,
                          butaoHabilitado: true,
                          tituloButao: "Recepções",
                          metodoChamadoNoClique: () {
                            funcionarioC?.irParaPainel(PainelActual.RECEPCOES);
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: permissao,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: 200,
                        child: ModeloButao(
                          corButao: primaryColor,
                          icone: Icons.store,
                          corTitulo: Colors.white,
                          butaoHabilitado: true,
                          tituloButao: "Vendas",
                          metodoChamadoNoClique: () {
                            _c.escolherData(context, funcionarioC!);
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: permissao,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: 200,
                        child: ModeloButao(
                          corButao: primaryColor,
                          icone: Icons.add,
                          corTitulo: Colors.white,
                          butaoHabilitado: true,
                          tituloButao: "Adicionar Produto",
                          metodoChamadoNoClique: () {
                            _c.mostrarDialogoProdutos(context);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container(
                margin: const EdgeInsets.all(20),
                child: ModeloButao(
                  corButao: primaryColor,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  tituloButao: "Adicionar Venda",
                  metodoChamadoNoClique: () {
                    _c.mostrarDialogoNovaVenda(context);
                  },
                ),
              );
            }),
      ],
    );
  }
}
