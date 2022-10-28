import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/preco.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import '../../../../../../../../dominio/entidades/venda.dart';
import '../vendas_c.dart';

class MesaVendaRetalho extends StatelessWidget {
  final bool subJanelaComPermissao;
  List<Venda> listaVendas;
  VendasC vendasC;

  MesaVendaRetalho(this.listaVendas, this.subJanelaComPermissao, this.vendasC,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: primaryColor,
          height: 2,
        ),
        CabecalhoTabela(
          subJanelaComPermissao: subJanelaComPermissao,
        ),
        const Divider(
          color: primaryColor,
          height: 2,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listaVendas.length,
            itemBuilder: (context, i) {
              return LinhaTabela(
                aoActualizarViewItem: ((indice,
                    {required destacar, required pintar}) {
                  var atualizada = listaVendas[indice];
                  atualizada.linhaPintada.value = pintar;
                  atualizada.linhaDestacada.value = destacar;
                  vendasC.lista[indice] = atualizada;
                }),
                subJanelaComPermissao: subJanelaComPermissao,
                indiceVenda: i,
                listaVendas: listaVendas,
                futurePegandoPrecos:
                    vendasC.pegarPrecoProduto(listaVendas[i].produto!),
                aoDesfazer: (venda, indice, vendaMultipla) {
                  vendasC.vender(venda, indice, vendaMultipla, false);
                },
                aoVender: (venda, indice, vendaMultipla) {
                  vendasC.vender(venda, indice, vendaMultipla, true);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class CabecalhoTabela extends StatelessWidget {
  CabecalhoTabela({
    required this.subJanelaComPermissao,
  });

  final bool subJanelaComPermissao;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          DivisorVertical(),
          const Expanded(
              child: Center(
                  child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Nome do Produto",
                style: TextStyle(
                  fontSize: 16,
                )),
          ))),
          DivisorVertical(),
          const Expanded(
              child: Center(
                  child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Preços",
                style: TextStyle(
                  fontSize: 16,
                )),
          ))),
          DivisorVertical(),
          const Expanded(
              child: Center(
                  child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Quantidade Vendida",
                style: TextStyle(
                  fontSize: 16,
                )),
          ))),
          DivisorVertical(),
          const Expanded(
              child: Center(
                  child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Total",
                style: TextStyle(
                  fontSize: 16,
                )),
          ))),
          DivisorVertical(),
          Visibility(
            child: const Expanded(
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Vender",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              )),
            ),
            visible: subJanelaComPermissao,
            replacement: Container(),
          ),
          DivisorVertical(),
          Visibility(
            child: const Expanded(
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Desfazer",
                    style: TextStyle(
                      fontSize: 16,
                    )),
              )),
            ),
            visible: subJanelaComPermissao,
            replacement: Container(),
          ),
          DivisorVertical(),
        ],
      ),
    );
  }
}

class LinhaTabela extends StatelessWidget {
  int indiceVenda;
  List<Venda> listaVendas;
  int contadorTempoPintura = 1;
  int contadorTempoDestaque = 1;
  Future<List<Preco>> futurePegandoPrecos;
  Function(Venda venda, int indice, bool vendaMultipla) aoVender;
  Function(Venda venda, int indice, bool vendaMultipla) aoDesfazer;
  Function(int indice, {required bool pintar, required bool destacar})
      aoActualizarViewItem;

  LinhaTabela({
    required this.futurePegandoPrecos,
    required this.subJanelaComPermissao,
    required this.indiceVenda,
    required this.listaVendas,
    required this.aoDesfazer,
    required this.aoActualizarViewItem,
    required this.aoVender,
  }) {
    if (listaVendas[indiceVenda].vendaDestacada == true) {
      _controlarDestaque();
    }
    if (listaVendas[indiceVenda].linhaDestacada.value == true) {
      _controlarDestaque();
    }
    if (listaVendas[indiceVenda].linhaPintada.value == true) {
      _controlarPintura();
    }
  }

