import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_cliente_I.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_divida_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_funcionario_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_divida.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_fincionario.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/entidades/divida.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_divida.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/utils.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/recepcoes/layouts/layouts_produtos_completo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/layouts/layout_quantidade.dart';

import '../../../../../../contratos/casos_uso/manipular_produto_i.dart';
import '../../../../../../dominio/casos_uso/manipula_stock.dart';
import '../../../../../../dominio/casos_uso/manipular_cliente.dart';
import '../../../../../../dominio/casos_uso/manipular_preco.dart';
import '../../../../../../dominio/casos_uso/manipular_produto.dart';
import '../../../../../../dominio/casos_uso/manipular_saida.dart';
import '../../../../../../dominio/entidades/cliente.dart';
import '../../../../../../dominio/entidades/estado.dart';
import '../../../../../../dominio/entidades/preco.dart';
import '../../../../../../dominio/entidades/venda.dart';
import '../../../../../../fonte_dados/provedores/provedor_cliente.dart';
import '../../../../../../fonte_dados/provedores/provedor_preco.dart';
import '../../../../../../fonte_dados/provedores/provedor_produto.dart';
import '../../../../../../fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../fonte_dados/provedores/provedor_stock.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../componentes/item_produto.dart';
import '../../../../../componentes/pesquisa.dart';
import '../vendas/layouts/detalhes_venda.dart';

class PainelDividasC extends GetxController {
  late ManipularDividaI _manipularDividaI;
  RxList<Divida> lista = RxList();
  List<Divida> listaCopia = [];
  int indiceTabActual = 0;
  var totalDividasPagas = 0.0.obs;
  var totalDividasNaoPagas = 0.0.obs;

  late ManipularProdutoI _manipularProdutoI;
  late ManipularClienteI _manipularClienteI;
  late ManipularFuncionarioI _manipularFuncionarioI;

  PainelDividasC(this.funcionario) {
    var maniStock = ManipularStock(ProvedorStock());
    _manipularDividaI = ManipularDivida(ProvedorDivida(),
        ManipularSaida(ProvedorSaida(), maniStock), maniStock);
    _manipularClienteI = ManipularCliente(ProvedorCliente());
    _manipularFuncionarioI = ManipularFuncionario(
        ManipularUsuario(ProvedorUsuario()), ProveedorFuncionario());
    _manipularProdutoI = ManipularProduto(ProvedorProduto(),
        ManipularStock(ProvedorStock()), ManipularPreco(ProvedorPreco()));
  }
  @override
  void onInit() async {
    await pegarLista();
    super.onInit();
  }

  late Funcionario funcionario;

