import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/inventario/painel_c.dart';
import '../../../../../../dominio/entidades/stock.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../../solucoes_uteis/responsividade.dart';
import '../../../../../componentes/item_produto.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_gerente_c.dart';

class PainelInventario extends StatelessWidget {
  PainelInventario({
    Key? key,
    required PainelGerenteC c,
  })  : _c = c,
        super(key: key) {
    iniciar();
  }
  late PainelInventarioC _painelInventarioC;

  iniciar() {
    try {
      _painelInventarioC = Get.find();
    } catch (e) {
      _painelInventarioC = PainelInventarioC(funcionario: _c.funcionarioActual);
      Get.put(_painelInventarioC);
    }
  }

  final PainelGerenteC _c;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {
              _painelInventarioC.aoPesquisar(dado);
            },
            accaoAoSair: () {
              _c.terminarSessao();
            },
            accaoAoVoltar: () {
              _c.irParaPainel(PainelActual.FUNCIONARIOS);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text(
                "INVENTÁRIO",
                style: TextStyle(color: primaryColor, fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Row(
            children: [
              Obx(() {
                return Text(
                  "TOTAL VENDAS ESTIMADAS: ${formatar(_painelInventarioC.totalVendas.value)}",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                );
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Row(
            children: [
              Obx(() {
                return Text(
                  "TOTAL LUCRO ESTIMADO: ${formatar(_painelInventarioC.totalLucros.value)}",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            _painelInventarioC.produtos.isEmpty;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: _painelInventarioC.produtos.length,
                  itemBuilder: (context, indice) {
                    return InkWell(
                      onTap: () {},
                      child: Card(
                          elevation: 5,
                          child: Visibility(
                            visible: !Responsidade.isMobile(context),
                            child: Row(
                              children: [
                                LayoutPrevio(
                                    indice: indice,
                                    painelInventarioC: _painelInventarioC),
                                LayoutDadosGerados(
                                    indice: indice,
                                    painelInventarioC: _painelInventarioC),
                              ],
                            ),
                            replacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LayoutPrevio(
                                    indice: indice,
                                    painelInventarioC: _painelInventarioC),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: LayoutDadosGerados(
                                      indice: indice,
                                      painelInventarioC: _painelInventarioC),
                                ),
                                Obx(() {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Venda Estimada: ${formatar(_painelInventarioC.produtos[indice].vendaEstimado)}"),
                                        Text(
                                            "Lucro Estimado: ${formatar(_painelInventarioC.produtos[indice].lucroEstimado)}"),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          )),
                    );
                  }),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ModeloButao(
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Demonstração de Inventário",
                metodoChamadoNoClique: () {
                  _painelInventarioC.gerarRelatorio(modoDemo: true);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ModeloButao(
                corButao: primaryColor,
                corTitulo: Colors.white,
                butaoHabilitado: true,
                tituloButao: "Fazer Inventário",
                metodoChamadoNoClique: () {
                  _painelInventarioC.mostrarDialogoPerguntar();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LayoutPrevio extends StatelessWidget {
  const LayoutPrevio({
    Key? key,
    required PainelInventarioC painelInventarioC,
    required this.indice,
  })  : _painelInventarioC = painelInventarioC,
        super(key: key);

  final PainelInventarioC _painelInventarioC;
  final int indice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          width: Responsidade.isMobile(context) ? 50 : 100,
          height: 100,
          child: ImagemNoCirculo(
              Icon(
                Icons.all_inbox_rounded,
                color: primaryColor,
                size: Responsidade.isMobile(context) ? 30 : 60,
              ),
              20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Nome: ${_painelInventarioC.produtos[indice].nome ?? "Sem Nome"}"),
            FutureBuilder<Stock?>(
                future: _painelInventarioC
                    .pegarStock(_painelInventarioC.produtos[indice]),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Text("Qtd. Recebida: 0");
                  }
                  return Text(
                      "Qtd. Recebida: ${formatarInteiroComMilhares(snapshot.data?.quantidade ?? 0)}");
                }),
            Text(
                "Preço Venda: ${formatar(_painelInventarioC.produtos[indice].precoGeral)}"),
            Text(
                "Preço Compra: ${formatar(_painelInventarioC.produtos[indice].precoCompra ?? 0)}"),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Venda Esperada: ${formatar(_painelInventarioC.produtos[indice].dinheiro)}"),
            Text(
                "Investido: ${formatar(_painelInventarioC.produtos[indice].investimento)}"),
            Text(
                "Por Lucar: ${formatar(_painelInventarioC.produtos[indice].dinheiro - _painelInventarioC.produtos[indice].investimento)}"),
            Text(
                "Quantidade Existente: ${formatarInteiroComMilhares(_painelInventarioC.produtos[indice].quantidadeExistente ?? 0)}"),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Visibility(
          visible: !Responsidade.isMobile(context),
          child: Container(
            height: 60,
            child: VerticalDivider(
              color: primaryColor,
              width: 10,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

class LayoutDadosGerados extends StatelessWidget {
  const LayoutDadosGerados({
    Key? key,
    required PainelInventarioC painelInventarioC,
    required this.indice,
  })  : _painelInventarioC = painelInventarioC,
        super(key: key);

  final PainelInventarioC _painelInventarioC;
  final int indice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.black.withOpacity(0.1),
          ),
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: ((value) async {
              await _painelInventarioC.calcularDiferenca(indice, value);
            }),
            decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 12,
                ),
                focusColor: Colors.black,
                hintText: "Qtd. Existente",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Quantidade Vendida: ${formatarInteiroComMilhares(_painelInventarioC.produtos[indice].diferenca)}"),
                Text(
                    "Venda Estimada: ${formatar(_painelInventarioC.produtos[indice].vendaEstimado)}"),
                Text(
                    "Lucro Estimado: ${formatar(_painelInventarioC.produtos[indice].lucroEstimado)}"),
              ],
            ),
          );
        }),
      ],
    );
  }
}
