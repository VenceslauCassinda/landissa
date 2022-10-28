import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/preco.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/inventario/painel_c.dart';
import '../../../../../../dominio/entidades/stock.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/console.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../componentes/item_produto.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_gerente_c.dart';
import '../produtos/layouts/produtos.dart';

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
            accaoNaInsercaoNoCampoTexto: (dado) {},
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
              const Text(
                "INVENTÁRIO",
                style: TextStyle(color: primaryColor),
              ),
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
                      child: Stack(
                        children: [
                          ItemProduto(
                            produto: _painelInventarioC.produtos[indice],
                            futurePegarStock: _painelInventarioC.pegarStock(
                                _painelInventarioC.produtos[indice]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 250,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 50),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  onChanged: ((value) async {
                                    await _painelInventarioC.calcularDiferenca(
                                        indice, value);
                                  }),
                                  decoration: const InputDecoration(
                                      errorStyle: TextStyle(
                                        fontSize: 12,
                                      ),
                                      focusColor: Colors.black,
                                      hintText: "Quantidade Existente",
                                      border: InputBorder.none),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                ),
                              ),
                              Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                      "Quantidade Vendida: ${formatarInteiroComMilhares(_painelInventarioC.produtos[indice].diferenca)}"),
                                );
                              }),
                              Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                      "Venda Estimada: ${formatar(_painelInventarioC.produtos[indice].vendaEstimado)}"),
                                );
                              }),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                        "Preço Geral: ${formatar(_painelInventarioC.produtos[indice].precoGeral)}"),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    FutureBuilder<Stock?>(
                                        future: _painelInventarioC.pegarStock(
                                            _painelInventarioC
                                                .produtos[indice]),
                                        builder: (context, s) {
                                          if (s.data == null) {
                                            return Container();
                                          }
                                          return Text(
                                              "Em Cash: ${formatar(_painelInventarioC.produtos[indice].dinheiro)}");
                                        })
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            );
          }),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: ModeloButao(
            corButao: primaryColor,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Fazer Inventário",
            metodoChamadoNoClique: () {
              _painelInventarioC.mostrarDialogoPerguntar();
            },
          ),
        ),
      ],
    );
  }
}
