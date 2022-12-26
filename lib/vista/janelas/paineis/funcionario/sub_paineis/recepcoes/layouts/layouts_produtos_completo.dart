import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';

import '../../../../../../componentes/item_produto.dart';
import '../../../../../../componentes/pesquisa.dart';

class LayoutProdutosCompleto extends StatelessWidget {
  RxList<Produto> produtos = <Produto>[].obs;
  final Function(Produto produto) aoClicarItem;
  final ManipularProdutoI manipularProdutoI;
  List<Produto>? lista;
  LayoutProdutosCompleto(
      {Key? key,
      required this.aoClicarItem,
      required this.manipularProdutoI,
      this.lista})
      : super(key: key) {
    if (lista != null) {
      produtos.addAll(lista!);
    }
    iniciar();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: LayoutPesquisa(
                accaoNaInsercaoNoCampoTexto: (dado) {
                  aoPesquisarProduto(dado);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (produtos.isEmpty) {
                  return Text("Sem Produtos!");
                }
                return ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: ((context, indice) {
                      return InkWell(
                        onLongPress: () {},
                        onTap: () {
                          aoClicarItem(produtos[indice]);
                        },
                        child: Container(
                          height: 80,
                          child: ItemProduto(
                            tamanhoIcon: 30,
                            produto: produtos[indice],
                            futurePegarStock: manipularProdutoI
                                .pegarStockDoProdutoDeId(produtos[indice].id!),
                          ),
                        ),
                      );
                    }));
              }),
            ),
          ],
        ));
  }

  void iniciar() async {
    if (produtos.isNotEmpty) {
      return;
    }
    produtosCopia.clear();
    var res = await manipularProdutoI.pegarLista();
    for (var cada in res) {
      produtos.add(cada);
    }
    produtosCopia.addAll(produtos);
  }

  var produtosCopia = <Produto>[];
  void aoPesquisarProduto(String f) {
    produtos.clear();
    for (var cada in produtosCopia) {
      if ((cada.nome ?? "")
          .toLowerCase()
          .toString()
          .contains(f.toLowerCase())) {
        produtos.add(cada);
      }
    }
  }
}
