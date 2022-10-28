import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/entradas/layouts/entradas_c.dart';

import '../../dominio/entidades/estado.dart';
import '../../dominio/entidades/funcionario.dart';
import '../../recursos/constantes.dart';
import '../janelas/paineis/gerente/painel_gerente_c.dart';

class ItemEntrada extends StatelessWidget {
  final Entrada entrada;
  final bool visaoGeral;
  final Function aoClicar;
  ItemEntrada({
    Key? key,
    required this.entrada,
    required this.aoClicar,
    required this.visaoGeral,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: visaoGeral,
                child: Text("Produto: ${entrada.produto?.nome ?? "Nenhum"}")),
            Text("Quantidade: ${entrada.quantidade ?? 0}"),
            Text(
                "Data da Entrada: ${entrada.data.toString().replaceAll(" ", " às ").replaceAll(".000", "")}"),
            Text("Motivo: ${entrada.motivo ?? "Sem Motivo"}"),
          ],
        ),
      ),
    );
  }
}
