import 'package:flutter/material.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';

class ItemSaida extends StatelessWidget {
  final Saida saida;
  final bool visaoGeral;
  final Function aoClicar;
  ItemSaida({
    Key? key,
    required this.saida,
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
                child: Text("Produto: ${saida.produto?.nome ?? "Nenhum"}")),
            Text("Quantidade: ${saida.quantidade ?? 0}"),
            Text(
                "Data da Saída: ${saida.data.toString().replaceAll(" ", " às ").replaceAll(".000", "")}"),
            Text("Motivo: ${saida.motivo ?? "Sem Motivo"}"),
          ],
        ),
      ),
    );
  }
}
