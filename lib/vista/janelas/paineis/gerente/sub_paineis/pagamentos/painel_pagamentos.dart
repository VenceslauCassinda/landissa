import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/item_pagamento.dart';
import '../../../../../componentes/tab_bar.dart';
import '../../../../../componentes/pesquisa.dart';
import 'pagamentos_c.dart';

class PainelPagamentos extends StatelessWidget {
  late PagamentosC _c;
  Function? accaoAoVoltar;
  PainelPagamentos({Key? key, this.accaoAoVoltar}) {
    initiC();
  }

  initiC() {
    try {
      _c = Get.find();
    } catch (e) {
      _c = Get.put(PagamentosC());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 62),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {},
            accaoAoSair: () {
              _c.terminarSessao();
            },
            accaoAoVoltar: () {
              accaoAoVoltar!();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text(
                "FORMAS DE PAGAMENTO",
                style: TextStyle(color: primaryColor),
              ),
              Spacer(),
              Expanded(
                  child: ModeloTabBar(
                listaItens: [],
                indiceTabInicial: 0,
                accao: (indice) {},
              ))
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _c.lista
                      .map((forma) => InkWell(
                            onTap: () {},
                            child: ItemPagamento(
                              formaPagamento: forma,
                              c: _c,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        Container(
          // width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child: ModeloButao(
            corButao: primaryColor,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            icone: Icons.add,
            tituloButao: "Forma de Pagamento",
            metodoChamadoNoClique: () {
              _c.mostrarDialogoAdicionarFormaPagamento();
            },
          ),
        ),
      ],
    );
  }
}
