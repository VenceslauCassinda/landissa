import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import '../../../../../../componentes/item_modelo_venda.dart';
import 'vendas_c.dart';

class LayoutVendas extends StatelessWidget {
  late VendasC _c;
  final bool visaoGeral;
  LayoutVendas({required this.visaoGeral}) {
    _c = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var itens = _c.lista
            .map((venda) => ItemModeloVenda(
                  permissao: visaoGeral,
                  c: _c,
                  venda: venda,
                ))
            .toList();
        if (itens.isEmpty) {
          return const Center(child: Text("Sem Vendas!"));
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: itens.length, itemBuilder: (c, i) => itens[i]),
        );
      },
    );
  }
}
