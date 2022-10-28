import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import '../../dominio/entidades/produto.dart';
import '../../recursos/constantes.dart';
import '../janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos_c.dart';

class ItemInvestimento extends StatelessWidget {
  final Produto produto;
  var c;
  ItemInvestimento({
    Key? key,
    required this.produto,
    required this.c,
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
            child: const ImagemNoCirculo(
                Icon(
                  Icons.all_inbox_rounded,
                  color: primaryColor,
                  size: 60,
                ),
                20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nome: ${produto.nome}"),
                Text("Quantidade: ${produto.stock?.quantidade ?? 0}"),
                Text(
                    "Investimento: ${formatar((produto.stock?.quantidade ?? 0) * (produto.precoCompra ?? 0))} KZ"),
                Visibility(
                    visible: c != null,
                    child: Text(
                        "Preço de Compra: ${formatar(produto.precoCompra ?? 0)}")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
