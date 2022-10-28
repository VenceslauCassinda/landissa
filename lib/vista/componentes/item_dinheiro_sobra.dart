import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/dinheiro_sobra.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/entradas/layouts/entradas_c.dart';

import '../../dominio/entidades/estado.dart';
import '../../dominio/entidades/funcionario.dart';
import '../../recursos/constantes.dart';
import '../../solucoes_uteis/formato_dado.dart';
import '../janelas/paineis/gerente/painel_gerente_c.dart';

class ItemDinheiroSobra extends StatelessWidget {
  final DinheiroSobra dinheiroSobra;
  final bool visaoGeral;
  final Function aoClicar;
  Function? aoRemover;
  ItemDinheiroSobra({
    Key? key,
    required this.dinheiroSobra,
    required this.aoClicar,
    required this.visaoGeral,
    this.aoRemover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Valor: ${formatar(dinheiroSobra.valor ?? 0)} KZ"),
                Text(
                    "Data: ${dinheiroSobra.data.toString().replaceAll(" ", " às ").replaceAll(".000", "")}"),
                Text(
                    "Por: ${dinheiroSobra.funcionario?.nomeCompelto ?? "Ninguem"}"),
              ],
            ),
            Spacer(),
            Visibility(
              visible: visaoGeral == true,
              child: IconeItem(
                  metodoQuandoItemClicado: () {
                    aoRemover!();
                  },
                  icone: Icons.delete,
                  tamanho: 30,
                  cor: primaryColor,
                  titulo: "Remover"),
            )
          ],
        ),
      ),
    );
  }
}
