import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:flutter/material.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import '../../dominio/entidades/saida_caixa.dart';
import '../../recursos/constantes.dart';

class ItemSaidaCaixa extends StatelessWidget {
  final SaidaCaixa saidaCaixa;
  final bool visaoGeral;
  final Function aoClicar;
  Function? aoRemover;
  ItemSaidaCaixa({
    Key? key,
    required this.saidaCaixa,
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
                Text("Valor: ${formatar(saidaCaixa.valor ?? 0)} KZ"
                    .replaceAll("-", "")),
                Text("Motivo: ${saidaCaixa.motivo ?? "Nenhum"}"),
                Text(
                    "Data: ${saidaCaixa.data.toString().replaceAll(" ", " às ").replaceAll(".000", "")}"),
                Text(
                    "Tipo de Operação: ${formatar(saidaCaixa.valor ?? 0).toString().contains("-") ? "Saída de Caixa" : "Entrada de Caixa"}"),
                Text(
                    "Operação realizada por: ${saidaCaixa.funcionario?.nomeCompelto ?? "Ninguem"}"),
              ],
            ),
            const Spacer(),
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
