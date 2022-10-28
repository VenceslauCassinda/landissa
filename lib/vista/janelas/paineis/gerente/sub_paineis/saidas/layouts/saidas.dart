import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/vista/componentes/item_saida.dart';
import '../../../../../../componentes/item_entrada.dart';
import 'saidas_c.dart';

class LayoutSaidas extends StatelessWidget {
  late SaidasC _c;
  final bool visaoGeral;
  LayoutSaidas({required this.visaoGeral}) {
    _c = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_c.lista.isEmpty) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(child: Text("Sem Dados!")),
              ],
            ),
          );
        }
        var itens = _c.lista
            .map((saida) => ItemSaida(
                  visaoGeral: visaoGeral,
                  saida: saida,
                  aoClicar: () {},
                ))
            .toList();
        return Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: itens.length, itemBuilder: (c, i) => itens[i])),
        );
      },
    );
  }
}
