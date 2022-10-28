import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/vendas/layouts/vendas_c.dart';

import '../../dominio/entidades/item_venda.dart';
import '../../dominio/entidades/venda.dart';
import '../../recursos/constantes.dart';

class ItemModeloVenda extends StatelessWidget {
  ItemModeloVenda({
    Key? key,
    required this.c,
    required this.permissao,
    required this.venda,
  }) : super(key: key);

  final c;
  final Venda venda;
  late bool permissao;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 340,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: c.indiceTabActual == 0,
                            child: Text(
                                "Tipo de Item: ${venda.venda ? "Venda" : (venda.encomenda ? "Encomenda" : "Dívida")}"),
                          ),
                          Text(mostrarCadaProduto(venda.itensVenda ?? [])),
                          Text("Total: ${formatar(venda.total!)} KZ"),
                          Visibility(
                            visible: c.indiceTabActual != 1,
                            child: Obx(
                              () {
                                c.lista.isEmpty;
                                return Text(
                                    "Total Pago: ${formatar((venda.pagamentos ?? []).fold<double>(0, (previousValue, element) => ((element.valor ?? 0) + previousValue)))} KZ");
                              },
                            ),
                          ),
                          Visibility(
                            visible: venda.divida == true,
                            child: Obx(
                              () {
                                c.lista.isEmpty;
                                return Text(
                                    "Por pagar: ${formatar(venda.total! - venda.parcela!)} KZ");
                              },
                            ),
                            replacement: Row(
                              children: [
                                Text("Paga"),
                                Icon(
                                  Icons.check_box,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                              visible:
                                  venda.encomenda == true && permissao == true,
                              child: Text(
                                  "Data de Levantamento: ${formatarMesOuDia(venda.dataLevantamentoCompra?.day ?? "")}/${formatarMesOuDia(venda.dataLevantamentoCompra?.month ?? "")}/${venda.dataLevantamentoCompra?.year ?? ""} às ${formatarMesOuDia(venda.dataLevantamentoCompra?.hour ?? "")}h e ${formatarMesOuDia(venda.dataLevantamentoCompra?.minute ?? "")}min")),
                          Text(
                              "Data: ${formatarMesOuDia(venda.data?.day ?? "")}/${formatarMesOuDia(venda.data?.month ?? "")}/${venda.data?.year ?? ""}")
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 200,
                            child: Text(
                                "Cliente: ${venda.cliente?.nome ?? "Sem nome"}")),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                            "Telefone: ${venda.cliente?.numero ?? "Sem Número"}"),
                      ],
                    ),
                    Visibility(
                      visible: venda.encomenda == true && permissao == true,
                      child: IconeItem(
                        metodoQuandoItemClicado: () {
                          c.mostraDialogoEntregarEncomenda(venda);
                        },
                        icone: Icons.swipe_up,
                        titulo: "Entregar\nEncomenda",
                        cor: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: venda.divida == true && permissao == true,
                      child: IconeItem(
                        metodoQuandoItemClicado: () {
                          c.mostrarFormasPagamento(venda, context,
                              comPagamentoFinal: true);
                        },
                        icone: Icons.monetization_on_outlined,
                        titulo: "Finallizar\nPagamento",
                        cor: primaryColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Spacer(),
            IconeItem(
                metodoQuandoItemClicado: () {
                  c.mostrarDialogoDetalhesVenda(venda);
                },
                icone: Icons.list,
                titulo: "Detalhes")
          ],
        ),
      ),
    );
  }

  String mostrarCadaProduto(List<ItemVenda> itensVenda) {
    var dado = "";
    if (itensVenda.isEmpty) {
      return "Sem Produtos";
    }
    if (itensVenda.length == 1) {
      return "Produto: ${itensVenda[0].produto!.nome!}";
    }
    for (var cada in itensVenda) {
      dado += "${cada.produto!.nome!}, ";
    }
    return "Produtos: $dado";
  }
}
