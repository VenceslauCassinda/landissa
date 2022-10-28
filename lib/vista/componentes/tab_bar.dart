import 'package:flutter/material.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

import '../../../../../recursos/constantes.dart';

class ModeloTabBar extends StatelessWidget {
  final List<String> listaItens;
  final Function(int indiceTab) accao;
  final int indiceTabInicial;

  const ModeloTabBar(
      {Key? key,
      required this.listaItens,
      required this.accao,
      required this.indiceTabInicial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          tabBarTheme: const TabBarTheme(
              indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              labelColor: branca,
              unselectedLabelColor: primaryColor)),
      child: DefaultTabController(
        length: listaItens.length,
        initialIndex: indiceTabInicial,
        child: TabBar(
            onTap: (valor) async {
              accao(valor);
            },
            tabs: listaItens
                .map((e) => Tab(
                      child: Text(
                        "$e",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