  void aoPesquisar(String f) async {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      var cliente =
          await _manipularClienteI.pegarClienteDeId(cada.idCliente ?? -1);
      var produto =
          await _manipularProdutoI.pegarProdutoDeId(cada.idProduto ?? -1);
      var funcionario = await _manipularFuncionarioI
          .pegarFuncionarioDeId(cada.idFuncionario ?? -1);
      var funcionarioPagante = await _manipularFuncionarioI
          .pegarFuncionarioDeId(cada.idFuncionarioPagante ?? -1);
      if ((cliente?.nome ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (funcionario.nomeCompelto ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (funcionarioPagante.nomeCompelto ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (cada.total ?? "")
              .toString()
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (produto?.nome ?? "").toString().contains(f.toLowerCase()) ||
          cada.total.toString().contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  Future pegarLista() async {
    totalDividasNaoPagas.value = 0;
    totalDividasPagas.value = 0;
    var res = await _manipularDividaI.pegarListaTodasDividas();

    for (var cada in res) {
      lista.add(cada);
      if (cada.paga == false) {
        totalDividasNaoPagas.value += cada.total ?? 0;
      }
      if (cada.paga == true && comapararDatas(DateTime.now(), cada.data!)) {
        totalDividasPagas.value += cada.total ?? 0;
      }
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  void mostrarDialogoDetalhesVenda(Venda venda) {
    mostrarDialogoDeLayou(LayoutDetalhesVenda(
      venda: venda,
    ));
  }

  void mostrarDialogoMostrarClientes() {
    mostrarDialogoDeLayou(FutureBuilder<List<Cliente>>(
        future: _manipularClienteI.todos(),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data?.isEmpty == true) {
            return Text("Nenhum Cliente");
          }
          return Column(
            children: [
              Text("Seleccione o Cliente"),
              SizedBox(
                height: 20,
              ),
              Column(
                children: snapshot.data!
                    .map((e) => ModeloItemLista(
                          tituloItem: "${e.nome ?? "Sem Registo"}",
                          metodoChamadoAoClicarItem: () {
                            voltar();
                            mostrarDialogoProdutos(context, e);
                          },
                        ))
                    .toList(),
              ),
            ],
          );
        }));
  }

  void mostrarDialogoMostrarPrecos(
      List<Preco> precos, Cliente cliente, Produto produto) {
    mostrarDialogoDeLayou(Column(
      children: [
        Text("Seleccione: "),
        SizedBox(
          height: 20,
        ),
        Column(
          children: precos
              .map((e) => ModeloItemLista(
                    tituloItem:
                        "${formatarInteiroComMilhares(e.quantidade ?? 0)} --> ${formatar(e.preco ?? 0)}",
                    itemComentado: false,
                    metodoChamadoAoClicarItem: () {
                      voltar();
                      mostrarDialogoDeLayou(LayoutQuantidade(
                          accaoAoFinalizar: (qtd, opcao) {
                            voltar();
                            registarDivida(cliente, produto, qtd, e);
                          },
                          titulo: "Insira a Quantidasde",
                          comOpcaoRetirada: false));
                    },
                  ))
              .toList(),
        ),
      ],
    ));
  }

  void registarDivida(
      Cliente cliente, Produto produto, int qtd, Preco e) async {
    mostrar(funcionario.id);
    Divida nova = Divida(
        idFuncionario: funcionario.id,
        idCliente: cliente.id,
        idProduto: produto.id,
        estado: Estado.ATIVADO,
        quantidadeDevida: qtd * (e.quantidade ?? 0),
        data: DateTime.now(),
        total: qtd * (e.preco ?? 0),
        paga: false);
    lista.insert(0, nova);
    totalDividasNaoPagas.value += qtd * (e.preco ?? 0);
    var id = await _manipularDividaI.registarDivida(nova);
    lista[0].id = id;
  }

  void mostrarDialogoProdutos(BuildContext context, Cliente cliente) async {
    mostrarDialogoDeLayou(
        LayoutProdutosCompleto(
            aoClicarItem: (p) async {
              voltar();
              await aoClicarNoProduto(p, cliente);
            },
            manipularProdutoI: _manipularProdutoI),
        layoutCru: true);
  }

  Future<void> aoClicarNoProduto(Produto produto, Cliente cliente) async {
    var precos =
        await _manipularProdutoI.pegarPrecoProdutoDeId(produto.id ?? -1);
    if (precos.isEmpty) {
      mostrarDialogoDeInformacao("Produto sem preço!");
      return;
    }
    if (precos.length == 1) {
      mostrarDialogoDeLayou(LayoutQuantidade(
          accaoAoFinalizar: (qtd, opcao) {
            voltar();
            registarDivida(cliente, produto, qtd, precos[0]);
          },
          titulo: "Insira a Quantidasde",
          comOpcaoRetirada: false));
      return;
    }
    mostrarDialogoMostrarPrecos(precos, cliente, produto);
  }

  Future<Cliente?> pegarCliente(int id) async {
    return await _manipularClienteI.pegarClienteDeId(id);
  }

  Future<Produto?> pegarProduto(int id) async {
    return await _manipularProdutoI.pegarProdutoDeId(id);
  }

  Future<Funcionario?> pegarFuncionario(int id) async {
    try {
      return await _manipularFuncionarioI.pegarFuncionarioDeId(id);
    } catch (e) {
      return null;
    }
  }

  void aoPagarDivida(Divida divida) async {
    var actualizada = Divida.fromJson(divida.toJson());
    actualizada.paga = true;
    actualizada.idFuncionarioPagante = funcionario.id;
    actualizada.dataPagamento = DateTime.now();
    for (var i = 0; i < lista.length; i++) {
      if (lista[i].id == actualizada.id) {
        lista[i] = actualizada;
        break;
      }
    }

    totalDividasNaoPagas.value -= actualizada.total ?? 0;
    totalDividasPagas.value += actualizada.total ?? 0;
    await _manipularDividaI.actualizarDivida(actualizada);
  }

  void pegarDados(bool pagas) async {
    lista.clear();
    var res = await _manipularDividaI.pegarListaTodasDividas();

    for (var cada in res) {
      if (cada.paga == pagas) {
        lista.add(cada);
      }
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  void mostrarDialogoEliminar(BuildContext context, bool limparTudo) async {
    if (limparTudo == true) {
      mostrarDialogoDeLayou(
          LayoutConfirmacaoAccao(
              corButaoSim: primaryColor,
              pergunta: "Deseja mesmo limpar Tudo",
              accaoAoConfirmar: () async {
                voltar();
                lista.clear();
                await _manipularDividaI.removerTodasDividas();
              },
              accaoAoCancelar: () {}),
          layoutCru: true);
      return;
    }
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje,
        firstDate: hoje.subtract(Duration(days: 365 * 3)),
        lastDate: hoje);
    if (dataSelecionada == null) {
      return;
    }
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            corButaoSim: primaryColor,
            pergunta:
                "Deseja mesmo limpar dados antes de ${formatarData(dataSelecionada, semHora: true)}",
            accaoAoConfirmar: () async {
              voltar();
              lista.removeWhere(
                  (element) => element.data!.isBefore(dataSelecionada));
              await _manipularDividaI.removerAntes(dataSelecionada);
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }

  void mostrarDialogoRemover(BuildContext context, Divida divida) {
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            corButaoSim: primaryColor,
            pergunta: "Deseja mesmo Remover?",
            accaoAoConfirmar: () async {
              voltar();
              lista.removeWhere((element) => element.id == divida.id);
              await _manipularDividaI.removerDivida(divida);
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }
}
