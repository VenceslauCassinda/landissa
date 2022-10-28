import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../../dominio/entidades/venda.dart';
import '../../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../../componentes/item_item_venda.dart';

class LayoutDetalhesVenda extends StatelessWidget {
  const LayoutDetalhesVenda({
    Key? key,
    required this.venda,
  }) : super(key: key);
  final Venda venda;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      margin: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Detalhes da Venda",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(7)),
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 340,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total: ${venda.total}"),
                            Text(
                                "Total Pago: ${formatar((venda.pagamentos ?? []).fold<double>(0, (previousValue, element) => ((element.valor ?? 0) + previousValue)))} KZ"),
                            Container(width: 200, child: Divider()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (venda.pagamentos ?? [])
                                  .map((element) => Text(
                                      "${formatar(element.valor ?? 0)} KZ - Pago com ${element.formaPagamento?.descricao ?? "[Não Definido]"}"))
                                  .toList(),
                            ),
                            Container(width: 200, child: Divider()),
                            Visibility(
                              visible: venda.divida == true,
                              child: Text(
                                  "Por pagar: ${formatar((venda.total ?? 0) - (venda.parcela ?? 0))} KZ"),
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
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: venda.itensVenda!
                  .map((element) => ItemItemVenda(
                        element: element,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
