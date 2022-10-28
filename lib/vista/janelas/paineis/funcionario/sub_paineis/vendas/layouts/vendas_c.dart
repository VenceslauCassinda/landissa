import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_item_venda_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_receccao_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_stock_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_pagamento.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/pagamento_final.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/venda.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_pagamento.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/recepcoes/layouts/layouts_produtos_completo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/vendas/layouts/mesa_venda/mesa_venda.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/painel_funcionario_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/layouts/layout_quantidade.dart';
import '../../../../../../../contratos/casos_uso/manipular_divida_i.dart';
import '../../../../../../../contratos/casos_uso/manipular_pagamento_i.dart';
import '../../../../../../../contratos/casos_uso/manipular_venda_i.dart';
import '../../../../../../../dominio/casos_uso/manipula_stock.dart';
import '../../../../../../../dominio/casos_uso/manipular_cliente.dart';
import '../../../../../../../dominio/casos_uso/manipular_definicoes.dart';
import '../../../../../../../dominio/casos_uso/manipular_divida.dart';
import '../../../../../../../dominio/casos_uso/manipular_entrada.dart';
import '../../../../../../../dominio/casos_uso/manipular_item_venda.dart';
import '../../../../../../../dominio/casos_uso/manipular_preco.dart';
import '../../../../../../../dominio/casos_uso/manipular_produto.dart';
import '../../../../../../../dominio/casos_uso/manipular_receccao.dart';
import '../../../../../../../dominio/casos_uso/manipular_saida.dart';
import '../../../../../../../dominio/casos_uso/manipular_venda.dart';
import '../../../../../../../dominio/entidades/estado.dart';
import '../../../../../../../dominio/entidades/forma_pagamento.dart';
import '../../../../../../../dominio/entidades/pagamento.dart';
import '../../../../../../../dominio/entidades/preco.dart';
import '../../../../../../../fonte_dados/provedores/provedor_cliente.dart';
import '../../../../../../../fonte_dados/provedores/provedor_divida.dart';
import '../../../../../../../fonte_dados/provedores/provedor_entrada.dart';
import '../../../../../../../fonte_dados/provedores/provedor_item_venda.dart';
import '../../../../../../../fonte_dados/provedores/provedor_preco.dart';
import '../../../../../../../fonte_dados/provedores/provedor_produto.dart';
import '../../../../../../../fonte_dados/provedores/provedor_receccao.dart';
import '../../../../../../../fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../../fonte_dados/provedores/provedor_stock.dart';
import '../../../../../../../fonte_dados/provedores/provedor_venda.dart';
import '../../../../../../../solucoes_uteis/geradores.dart';
import '../../../../../../componentes/item_produto.dart';
import '../../../../../../componentes/pesquisa.dart';
import '../../../../gerente/layouts/layout_forma_pagamento.dart';
import 'detalhes_venda.dart';

class VendasC extends GetxController {
  RxList<Venda> lista = RxList<Venda>();
  List<Venda> listaCopia = <Venda>[];
  late ManipularProdutoI _manipularProdutoI;
  late ManipularStockI _manipularStockI;
  late ManipularVendaI _manipularVendaI;
  late ManipularItemVendaI _manipularItemVendaI;
  late ManipularPagamentoI _manipularPagamentoI;
  int indiceTabActual = 0;
  var totalDividaPagas = 0.0.obs;
  var totalCaixa = 0.0.obs;
  var receccoesPagas = 0.0.obs;
  String criterioPesquisa = "";
  late DateTime data;
  late Funcionario? funcionario;
  late ManipularDefinicoes _manipularDefinicoes;
  late ManipularRececcaoI _manipularRececcaoI;
  late ManipularDividaI _manipularDividaI;

  VendasC(this.data, this.funcionario) {
    _manipularDefinicoes = Get.find();

    _manipularStockI = ManipularStock(ProvedorStock());
    var maniSaida = ManipularSaida(ProvedorSaida(), _manipularStockI);
    _manipularProdutoI = ManipularProduto(
        ProvedorProduto(), _manipularStockI, ManipularPreco(ProvedorPreco()));
    _manipularPagamentoI = ManipularPagamento(ProvedorPagamento());
    _manipularItemVendaI = ManipularItemVenda(
        ProvedorItemVenda(),
        ManipularProduto(ProvedorProduto(), _manipularStockI,
            ManipularPreco(ProvedorPreco())),
        ManipularStock(ProvedorStock()));
    _manipularVendaI = ManipularVenda(
        ProvedorVenda(),
        maniSaida,
        ManipularPagamento(ProvedorPagamento()),
        ManipularCliente(ProvedorCliente()),
        _manipularStockI,
        _manipularItemVendaI);
    _manipularRececcaoI = ManipularRececcao(
        ProvedorRececcao(),
        ManipularEntrada(ProvedorEntrada(), _manipularStockI),
        _manipularProdutoI);
    _manipularDividaI =
        ManipularDivida(ProvedorDivida(), maniSaida, _manipularStockI);
  }