  final bool subJanelaComPermissao;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: primaryColor.withOpacity(0.7),
      onLongPress: () async {},
      onTap: () {
        aoActualizarViewItem(indiceVenda, pintar: true, destacar: false);
      },
      child: Container(
        color: listaVendas[indiceVenda].linhaPintada.value == true
            ? primaryColor.withOpacity(0.3)
            : null,
        child: Column(
          children: [
            const Divider(
              color: primaryColor,
              height: 2,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  DivisorVertical(),
                  Expanded(child: Obx(() {
                    return Container(
                      color: (listaVendas[indiceVenda].linhaDestacada.value ==
                              true)
                          ? primaryColor.withOpacity(0.4)
                          : null,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          listaVendas[indiceVenda].produto?.nome ??
                              "Sem Registo",
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                    );
                  })),
                  DivisorVertical(),
                  Expanded(
                    child: Center(
                        child: FutureBuilder<List<Preco>>(
                            future: futurePegandoPrecos,
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                var precos = snapshot.data!
                                    .map((e) =>
                                        "${formatarInteiroComMilhares((e.quantidade ?? 0))}  -->  ${formatar((e.preco ?? 0))}\n")
                                    .toList();
                                listaVendas[indiceVenda].precos = snapshot.data;
                                if (precos.isEmpty) {
                                  return const Text("Sem Preços",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ));
                                }
                                return Text(
                                    "$precos"
                                        .replaceAll("[", "")
                                        .replaceAll("]", "")
                                        .replaceAll(" ", "")
                                        .replaceAll(",", ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ));
                              }
                              return const CircularProgressIndicator();
                            })),
                  ),
                  DivisorVertical(),
                  Expanded(
                    child: Center(
                        child: Text(
                            "${listaVendas[indiceVenda].quantidadeVendida}",
                            style: const TextStyle(
                              fontSize: 16,
                            ))),
                  ),
                  DivisorVertical(),
                  Expanded(
                      child: Center(
                          child: Text(
                              formatar(listaVendas[indiceVenda].total ?? 0),
                              style: const TextStyle(
                                fontSize: 16,
                              )))),
                  DivisorVertical(),
                  Visibility(
                    child: Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: InkWell(
                            onTap: () async {
                              listaVendas[indiceVenda].vendaDestacada = true;
                              aoVender(
                                  listaVendas[indiceVenda], indiceVenda, false);
                            },
                            onLongPress: () async {
                              aoVender(
                                  listaVendas[indiceVenda], indiceVenda, true);
                            },
                            child: const Icon(
                              Icons.add,
                              color: primaryColor,
                            )),
                      ),
                    ),
                    visible: subJanelaComPermissao,
                    replacement: Container(),
                  ),
                  DivisorVertical(),
                  Visibility(
                    child: Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: InkWell(
                            onTap: () async {
                              aoDesfazer(
                                  listaVendas[indiceVenda], indiceVenda, false);
                            },
                            onLongPress: () async {
                              aoDesfazer(
                                  listaVendas[indiceVenda], indiceVenda, true);
                            },
                            child: const Icon(
                              Icons.remove,
                              color: primaryColor,
                            )),
                      ),
                    ),
                    visible: subJanelaComPermissao,
                    replacement: Container(),
                  ),
                  DivisorVertical(),
                ],
              ),
            ),
            const Divider(
              color: primaryColor,
              height: 2,
            ),
          ],
        ),
      ),
    );
  }

  _destacarLinha() {
    listaVendas[indiceVenda].linhaDestacada.value = true;
    _reiniciarContador();
  }

  _reiniciarContador() {
    contadorTempoPintura = 1;
  }

  _desPintarLinha() {
    aoActualizarViewItem(indiceVenda, pintar: false, destacar: false);
    _reiniciarContador();
  }

  _desDestacarLinha() {
    aoActualizarViewItem(indiceVenda, pintar: false, destacar: false);
    _reiniciarContador();
  }

  _controlarPintura() {
    contadorTempoPintura = 1;
    _temporizarPintura();
  }

  _controlarDestaque() {
    contadorTempoDestaque = 1;
    _temporizarDestaque();
  }

  bool _linhaPintada() {
    return listaVendas[indiceVenda].linhaPintada.value == true;
  }

  bool _linhaDestacada() {
    return listaVendas[indiceVenda].linhaDestacada.value == true;
  }

  _temporizarPintura() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (contadorTempoPintura == 8) {
        _desPintarLinha();
        timer.cancel();
      }
      contadorTempoPintura++;
    });
  }

  _temporizarDestaque() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (contadorTempoDestaque == 6) {
        _desDestacarLinha();
        try {
          if (listaVendas.isEmpty) {
            timer.cancel();
            return;
          }
          listaVendas[indiceVenda].vendaDestacada = false;
        } on Exception catch (e) {
          // TODO
        }
      }
      contadorTempoDestaque++;
    });
  }
}

class DivisorVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const VerticalDivider(
        color: primaryColor,
        width: 2,
      ),
    );
  }
}
