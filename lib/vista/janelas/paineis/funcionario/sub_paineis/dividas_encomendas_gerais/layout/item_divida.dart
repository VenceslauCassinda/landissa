import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/observadores/ObservadorCheckBox%20copy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';

import '../../../../../../../dominio/entidades/divida.dart';
import '../../../../../../../dominio/entidades/produto.dart';

class ItemDivida extends StatelessWidget {
  bool itemRemovivel = false;
  Function? metodoChamadoAoClicarItem;
  Function? metodoChamadoAoDesfazerDivida;
  Function? metodoChamadoAoRemoverItem;
  final Divida dado;
  late ObservadorCheckBox observadorCheckBox;
  final Future<Produto?> futurePegarProduto;
  final Future<Funcionario?> futurePegarFuncionario;
  final Future<Funcionario?> futurePegarFuncionarioPagante;
  final Future<Cliente?> futurePegarCliente;

  ItemDivida(
      {required this.dado,
      required this.itemRemovivel,
      this.metodoChamadoAoRemoverItem,
      this.metodoChamadoAoDesfazerDivida,
      this.metodoChamadoAoClicarItem,
      required this.futurePegarProduto,
      required this.futurePegarFuncionario,
      required this.futurePegarFuncionarioPagante,
      required this.futurePegarCliente}) {
    observadorCheckBox = ObservadorCheckBox();
    observadorCheckBox.mudarValor(dado.paga ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (metodoChamadoAoClicarItem != null) {
          metodoChamadoAoClicarItem!();
        }
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FutureBuilder<Cliente?>(
                      future: futurePegarCliente,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Text("Sem Registo!");
                        }
                        return Text("Cliente: ${snapshot.data?.nome}");
                      }),
                  FutureBuilder<Produto?>(
                      future: futurePegarProduto,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Text("Sem Registo!");
                        }
                        return Text("Produto devido: ${snapshot.data?.nome}");
                      }),
                  Text("Total: ${formatar(dado.total ?? 0)}"),
                  Text(
                      "Quantidade devida: ${formatarInteiroComMilhares(dado.quantidadeDevida ?? 0)}"),
                  Text("Data da divida: ${formatarData(dado.data!)}"),
                  Obx(() {
                    observadorCheckBox.valor.value;
                    return FutureBuilder<Funcionario?>(
                        future: futurePegarFuncionario,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Text("Sem Registo!");
                          }
                          return Text(
                              "Divida atendida por: ${snapshot.data?.nomeCompelto}");
                        });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: true,
                    child: Row(
                      children: [
                        Text("Divida Paga:"),
                        Obx(() {
                          return Checkbox(
                              value: observadorCheckBox.valor.value,
                              onChanged: (valor) async {
                                if (metodoChamadoAoClicarItem != null) {
                                  metodoChamadoAoClicarItem!();
                                }
                              });
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: dado.paga == true,
                    child: Obx(() {
                      observadorCheckBox.valor.value;
                      return Text(
                          "Data pagamento: ${formatarData(dado.dataPagamento!)}");
                    }),
                  ),
                  Visibility(
                    visible: dado.paga == true,
                    child: Obx(() {
                      observadorCheckBox.valor.value;
                      return FutureBuilder<Funcionario?>(
                          future: futurePegarFuncionarioPagante,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container();
                            }
                            return Text(
                                "Pagamento recebido por: ${snapshot.data?.nomeCompelto}");
                          });
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Obx(() {
                    observadorCheckBox.valor.value;
                    if (dado.paga == false) {
                      return Text(
                          "Total a pagar: ${formatar(dado.total ?? 0)}");
                    }
                    return Text("Total Pago: ${formatar(dado.total ?? 0)}");
                  }),
                ],
              ),
              Spacer(),
              Visibility(
                visible: itemRemovivel,
                child: InkWell(
                    onTap: () {
                      if (metodoChamadoAoRemoverItem != null) {
                        metodoChamadoAoRemoverItem!();
                      }
                    },
                    child: Icon(
                      Icons.delete,
                      color: primaryColor,
                    )),
                replacement: Container(),
              ),
              SizedBox(
                width: 20,
              ),
              Visibility(
                visible: metodoChamadoAoDesfazerDivida != null,
                child: InkWell(
                    onTap: () {
                      if (metodoChamadoAoDesfazerDivida != null) {
                        metodoChamadoAoDesfazerDivida!();
                      }
                    },
                    child: Icon(
                      Icons.undo,
                      color: primaryColor,
                    )),
                replacement: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