  @override
  void onInit() async {
    await pegarLista();
    await calcularRececcoesPagas();
    await calcularDividasPagasHoje();
    super.onInit();
  }

  Future<void> calcularRececcoesPagas() async {
    receccoesPagas.value = 0.0;
    var res =
        await _manipularRececcaoI.pegarListaRececcoesPagas(funcionario!, data);
    for (var cada in res) {
      receccoesPagas.value += cada.custoTotal;
    }
  }

  Future<void> calcularDividasPagasHoje() async {
    totalDividaPagas.value = 0.0;
    var res = await _manipularDividaI.pegarListaTodasDividas();
    for (var cada in res) {
      if (cada.idFuncionarioPagante == funcionario?.id && cada.paga == true) {
        totalDividaPagas.value += cada.total ?? 0;
      }
    }
  }

  Future<int> pegarTipoEntidade() async {
    var definicoes = await _manipularDefinicoes.pegarDefinicoesActuais();
    return definicoes.tipoEntidade!;
  }

  Future<int> pegarTipoNegocio() async {
    var definicoes = await _manipularDefinicoes.pegarDefinicoesActuais();
    return definicoes.tipoNegocio!;
  }

  void navegar(int indice) async {
    indiceTabActual = indice;
    if (indice == 0) {
      await pegarLista();
    }
    if (indice == 1) {
      await pegarListaVendas();
    }
    if (indice == 2) {
      await pegarListaEncomendas();
    }
    if (indice == 3) {
      await pegarListaDividas();
    }
    await pegarTotalDividas();
  }

  void aoPesquisarVenda(String f) async {
    lista.clear();
    if (f.isEmpty) {
      criterioPesquisa = "";
      lista.addAll(listaCopia);
      return;
    }
    for (var cada in listaCopia) {
      var produto =
          await _manipularProdutoI.pegarProdutoDeId(cada.idProduto ?? -1);
      if ((produto?.nome ?? "")
          .toString()
          .toLowerCase()
          .contains(f.toLowerCase())) {
        cada.vendaDestacada = true;
      }
      lista.add(cada);
    }
    criterioPesquisa = f;
  }

  void mostrarDialogoNovaVenda(BuildContext context) {
    mostrarDialogoDeLayou(LayoutMesaVenda(data, funcionario!));
  }

  void mostrarDialogoProdutos(BuildContext context) async {
    mostrarDialogoDeLayou(
        LayoutProdutosCompleto(
            aoClicarItem: ((produto) async {
              voltar();
              await registarVenda(produto);
            }),
            manipularProdutoI: _manipularProdutoI),
        layoutCru: true);
  }

  Future<void> registarVenda(Produto produto) async {
    var existe = lista
        .firstWhereOrNull((element) => element.produto!.nome == produto.nome);
    if (existe != null) {
      mostrarDialogoDeInformacao("Produto já adicionado!");
      return;
    }
    var venda = Venda(
        estado: Estado.ATIVADO,
        idFuncionario: funcionario?.id,
        idCliente: -1,
        data: data,
        total: 0,
        idProduto: produto.id,
        produto: produto,
        quantidadeVendida: 0,
        parcela: 0);
    venda.vendaDestacada = true;
    venda.linhaDestacada.value = true;
    lista.add(venda);
    listaCopia.add(venda);
    lista.sort((a, b) {
      return a.produto!.nome!.compareTo(b.produto!.nome!);
    });
    int id = await _manipularVendaI.registarVenda(
        venda.total ?? 0,
        venda.total ?? 0,
        funcionario!,
        Cliente(
            estado: Estado.ATIVADO, nome: "Cliente Corrente", numero: "999999"),
        data,
        data,
        venda.produto?.id ?? -1,
        venda.quantidadeVendida ?? 0);

    for (var i = 0; i < lista.length; i++) {
      if (lista[i].produto!.nome == produto.nome) {
        lista[i].id = id;
      }
    }
  }

