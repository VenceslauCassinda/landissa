import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/vendas/layouts/mesa_venda/mesa_venda_c.dart';
import '../../../../../../../../dominio/entidades/funcionario.dart';
import '../../../../../../../../dominio/entidades/produto.dart';
import '../../../../../../../../recursos/constantes.dart';
import '../../../../../../../componentes/item_item_venda.dart';
import '../../../../../../../componentes/pesquisa.dart';
import '../../../../../gerente/sub_paineis/produtos/layouts/produtos.dart';
import '../vendas_c.dart';

class LayoutMesaVenda extends StatelessWidget {
  late VendasC _vendasC;
  late MesaVendaC _c;
  Map<String, TextEditingController> controladores = {};

  final DateTime data;
  final Funcionario funcionario;
  LayoutMesaVenda(this.data, this.funcionario) {
    _c = MesaVendaC(data, funcionario);
    initiC();
  }

  initiC() {
    try {
      _vendasC = Get.find();
      _vendasC.data = data;
      _vendasC.funcionario = funcionario;
    } catch (e) {
      // _vendasC = Get.put(VendasC(data, funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                        child: LayoutPesquisa(
                          accaoNaInsercaoNoCampoTexto: (dado) {
                            // _vendasC.aoPesquisarProduto(dado);
                          },
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .5,
                        child: Obx(() {
                          // _vendasC.produtos.isEmpty;
                          return LayoutProdutos(
                            lista: [],
                            accaoAoClicarCadaProduto: (produto) {
                              if (produto.stock!.quantidade! > 0) {
                                _c.adicionarProdutoAmesa(produto);
                                controladores["${produto.id}1"] =
                                    TextEditingController(text: "0");
                                controladores["${produto.id}2"] =
                                    TextEditingController(text: "0");
                              } else {
                                mostrarDialogoDeInformacao(
                                    "Produto com quantidade insuficiente em Stock!");
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: _PainelDireito(c: _c, controladores: controladores),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ModeloButao(
                    corButao: Colors.red,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Cancelar",
                    metodoChamadoNoClique: () {
                      voltar();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ModeloButao(
                    corButao: primaryColor,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Finalizar Venda",
                    metodoChamadoNoClique: () {
                      _c.vender(_vendasC);
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class _PainelDireito extends StatelessWidget {
  const _PainelDireito({
    Key? key,
    required MesaVendaC c,
    required this.controladores,
  })  : _c = c,
        super(key: key);

  final MesaVendaC _c;
  final Map<String, TextEditingController> controladores;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(.2)),
              borderRadius: BorderRadius.circular(7)),
          child: _CabecaclhoVenda(c: _c),
        ),
        Obx(
          () => Container(
            height: MediaQuery.of(context).size.height * .3,
            padding: EdgeInsets.all(20),
            child: Scrollbar(
              interactive: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _c.listaItensVenda
                      .map((element) => ItemItemVenda(
                            controladores: controladores,
                            c: _c,
                            element: element,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _CabecaclhoVenda extends StatelessWidget {
  const _CabecaclhoVenda({
    Key? key,
    required MesaVendaC c,
  })  : _c = c,
        super(key: key);

  final MesaVendaC _c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Cliente: ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * .18,
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    onChanged: (valor) {
                      _c.nomeCliente.value = valor;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("Contacto: ", style: TextStyle(fontSize: 20)),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * .18,
                  child: TextField(
                      onChanged: (valor) {
                        _c.telefoneCliente.value = valor;
                      },
                      style: TextStyle(fontSize: 20),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Obx(
              () => Text(
                  "Total a Pagar: ${formatar(_c.listaItensVenda.fold<double>(0, (previousValue, element) => ((element.total ?? 0) + previousValue)))} KZ"),
            ),
            Spacer(),
            ModeloButao(
              corButao: primaryColor,
              corTitulo: Colors.white,
              butaoHabilitado: true,
              tituloButao: "Pagar",
              icone: Icons.add,
              metodoChamadoNoClique: () {
                _c.mostrarFormasPagamento(context);
              },
            )
          ],
        ),
        Container(width: 200, child: Divider()),
        Row(
          children: [
            Obx(() => Text(
                "Total Pago: ${formatar(_c.listaPagamentos.fold<double>(0, (previousValue, element) => ((element.valor ?? 0) + previousValue)))} KZ")),
            Spacer(),
            Text("Data de levantamento: "),
            Obx(() {
              return ToggleButtons(
                  selectedColor: primaryColor,
                  onPressed: (i) {
                    _c.mudarData(i, context);
                  },
                  children: [
                    Text("Hoje"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_c.dataLevantamento.value == null
                          ? "Seleccionar"
                          : "${formatarMesOuDia(_c.dataLevantamento.value!.day)}/${formatarMesOuDia(_c.dataLevantamento.value!.month)}/${_c.dataLevantamento.value!.year} às ${formatarMesOuDia(_c.dataLevantamento.value!.hour)}h e ${formatarMesOuDia(_c.dataLevantamento.value!.minute)}min"),
                    ),
                  ],
                  isSelected: _c.hojeOuData);
            })
          ],
        ),
        Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _c.listaPagamentos
                  .map((element) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${formatar(element.valor ?? 0)} KZ - Pago com ${element.formaPagamento?.descricao ?? "[Não Definido]"}"),
                          IconeItem(
                              metodoQuandoItemClicado: () {
                                _c.removerPagamento(element);
                              },
                              icone: Icons.delete,
                              titulo: ""),
                        ],
                      ))
                  .toList(),
            )),
        Container(width: 200, child: Divider()),
      ],
    );
  }
}
