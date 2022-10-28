import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/selector_numero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yetu_gestor/recursos/constantes.dart';

import '../../dominio/entidades/item_venda.dart';
import '../../solucoes_uteis/formato_dado.dart';
import '../janelas/paineis/funcionario/sub_paineis/vendas/layouts/mesa_venda/mesa_venda_c.dart';

class ItemItemVenda extends StatelessWidget {
  ItemItemVenda({
    Key? key,
    this.controladores,
    this.c,
    required this.element,
  });

  Map<String, TextEditingController>? controladores;
  MesaVendaC? c;
  final ItemVenda element;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .1,
                margin: EdgeInsets.only(left: 10),
                child: Text(element.produto!.nome!),
              ),
              const SizedBox(
                width: 20,
              ),
              Text("Quantidade: "),
              Visibility(
                visible: c != null,
                child: NumberTextField(
                  controller: controladores?["${element.idProduto}1"],
                  arrowsWidth: 40,
                  arrowsHeight: 25,
                  contentPadding: EdgeInsets.all(4),
                  aoDigitar: (valor) {
                    c!.definirQuantidade(
                      valor,
                      element,
                      controladores!["${element.idProduto}1"]!,
                      controladores!["${element.idProduto}2"]!,
                    );
                  },
                ),
                replacement: Text("${element.quantidade}"),
              ),
              const SizedBox(
                width: 20,
              ),
              Text("Desconto(%): "),
              Visibility(
                visible: c != null,
                child: Container(
                  height: 30,
                  width: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controladores?["${element.idProduto}2"],
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    onChanged: (valor) {
                      c!.descontar(
                        int.tryParse(valor),
                        element,
                        controladores!["${element.idProduto}2"]!,
                      );
                    },
                  ),
                ),
                replacement: Text("${element.desconto}"),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                child: Text("Total: ${formatar(element.total ?? 0)} KZ"),
              ),
              Spacer(),
              Visibility(
                visible: c != null,
                child: IconeItem(
                  metodoQuandoItemClicado: () {
                    c!.removerItemVenda(element);
                  },
                  icone: Icons.delete,
                  titulo: "",
                  cor: primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
