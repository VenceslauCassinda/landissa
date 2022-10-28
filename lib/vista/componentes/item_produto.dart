import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';

import '../../dominio/entidades/produto.dart';
import '../../recursos/constantes.dart';
import '../janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos_c.dart';

class ItemProduto extends StatelessWidget {
  final Produto produto;
  Future<Stock?>? futurePegarStock;
  ProdutosC? c;
  ItemProduto({
    Key? key,
    required this.produto,
    this.futurePegarStock,
    this.c,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 100,
            height: 100,
            child: ImagemNoCirculo(
                Icon(
                  Icons.all_inbox_rounded,
                  color: primaryColor,
                  size: 60,
                ),
                20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * .10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${produto.nome}"),
                  Visibility(
                    visible: produto.stock == null,
                    replacement: Text(
                        "Quantidade: ${formatarInteiroComMilhares(produto.stock?.quantidade ?? 0)}"),
                    child: Visibility(
                      visible: futurePegarStock == null,
                      child: Text(
                          "Quantidade: ${formatarInteiroComMilhares(produto.stock?.quantidade ?? 0)}"),
                      replacement: FutureBuilder<Stock?>(
                          future: futurePegarStock,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const Text("Quantidade: Sem Registo");
                            }
                            return Text(
                                "Quantidade: ${formatarInteiroComMilhares(snapshot.data?.quantidade ?? 0)}");
                          }),
                    ),
                  ),
                  Visibility(
                      visible: c != null,
                      child: Text(
                          "Preço de Compra: ${formatar(produto.precoCompra ?? 0)}")),
                  // Visibility(
                  //   visible: c != null,
                  //   child: Text(
                  //       "Preço de Venda: ${produto.listaPreco!.isEmpty ? "Sem Preço" : formatar(produto.listaPreco![0])}"),
                  //   replacement: Text(
                  //       "Preço: ${produto.listaPreco!.isEmpty ? "Sem Preço" : formatar(produto.listaPreco![0])}"),
                  // ),
                ],
              ),
            ),
          ),
          Spacer(),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Receber",
                icone: Icons.call_received_sharp,
                metodoQuandoItemClicado: () {
                  c?.mostrarDialogoReceberCompleto(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Aumentar",
                icone: Icons.add,
                metodoQuandoItemClicado: () {
                  c?.mostrarDialogoAumentar(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Retirar",
                icone: Icons.remove,
                metodoQuandoItemClicado: () {
                  c?.mostrarDialogoRetirar(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Visibility(
            visible: c != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Preços",
                icone: Icons.monetization_on,
                metodoQuandoItemClicado: () {
                  c?.mostrarDialogoPrecosVenda(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Visibility(
            visible: c != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Entradas",
                icone: Icons.arrow_downward,
                metodoQuandoItemClicado: () {
                  c?.verEntradas(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Saídas",
                icone: Icons.arrow_upward,
                metodoQuandoItemClicado: () {
                  c?.verSaidas(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Visibility(
            visible: c != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Editar",
                icone: Icons.edit,
                metodoQuandoItemClicado: () {
                  c?.mostrarDialogoActualizarProduto(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 1 ||
                c?.indiceTabActual.value == 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Eliminar",
                icone: Icons.delete,
                metodoQuandoItemClicado: () {
                  c?.mostrarDialogoEliminarProduto(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Recuperar",
                icone: Icons.redo,
                metodoQuandoItemClicado: () {
                  c?.recuperarProduto(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Activar",
                icone: Icons.check,
                metodoQuandoItemClicado: () {
                  c?.activarProduto(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          Visibility(
            visible: c != null && c?.indiceTabActual.value == 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconeItem(
                titulo: "Desactivar",
                icone: Icons.check,
                metodoQuandoItemClicado: () {
                  c?.desactivarProduto(produto);
                },
                cor: primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
