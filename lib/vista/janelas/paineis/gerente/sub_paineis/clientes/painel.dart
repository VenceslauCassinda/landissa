import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/vista/componentes/item_saida_caixa.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/saida_caixa/painel_c.dart';

import '../../../../../../dominio/entidades/painel_actual.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../componentes/item_dinheiro_sobra.dart';
import '../../../../../componentes/pesquisa.dart';
import 'painel_c.dart';

class PainelClientes extends StatelessWidget {
  late Funcionario funcionario;
  late var c;
  late PainelClientesC _clientesC;
  Function? accaoAoVoltar;

  PainelClientes(this.c, this.funcionario, {this.accaoAoVoltar}) {
    iniciarDependencias();
  }

  void iniciarDependencias() {
    try {
      _clientesC = Get.find();
      _clientesC.funcionario = funcionario;
    } catch (e) {
      _clientesC = Get.put(PainelClientesC(funcionario));
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
            _clientesC.aoPesquisar(dado);
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                "CLIENTES",
                style: TextStyle(color: primaryColor, fontSize: 30),
              ),
              Spacer(),
              Container(
                width: 250,
                child: Visibility(
                  visible:
                      _clientesC.funcionario.nivelAcesso == NivelAcesso.GERENTE,
                  child: ModeloButao(
                    corButao: primaryColor,
                    icone: Icons.delete,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Limpar",
                    metodoChamadoNoClique: () {
                      _clientesC.mostrarDialogoLimpar(context);
                    },
                  ),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx((() {
              return ListView.builder(
                  itemCount: _clientesC.lista.length,
                  itemBuilder: (c, i) => Stack(
                        children: [
                          ModeloItemLista(
                            tituloItem: _clientesC.lista[i].nome ?? "",
                            itemRemovivel: _clientesC.funcionario.nivelAcesso ==
                                NivelAcesso.GERENTE,
                            metodoChamadoAoRemoverItem: () {
                              _clientesC
                                  .mostrarDialodoRemover(_clientesC.lista[i]);
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: FutureBuilder<double>(
                                  future: _clientesC
                                      .pegarDividaCliente(_clientesC.lista[i]),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return const Text("...");
                                    }
                                    return Text(
                                        "Dívida: ${formatar(snapshot.data!)}");
                                  }),
                            ),
                          ),
                        ],
                      ));
            })),
          ),
        ),
        Visibility(
          visible: _clientesC.funcionario.nivelAcesso == NivelAcesso.GERENTE,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ModeloButao(
              corButao: primaryColor,
              corTitulo: Colors.white,
              butaoHabilitado: true,
              tituloButao: "Novo Cliente",
              metodoChamadoNoClique: () {
                _clientesC.mostrarDialogoNovaValor(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