  Future pegarTotalDividas() async {
    var res = await _manipularVendaI.pegarListaTodasPagamentoDividasFuncionario(
        funcionario!, data);
    totalDividaPagas.value = 0;
    for (var cada in res) {
      totalDividaPagas.value += cada.valor ?? 0;
    }
  }

  Future pegarLista() async {
    lista.clear();
    var res = await _manipularVendaI.pegarLista(funcionario, data);
    for (var cada in res) {
      lista.add(cada);
      totalCaixa.value += cada.total ?? 0;
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  Future pegarListaVendas() async {
    lista.clear();
    var res = await _manipularVendaI.pegarListaVendas(funcionario, data);
    for (var cada in res) {
      lista.add(cada);
    }
  }

  Future pegarListaEncomendas() async {
    lista.clear();
    var res = await _manipularVendaI.pegarListaEncomendas(funcionario, data);
    for (var cada in res) {
      lista.add(cada);
    }
  }

  Future pegarListaDividas() async {
    lista.clear();
    var res = await _manipularVendaI.pegarListaDividas(funcionario, data);
    for (var cada in res) {
      lista.add(cada);
    }
  }

  void mostrarDialogoDetalhesVenda(Venda venda) {
    mostrarDialogoDeLayou(LayoutDetalhesVenda(
      venda: venda,
    ));
  }

  mostraDialogoEntregarEncomenda(Venda venda) {
    mostrarDialogoDeLayou(LayoutConfirmacaoAccao(
      accaoAoCancelar: () {
        voltar();
      },
      accaoAoConfirmar: () async {
        await entregarEncomenda(venda);
      },
      corButaoSim: primaryColor,
      pergunta: "Deseja mesmo finalizar esta encomenda?",
    ));
  }

  Future<void> entregarEncomenda(Venda venda) async {
    if (venda.divida == true) {
      mostrarDialogoDeInformacao(
          "Ainda tem ${formatar(venda.total! - venda.parcela!)} KZ por pagar!");
      return;
    }
    lista.removeWhere((element) => element.id == venda.id);
    voltar();
    await _manipularVendaI.entregarEncomenda(venda);
  }

  void mostrarFormasPagamento(Venda venda, BuildContext context,
      {bool? comPagamentoFinal}) async {
    if (venda.divida == false) {
      mostrarSnack("Está tudo pago!");
      return;
    }
    mostrarDialogoDeLayou(
        FutureBuilder<List<FormaPagamento>>(
            future: _manipularPagamentoI.pegarListaFormasPagamento(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              }
              if (snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Nenhuma Forma de Pagamento!"),
                );
              }
              var lista = snapshot.data!.map((e) => e.descricao!).toList();
              return LayoutFormaPagamento(
                  accaoAoFinalizar: (valor, opcao) async {
                    await adicionarValorPagamento(venda, valor, opcao,
                        comPagamentoFinal: comPagamentoFinal);
                  },
                  titulo: "Selecione a Forma de Pagamento",
                  listaItens: lista);
            }),
        naoFechar: true);
  }

  Future<void> adicionarValorPagamento(Venda venda, String valor, String? opcao,
      {bool? comPagamentoFinal}) async {
    var soma = (venda.pagamentos ?? []).fold<double>(
        0, (previousValue, element) => element.valor! + previousValue);
    if ((soma + double.parse(valor)) > venda.total!) {
      mostrarDialogoDeInformacao("""Valor demasiado alto!""");
      return;
    }
    voltar();
    var forma = (await _manipularPagamentoI.pegarListaFormasPagamento())
        .firstWhere((element) => element.descricao == opcao);
    var novoPagamento = Pagamento(
        idVenda: venda.id,
        idParaVista: gerarIdUnico(),
        idFormaPagamento: forma.id,
        formaPagamento: forma,
        estado: Estado.ATIVADO,
        valor: double.parse(valor));
    venda.pagamentos ??= [];
    venda.pagamentos!.add(novoPagamento);
    venda.parcela = venda.parcela! + double.parse(valor);

    var hoje = DateTime.now();
    var id = await _manipularPagamentoI.registarPagamento(novoPagamento);
    var pagamentoFinal =
        PagamentoFinal(estado: Estado.ATIVADO, idPagamento: id, data: hoje);
    novoPagamento.pagamentoFinal = pagamentoFinal;

    if (comPagamentoFinal != null) {
      await _manipularPagamentoI.registarPagamentoFinal(pagamentoFinal);
    }
    totalDividaPagas.value += double.parse(valor);

    for (var i = 0; i < lista.length; i++) {
      if (lista[i].id == venda.id) {
        lista[i] = venda;
        break;
      }
    }
    // await _manipularVendaI.actualizarVenda(venda);
  }

