import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/receccao.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';

class ItemRececcao extends StatelessWidget {
  final Receccao receccao;
  final bool visaoGeral;
  final Function aoClicar;
  Function(Receccao receccao)? aoPagar;
  late RxBool paga = RxBool(false);
  ItemRececcao({
    Key? key,
    required this.receccao,
    required this.aoClicar,
    this.aoPagar,
    required this.visaoGeral,
  }) : super(key: key) {
    paga.value = receccao.paga ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Produto: ${receccao.produto?.nome ?? "Nenhum"}"),
                Text(
                    "Quantidade: ${formatarInteiroComMilhares(receccao.quantidadeRecebida)}"),
                Text(
                    "Data da Entrada: ${receccao.data.toString().replaceAll(" ", " às ").replaceAll(".000", "")}"),
                Text(
                    "Recebido por: ${receccao.funcionario?.nomeCompelto ?? "Ninguem"}"),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: receccao.quantidadeLotes != 0,
                    child: Text(
                        "Preço do Lote: ${formatar(receccao.precoLote ?? 0)}")),
                Visibility(
                  visible: receccao.quantidadeLotes != 0,
                  child: Text(
                      "Quantidade de Lotes: ${formatarInteiroComMilhares(receccao.quantidadeLotes ?? 0)}"),
                ),
                Visibility(
                  visible: receccao.quantidadeLotes != 0,
                  child: Text(
                      "Quantidade de Unidades por Lote: ${formatarInteiroComMilhares(receccao.quantidadePorLotes ?? 0)}"),
                ),
                Visibility(
                  visible: receccao.quantidadeLotes != 0,
                  child: Text(
                      "Custo de Aquisição: ${formatar(receccao.custoAquisicao ?? 0)}"),
                ),
                Visibility(
                    visible: receccao.quantidadeLotes != 0,
                    child:
                        Text("Total Gasto: ${formatar(receccao.custoTotal)}")),
              ],
            ),
            Spacer(),
            Visibility(
              visible: (receccao.pagavel ?? false) == true &&
                  (receccao.paga ?? false) == true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Pago: ${formatar(receccao.custoTotal)}"),
                  Text(
                      "Data de Pagamento: ${receccao.dataPagamento == null ? "Sem Registo" : formatarData(receccao.dataPagamento!)}"),
                  Text(
                      "Pago Por: ${receccao.pagante?.nomeCompelto ?? "Sem Registo"}"),
                ],
              ),
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: (receccao.pagavel ?? false) == true &&
                          (receccao.paga ?? false) == false,
                      child:
                          Text("Por Pagar: ${formatar(receccao.custoTotal)}")),
                ],
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Obx(() {
              paga.value;
              return Visibility(
                visible: receccao.pagavel == true &&
                    (receccao.paga ?? false) == false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() {
                      paga.value;
                      return Transform.scale(
                        scale: 2.5,
                        child: Checkbox(
                            value: paga.value,
                            onChanged: (novo) {
                              paga.value = novo ?? false;
                              receccao.paga = true;
                              if (aoPagar != null) {
                                aoPagar!(receccao);
                              }
                            }),
                      );
                    }),
                    const Text("Pagar Recepção"),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
