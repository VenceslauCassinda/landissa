import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';

import '../../dominio/entidades/produto.dart';
import '../../recursos/constantes.dart';
import '../janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos_c.dart';

class ItemProduto extends StatelessWidget {
  final Produto produto;
  Future<Stock?>? futurePegarStock;
  ProdutosC? c;
  double? tamanhoIcon;
  ItemProduto({
    Key? key,
    required this.produto,
    this.futurePegarStock,
    this.tamanhoIcon,
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
            width: Responsidade.isMobile(context)
                ? 50
                : tamanhoIcon == null
                    ? 100
                    : (tamanhoIcon! + 20),
            height: 100,
            child: ImagemNoCirculo(
                Icon(
                  Icons.all_inbox_rounded,
                  color: primaryColor,
                  size: Responsidade.isMobile(context) ? 30 : tamanhoIcon ?? 60,
                ),
                20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * .18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${produto.nome}"),
                  Visibility(
                    visible: produto.stock != null,
                    child: Text(
                        "Quantidade: ${formatarInteiroComMilhares(produto.stock?.quantidade ?? 0)}"),
                    replacement: Visibility(
                      visible: futurePegarStock != null,
                      child: FutureBuilder<Stock?>(
                          future: futurePegarStock,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Text("Quantidade: 0");
                            }
                            return Text(
                                "Quantidade: ${formatarInteiroComMilhares(snapshot.data?.quantidade ?? 0)}");
                          }),
                      replacement: Text("Quantidade: 0"),
                    ),
                  ),
                  Visibility(
                      visible: c != null,
                      child: Text(
                          "Preço de Compra: ${formatar(produto.precoCompra ?? 0)}")),
                ],
              ),
            ),
          ),
          Spacer(),
          Visibility(
            visible: c != null,
            child: Visibility(
              visible: !Responsidade.isMobile(context),
              child: LayoutStock(c: c, produto: produto),
              replacement: PopupStock(c: c, produto: produto),
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
            child: Visibility(
              visible: !Responsidade.isMobile(context),
              child: LayoutFluxo(c: c, produto: produto),
              replacement: Column(
                children: [
                  PopupFluxo(c: c, produto: produto),
                  PopupGestao(c: c, produto: produto),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Visibility(
            visible: c != null,
            child: Visibility(
              visible: !Responsidade.isMobile(context),
              child: LayoutGerirProduto(c: c, produto: produto),
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

class PopupStock extends StatelessWidget {
  const PopupStock({
    Key? key,
    required this.c,
    required this.produto,
  }) : super(key: key);

  final ProdutosC? c;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: Row(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text("Stock"), Icon(Icons.arrow_drop_down)],
              ),
            ),
          ),
        ],
      ),
      onSelected: ((value) {
        if (value == 0) {
          c?.mostrarDialogoReceberCompleto(produto);
          return;
        }
        if (value == 1) {
          c?.mostrarDialogoAumentar(produto);
          return;
        }
        if (value == 2) {
          c?.mostrarDialogoRetirar(produto);
          return;
        }
      }),
      itemBuilder: ((context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Row(
              children: [
                Text("Receber"),
                Spacer(),
                Icon(Icons.call_received_sharp)
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [Text("Aumentar"), Spacer(), Icon(Icons.add)],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [Text("Retirar"), Spacer(), Icon(Icons.remove)],
            ),
          ),
        ];
      }),
    );
  }
}

class PopupGestao extends StatelessWidget {
  const PopupGestao({
    Key? key,
    required this.c,
    required this.produto,
  }) : super(key: key);

  final ProdutosC? c;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: Row(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text("Gerir"), Icon(Icons.arrow_drop_down)],
              ),
            ),
          ),
        ],
      ),
      onSelected: ((value) {
        if (value == 0) {
          c?.mostrarDialogoActualizarProduto(produto);
          return;
        }
        if (value == 1) {
          c?.mostrarDialogoEliminarProduto(produto);
          return;
        }
        if (value == 2) {
          c?.desactivarProduto(produto);
          return;
        }
      }),
      itemBuilder: ((context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Row(
              children: [Text("Editar"), Spacer(), Icon(Icons.edit)],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [Text("Eliminar"), Spacer(), Icon(Icons.delete)],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [Text("Desactivar"), Spacer(), Icon(Icons.check)],
            ),
          ),
        ];
      }),
    );
  }
}

class PopupFluxo extends StatelessWidget {
  const PopupFluxo({
    Key? key,
    required this.c,
    required this.produto,
  }) : super(key: key);

  final ProdutosC? c;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: Row(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text("Fluxo"), Icon(Icons.arrow_drop_down)],
              ),
            ),
          ),
        ],
      ),
      onSelected: ((value) {
        if (value == 0) {
          c?.verEntradas(produto);
          return;
        }
        if (value == 1) {
          c?.verSaidas(produto);
          return;
        }
      }),
      itemBuilder: ((context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Row(
              children: [
                Text("Entradas"),
                Spacer(),
                Icon(Icons.arrow_downward)
              ],
            ),
            onTap: () {},
          ),
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [Text("Saídas"), Spacer(), Icon(Icons.arrow_upward)],
            ),
          ),
        ];
      }),
    );
  }
}

class LayoutGerirProduto extends StatelessWidget {
  const LayoutGerirProduto({
    Key? key,
    required this.c,
    required this.produto,
  }) : super(key: key);

  final ProdutosC? c;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
      ],
    );
  }
}

class LayoutFluxo extends StatelessWidget {
  const LayoutFluxo({
    Key? key,
    required this.c,
    required this.produto,
  }) : super(key: key);

  final ProdutosC? c;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
      ],
    );
  }
}

class LayoutStock extends StatelessWidget {
  const LayoutStock({
    Key? key,
    required this.c,
    required this.produto,
  }) : super(key: key);

  final ProdutosC? c;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
      ],
    );
  }
}
