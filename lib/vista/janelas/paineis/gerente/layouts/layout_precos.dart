import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/layouts/layout_adicionar_preco.dart';
import '../../../../../dominio/entidades/preco.dart';
import '../../../../../dominio/entidades/produto.dart';
import '../../../../../recursos/constantes.dart';
import '../sub_paineis/produtos/layouts/produtos_c.dart';

class LayoutPrecos extends StatelessWidget {
  final ProdutosC produtosC;
  final Produto produto;
  const LayoutPrecos({
    Key? key,
    required this.precos,
    required this.produtosC,
    required this.produto,
  }) : super(key: key);

  final RxList<Preco> precos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Preço"),
              Text("Quantidade"),
              Text("Eliminar"),
            ],
          ),
        ),
        Divider(),
        Obx(() {
          if (precos.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Sem Dados!"),
                )),
              ],
            );
          }
          return Column(
            children: List.generate(
                precos.length,
                (indice) => CadaPreco(
                      precos: precos,
                      produto: produto,
                      indice: indice,
                      accaoAoEliminar: () {
                        produtosC.removerPrecoProduto(produto, precos[indice]);
                        precos.removeWhere(
                            (element) => element.preco == precos[indice].preco);
                      },
                    )),
          );
        }),
        Container(
          margin: const EdgeInsets.all(20),
          child: ModeloButao(
            corButao: primaryColor,
            icone: Icons.add,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Adicionar Preço",
            metodoChamadoNoClique: () {
              mostrarDialogoDeLayou(LayoutAdicionarPreco(
                produtosC: produtosC,
                produto: produto,
                precos: precos,
              ));
            },
          ),
        ),
      ],
    );
  }
}

class CadaPreco extends StatelessWidget {
  const CadaPreco({
    Key? key,
    required this.precos,
    required this.produto,
    required this.indice,
    required this.accaoAoEliminar,
  }) : super(key: key);

  final RxList<Preco> precos;
  final int indice;
  final Produto produto;
  final Function accaoAoEliminar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatar(precos[indice].preco ?? 0)),
              Text(formatarInteiroComMilhares(precos[indice].quantidade ?? 0)),
              IconeItem(
                  metodoQuandoItemClicado: () {
                    accaoAoEliminar();
                  },
                  icone: Icons.delete,
                  titulo: ""),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
