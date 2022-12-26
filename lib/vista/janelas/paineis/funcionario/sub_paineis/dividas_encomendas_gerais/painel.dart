import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/dividas_encomendas_gerais/layout/item_divida.dart';
import '../../../../../../../recursos/constantes.dart';
import '../../../../../componentes/pesquisa.dart';
import 'painel_c.dart';

class PainelDividas extends StatelessWidget {
  PainelDividas({
    Key? key,
    required this.funcionario,
    required this.accaoAoVoltar,
  }) {
    initiC();
  }

  late PainelDividasC _c;
  final Funcionario funcionario;
  final Function accaoAoVoltar;

  initiC() {
    try {
      _c = Get.find();
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(PainelDividasC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {
              _c.aoPesquisar(dado);
            },
            accaoAoVoltar: () {
              accaoAoVoltar();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Obx(
            () => Text(
              "DÍVIDAS PAGAS HOJE: ${formatar(_c.totalDividasPagas.value)} KZ",
              style: TextStyle(color: primaryColor, fontSize: 30),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            children: [
              Container(
                child: Obx(
                  () => Text(
                    "NÃO PAGAS: ${formatar(_c.totalDividasNaoPagas.value)} KZ",
                    style: TextStyle(color: primaryColor, fontSize: 30),
                  ),
                ),
              ),
              const Spacer(),
              Visibility(
                visible: !Responsidade.isMobile(context),
                child: LayoutFiltros(c: _c),
                replacement: PopupFiltros(c: _c),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Expanded(
          child: Obx(
            () {
              var itens = _c.lista
                  .map((divida) => ItemDivida(
                        dado: divida,
                        itemRemovivel:
                            funcionario.nivelAcesso == NivelAcesso.GERENTE,
                        futurePegarCliente:
                            _c.pegarCliente(divida.idCliente ?? -1),
                        futurePegarFuncionario:
                            _c.pegarFuncionario(divida.idFuncionario ?? -1),
                        futurePegarFuncionarioPagante: _c.pegarFuncionario(
                            divida.idFuncionarioPagante ?? -1),
                        futurePegarProduto:
                            _c.pegarProduto(divida.idProduto ?? -1),
                        metodoChamadoAoClicarItem: () {
                          if (divida.paga == false) {
                            _c.aoPagarDivida(divida);
                          }
                        },
                        metodoChamadoAoRemoverItem: () {
                          _c.mostrarDialogoRemover(context, divida);
                        },
                      ))
                  .toList();
              if (itens.isEmpty) {
                return Center(child: Text("Sem Dividas!"));
              }
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: itens.length, itemBuilder: (c, i) => itens[i]),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: 200,
          child: ModeloButao(
            corButao: primaryColor,
            icone: Icons.add,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Nova Dívida",
            metodoChamadoNoClique: () {
              _c.mostrarDialogoMostrarClientes();
            },
          ),
        ),
      ],
    );
  }
}

class PopupFiltros extends StatelessWidget {
  const PopupFiltros({
    Key? key,
    required PainelDividasC c,
  })  : _c = c,
        super(key: key);

  final PainelDividasC _c;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      child: Row(
        children: [
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [Text("Filtrar"), Icon(Icons.arrow_drop_down)],
              ),
            ),
          ),
        ],
      ),
      onSelected: ((value) {
        if (value == 0) {
          _c.lista.clear();
          _c.pegarLista();
          return;
        }
        if (value == 1) {
          _c.pegarDados(true);
          return;
        }
        if (value == 2) {
          _c.pegarDados(false);
          return;
        }
        if (value == 3) {
          _c.mostrarDialogoEliminar(context, false);
          return;
        }
      }),
      itemBuilder: ((context) {
        return [
          PopupMenuItem(
            value: 0,
            child: Text("Todas"),
            onTap: () {},
          ),
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Text("Pagas"),
                Spacer(),
                Icon(Icons.check_box_outlined)
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Text("Não Pagas"),
                Spacer(),
                Icon(Icons.check_box_outline_blank_rounded)
              ],
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Row(
              children: [Text("Limpar"), Spacer(), Icon(Icons.delete)],
            ),
          ),
        ];
      }),
    );
  }
}

class LayoutFiltros extends StatelessWidget {
  const LayoutFiltros({
    Key? key,
    required PainelDividasC c,
  })  : _c = c,
        super(key: key);

  final PainelDividasC _c;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ModeloButao(
          corButao: primaryColor,
          corTitulo: Colors.white,
          butaoHabilitado: true,
          tituloButao: "Todas",
          metodoChamadoNoClique: () {
            _c.lista.clear();
            _c.pegarLista();
          },
        ),
        SizedBox(
          width: 20,
        ),
        ModeloButao(
          icone: Icons.check_box_outlined,
          corButao: primaryColor,
          corTitulo: Colors.white,
          butaoHabilitado: true,
          tituloButao: "Pagas",
          metodoChamadoNoClique: () {
            _c.pegarDados(true);
          },
        ),
        SizedBox(
          width: 20,
        ),
        ModeloButao(
          corButao: primaryColor,
          icone: Icons.check_box_outline_blank_rounded,
          corTitulo: Colors.white,
          butaoHabilitado: true,
          tituloButao: "Não Pagas",
          metodoChamadoNoClique: () {
            _c.pegarDados(false);
          },
        ),
        const SizedBox(
          width: 40,
        ),
        Visibility(
          visible: _c.funcionario.nivelAcesso == NivelAcesso.GERENTE,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ModeloButao(
              corButao: primaryColor,
              icone: Icons.delete,
              corTitulo: Colors.white,
              butaoHabilitado: true,
              tituloButao: "Limpar",
              metodoChamadoNoClique: () {
                _c.mostrarDialogoEliminar(context, true);
              },
              metodoChamadoNoLongoClique: () {
                _c.mostrarDialogoEliminar(context, false);
              },
            ),
          ),
        ),
      ],
    );
  }
}