  Future<List<Preco>> pegarPrecoProduto(Produto produto) async {
    return await _manipularProdutoI.pegarPrecoProdutoDeId(produto.id!);
  }

  void vender(
      Venda venda, int indice, bool vendaMultipla, bool fazerOuDesfazer) async {
    var actualizada = Venda.fromJson(venda.toJson());
    if (venda.precos!.isEmpty) {
      mostrarDialogoDeInformacao("Produto sem preço!");
      return;
    }
    if (venda.precos!.length == 1) {
      if (vendaMultipla == true) {
        mostrarDialogoDeLayou(LayoutQuantidade(
            accaoAoFinalizar: (qtdMultipla, opcao) {
              voltar();
              var novaQtd = (venda.precos![0].quantidade ?? 0) * qtdMultipla;
              var novoPreco = (venda.precos![0].preco ?? 0) * qtdMultipla;
              actualizada.quantidade = novaQtd;
              actualizarVenda(actualizada, venda, novaQtd, novoPreco, indice,
                  fazerOuDesfazer);
            },
            titulo: "Quantidade",
            comOpcaoRetirada: false));

        return;
      }
      var novaQtd = (venda.precos![0].quantidade ?? 0);
      var novoPreco = (venda.precos![0].preco ?? 0);
      actualizada.quantidade = novaQtd;
      actualizarVenda(
          actualizada, venda, novaQtd, novoPreco, indice, fazerOuDesfazer);
      return;
    }
    mostrarDialogoDeLayou(Column(
      children: [
        Text("Seleccione a Quantidade"),
        SizedBox(
          height: 20,
        ),
        Column(
          children: venda.precos!
              .map((e) => ModeloItemLista(
                    itemComentado: false,
                    tituloItem: "${e.quantidade ?? 0}",
                    metodoChamadoAoClicarItem: () {
                      voltar();
                      if (vendaMultipla == true) {
                        mostrarDialogoDeLayou(LayoutQuantidade(
                            accaoAoFinalizar: (qtdMultipla, opcao) {
                              actualizada.quantidade =
                                  (e.quantidade ?? 0) * qtdMultipla;
                              voltar();
                              actualizarVenda(
                                  actualizada,
                                  venda,
                                  (e.quantidade ?? 0) * qtdMultipla,
                                  (e.preco ?? 0) * qtdMultipla,
                                  indice,
                                  fazerOuDesfazer);
                            },
                            titulo: "Quantidade",
                            comOpcaoRetirada: false));

                        return;
                      }
                      actualizada.quantidade = (e.quantidade ?? 0);
                      actualizarVenda(actualizada, venda, e.quantidade ?? 0,
                          e.preco ?? 0, indice, fazerOuDesfazer);
                    },
                  ))
              .toList(),
        ),
      ],
    ));
  }

  void actualizarVenda(Venda actualizada, Venda venda, int novaQtd,
      double novoPreco, int indice, bool fazerOuDesfazer) async {
    if (fazerOuDesfazer == true) {
      actualizada.quantidadeVendida = (venda.quantidadeVendida ?? 0) + novaQtd;
      actualizada.total = (venda.total ?? 0) + (novoPreco);

      totalCaixa.value += (novoPreco);
    } else {
      actualizada.quantidadeVendida = (venda.quantidadeVendida ?? 0) - novaQtd;
      actualizada.total = (venda.total ?? 0) - (novoPreco);

      totalCaixa.value -= (novoPreco);
    }
    actualizada.linhaPintada.value = true;
    lista[indice] = actualizada;

    lista[indice].parcela = lista[indice].total;
    await _manipularVendaI.actualizarVenda(lista[indice], fazerOuDesfazer);
  }

  void escolherData(
      BuildContext context, PainelFuncionarioC funcionarioC) async {
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje.subtract(Duration(days: 1)),
        firstDate: hoje.subtract(Duration(days: 365 * 3)),
        lastDate: hoje.subtract(Duration(days: 1)));
    if (dataSelecionada == null) {
      return;
    }
    Get.delete<VendasC>();
    totalCaixa.value = 0;
    totalDividaPagas.value = 0;
    funcionarioC.irParaPainel(PainelActual.VENDAS_FUNCIONARIOS,
        valor: [funcionario, dataSelecionada]);
  }
}
