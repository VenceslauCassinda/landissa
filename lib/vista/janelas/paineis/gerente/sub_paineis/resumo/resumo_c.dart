import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_caixa_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_venda_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida_caixa.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_venda.dart';
import 'package:yetu_gestor/dominio/entidades/caixa.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida_caixa.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_venda.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/solucoes_uteis/utils.dart';
import 'package:yetu_gestor/vista/aplicacao_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/recepcoes/layouts/layouts_produtos_completo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

import '../../../../../../contratos/casos_uso/manipular_item_venda_i.dart';
import '../../../../../../contratos/casos_uso/manipular_pagamento_i.dart';
import '../../../../../../contratos/casos_uso/manipular_preco_i.dart';
import '../../../../../../contratos/casos_uso/manipular_produto_i.dart';
import '../../../../../../contratos/casos_uso/manipular_stock_i.dart';
import '../../../../../../dominio/casos_uso/manipula_stock.dart';
import '../../../../../../dominio/casos_uso/manipular_cliente.dart';
import '../../../../../../dominio/casos_uso/manipular_item_venda.dart';
import '../../../../../../dominio/casos_uso/manipular_pagamento.dart';
import '../../../../../../dominio/casos_uso/manipular_preco.dart';
import '../../../../../../dominio/casos_uso/manipular_produto.dart';
import '../../../../../../dominio/casos_uso/manipular_saida.dart';
import '../../../../../../fonte_dados/provedores/provedor_cliente.dart';
import '../../../../../../fonte_dados/provedores/provedor_item_venda.dart';
import '../../../../../../fonte_dados/provedores/provedor_pagamento.dart';
import '../../../../../../fonte_dados/provedores/provedor_preco.dart';
import '../../../../../../fonte_dados/provedores/provedor_produto.dart';
import '../../../../../../fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../fonte_dados/provedores/provedor_stock.dart';

class PainelResumoC extends GetxController {
  late ManipularProdutoI _manipularProdutoI;
  late ManipularStockI _manipularStockI;
  late ManipularVendaI _manipularVendaI;
  late ManipularItemVendaI _manipularItemVendaI;
  late PainelGerenteC _painelGerenteC;
  late ManipularPagamentoI _manipularPagamentoI;
  late ManipularSaidaCaixaI _manipularSaidaCaixaI;
  late ManipularSaidaI _manipularSaidaI;
  var vendas = RxDouble(-1.0);
  var lucros = RxDouble(-1.0);
  var saldo = RxDouble(-1.0);
  var investimento = RxDouble(-1.0);
  var caixaAtual = RxDouble(-1.0);
  var totalSaidaCaixa = 0.0.obs;
  var totalEntradaCaixa = 0.0.obs;
  late ManipularPrecoI _manipularPrecoI;

  Funcionario? funcionario;

  RxList<DateTime> lista = RxList();
  List<DateTime> listaCopia = [];
  PainelResumoC(this.funcionario) {
    _manipularSaidaCaixaI = ManipularSaidaCaixa(ProvedorSaidaCaixa());
    _manipularStockI = ManipularStock(ProvedorStock());
    _manipularProdutoI = ManipularProduto(
        ProvedorProduto(), _manipularStockI, ManipularPreco(ProvedorPreco()));
    _manipularPagamentoI = ManipularPagamento(ProvedorPagamento());
    _manipularPrecoI = ManipularPreco(ProvedorPreco());
    _manipularItemVendaI = ManipularItemVenda(
        ProvedorItemVenda(),
        ManipularProduto(ProvedorProduto(), _manipularStockI, _manipularPrecoI),
        ManipularStock(ProvedorStock()));
    _manipularSaidaI = ManipularSaida(ProvedorSaida(), _manipularStockI);
    _manipularVendaI = ManipularVenda(
        ProvedorVenda(),
        _manipularSaidaI,
        ManipularPagamento(ProvedorPagamento()),
        ManipularCliente(ProvedorCliente()),
        _manipularStockI,
        _manipularItemVendaI);
  }

  @override
  void onInit() async {
    await pegarCaixa();
    await pegarInvestimento();
    super.onInit();
  }

  int mySortComparison(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  pegarProdutosMaisSaidos() async {
    mostrarCarregandoDialogoDeInformacao("Buscando dados");
    var res = <Produto>[];
    var produtos = await _manipularProdutoI.pegarLista();
    for (var produto in produtos) {
      var saidas = await _manipularSaidaI.pegarListaDoProduto(produto);
      var total = saidas.fold<int>(
          0,
          (previousValue, element) =>
              (element.quantidade ?? 0) + previousValue);
      produto.quantidade = total;
      mostrar(produto.nome);
      mostrar(produto.quantidade);
      res.add(produto);
    }

    res.sort((a, b) {
      return mySortComparison(a.quantidade, b.quantidade);
    });
    // res.removeRange(9, res.length - 1);
    voltar();
    mostrarDialogoDeLayou(LayoutProdutosCompleto(
        lista: RxList<Produto>(res),
        aoClicarItem: (p) {},
        manipularProdutoI: _manipularProdutoI));
  }

  pegarCaixa() async {
    totalEntradaCaixa.value = 0;
    totalSaidaCaixa.value = 0;
    double saldoS = 0;
    var res = await _manipularSaidaCaixaI.pegarLista();
    for (var cada in res) {
      var valor = cada.valor ?? 0;
      if (valor >= 0) {
        totalEntradaCaixa.value += valor;
      } else {
        totalSaidaCaixa.value += valor;
      }
      if ((cada.motivo ?? "").contains(Caixa.MOTIVO_SALDO)) {
        saldoS += valor;
      }
    }
    caixaAtual.value = totalEntradaCaixa.value - (totalSaidaCaixa.value * -1);
    saldo.value = saldoS;
  }

  pegarInvestimento() async {
    double investimentoS = 0;
    double vendasS = 0;
    double lucrosS = 0;
    vendas.value = 0;
    lucros.value = 0;
    var res = await _manipularProdutoI.pegarLista();
    var hoje = DateTime.now();
    for (var cada in res) {
      var s = await _manipularStockI.pegarStockDoProdutoDeId(cada.id ?? -1);
      if (s != null) {
        investimentoS += (s.quantidade ?? 0) * (cada.precoCompra ?? 0);
      }
      var precos = await _manipularPrecoI.pegarPrecoProdutoDeId(cada.id ?? -1);
      var maiorPreco = 0;
      if (precos.isNotEmpty) {
        if (precos.length == 1) {
          maiorPreco = (precos[0].preco ?? 0).toInt();
        } else {
          maiorPreco = (precos[0].preco ?? 0) > (precos[1].preco ?? 0)
              ? (precos[0].preco ?? 0) ~/ (precos[0].quantidade ?? 0)
              : (precos[1].preco ?? 0) ~/ (precos[1].quantidade ?? 0);
        }
      }
      var saidas = await _manipularSaidaI.pegarListaDoProduto(cada);

      var total = saidas.fold<int>(0, (previousValue, element) {
        if (element.motivo != Saida.MOTIVO_VENDA) {
          return previousValue;
        }
        if ((comapararDatas(
                    element.data!, DateTime(hoje.year, hoje.month, 1)) ||
                element.data!.isAfter(DateTime(hoje.year, hoje.month, 1))) &&
            (comapararDatas(
                    element.data!, DateTime(hoje.year, hoje.month, 30)) ||
                element.data!.isBefore(DateTime(hoje.year, hoje.month, 30)))) {
          return (element.quantidade ?? 0) + previousValue;
        }
        return previousValue;
      });
      vendasS += total * maiorPreco;
      lucrosS += total * (maiorPreco - (cada.precoCompra ?? 0));
    }
    vendas.value = vendasS;
    lucros.value = lucrosS;
    investimento.value = investimentoS;
  }

  void aoPesquisar(String f) {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      if ((DateTime(cada.year, cada.month, cada.day))
          .toString()
          .toLowerCase()
          .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  Future<List<DateTime>> pegarLista() async {
    var res = [];
    if (funcionario != null) {
      res =
          await _manipularVendaI.pegarListaDataVendasFuncionario(funcionario!);
    } else {
      res = await _manipularVendaI.pegarListaDataVendas();
    }
    for (var cada in res) {
      lista.add(cada);
    }
    listaCopia.clear();
    listaCopia.addAll(lista);
    return lista;
  }

  void terminarSessao() {
    PainelGerenteC c = Get.find();
    c.terminarSessao();
  }

  void seleccionarData(DateTime data, {Funcionario? funcionario}) {
    PainelGerenteC c = Get.find();
    c.irParaPainel(PainelActual.VENDAS_ANTIGA, valor: [data, funcionario]);
  }

  void mostrarDialogoApagarAntes(BuildContext context) async {
    var data = await showDatePicker(
        context: context,
        // locale: const Locale("pt", "PT"),
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (data != null) {
      mostrarDialogoDeLayou(
          LayoutConfirmacaoAccao(
              pergunta:
                  "Deseja mesmo apagar as vendas feitas antes de ${formatarMesOuDia(data.day)}/${formatarMesOuDia(data.month)}/${data.year}?",
              accaoAoConfirmar: () async {
                await _removerAntesData(data);
              },
              accaoAoCancelar: () {},
              corButaoSim: primaryColor),
          layoutCru: true);
    }
  }

  Future<void> _removerAntesData(DateTime data) async {
    lista.removeWhere((cada) => cada.isBefore(data));
    voltar();
    await _manipularVendaI.removerVendasAntesData(data);
  }

  void mostrarDialogoApagarTudo(BuildContext context) {
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            pergunta: "Deseja mesmo apagar todas as vendas feitas?",
            accaoAoConfirmar: () async {
              await _removerTodas();
            },
            accaoAoCancelar: () {},
            corButaoSim: primaryColor),
        layoutCru: true);
  }

  Future<void> _removerTodas() async {
    lista.clear();
    voltar();
    await _manipularVendaI.removerTodasVendas();
  }

  void mostrarDialogoEntradasAcumuladas(BuildContext context) async {
    var hoje = DateTime.now();
    var dataInicio = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA INÍCIO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    var dataFim = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA DE TÉRMINO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: hoje);
    if (dataInicio == null || dataFim == null) {
      return;
    }
    if (dataInicio.isAfter(dataFim)) {
      mostrarDialogoDeInformacao(
          "O intervalo entre as data seleccionadas é invalido!");
      return;
    }
    mostrarCarregandoDialogoDeInformacao("Carregando...");
    double totalE = 0;
    double totalS = 0;
    var res = await _manipularSaidaCaixaI.pegarLista();
    for (var cada in res) {
      var valor = cada.valor ?? 0;
      if ((comapararDatas(cada.data!, dataInicio) ||
              cada.data!.isAfter(dataInicio)) &&
          (comapararDatas(cada.data!, dataFim) ||
              cada.data!.isBefore(dataFim))) {
        if (valor >= 0) {
          totalE += valor;
        } else {
          totalS += valor;
        }
      }
    }
    voltar();
    mostrarDialogoDeLayou(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Entre: ${formatarData(dataInicio, semHora: true)} e ${formatarData(dataFim, semHora: true)}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Entradas de Caixa Acumuladas: ${formatar(totalE)}",
                style: const TextStyle(color: primaryColor, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Saídas de Caixa Acumuladas: ${formatar(totalS < 0 ? (totalS * -1) : totalS)}",
                style: const TextStyle(color: primaryColor, fontSize: 14),
              ),
            ],
          ),
        ),
        layoutCru: true);
  }

  void mostrarDialogoSaldoAcumulado(BuildContext context,
      {bool? comprasAcomuladas}) async {
    var hoje = DateTime.now();
    var dataInicio = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA INÍCIO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    var dataFim = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA DE TÉRMINO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: hoje);
    if (dataInicio == null || dataFim == null) {
      return;
    }
    if (dataInicio.isAfter(dataFim)) {
      mostrarDialogoDeInformacao(
          "O intervalo entre as data seleccionadas é invalido!");
      return;
    }
    mostrarCarregandoDialogoDeInformacao("Carregando...");
    double totalE = 0;
    double totalS = 0;
    var res = await _manipularSaidaCaixaI.pegarLista();
    for (var cada in res) {
      if ((cada.motivo ?? "").contains(Caixa.MOTIVO_SALDO)) {
        var valor = cada.valor ?? 0;
        if ((comapararDatas(cada.data!, dataInicio) ||
                cada.data!.isAfter(dataInicio)) &&
            (comapararDatas(cada.data!, dataFim) ||
                cada.data!.isBefore(dataFim))) {
          if (comprasAcomuladas == true) {
            if (valor < 0) {
              totalS += valor;
            }
          } else {
            if (valor >= 0) {
              totalE += valor;
            } else {
              totalS += valor;
            }
          }
        }
      }
    }
    voltar();
    if (comprasAcomuladas == true) {
      mostrarDialogoDeLayou(
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Entre: ${formatarData(dataInicio, semHora: true)} e ${formatarData(dataFim, semHora: true)}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Compras de Saldo Acumuladas: ${formatar(totalS < 0 ? (totalS * -1) : totalS)}",
                  style: const TextStyle(color: primaryColor, fontSize: 14),
                ),
              ],
            ),
          ),
          layoutCru: true);
      return;
    }
    mostrarDialogoDeLayou(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Entre: ${formatarData(dataInicio, semHora: true)} e ${formatarData(dataFim, semHora: true)}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Entradas de Saldo Acumuladas: ${formatar(totalE)}",
                style: const TextStyle(color: primaryColor, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Saídas de Saldo Acumuladas: ${formatar(totalS < 0 ? (totalS * -1) : totalS)}",
                style: const TextStyle(color: primaryColor, fontSize: 14),
              ),
            ],
          ),
        ),
        layoutCru: true);
  }

  void mostrarDialogoVendascumuladas(BuildContext context) async {
    var hoje = DateTime.now();
    var dataInicio = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA INÍCIO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    var dataFim = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA DE TÉRMINO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: hoje);
    if (dataInicio == null || dataFim == null) {
      return;
    }
    if (dataInicio.isAfter(dataFim)) {
      mostrarDialogoDeInformacao(
          "O intervalo entre as data seleccionadas é invalido!");
      return;
    }
    mostrarCarregandoDialogoDeInformacao("Carregando...");
    double totalV = 0;
    double totalL = 0;
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      var s = await _manipularStockI.pegarStockDoProdutoDeId(cada.id ?? -1);
      if (s != null) {
        investimento.value += (s.quantidade ?? 0) * (cada.precoCompra ?? 0);
      }
      var precos = await _manipularPrecoI.pegarPrecoProdutoDeId(cada.id ?? -1);
      var maiorPreco = 0;
      if (precos.isNotEmpty) {
        if (precos.length == 1) {
          maiorPreco = (precos[0].preco ?? 0).toInt();
        } else {
          maiorPreco = (precos[0].preco ?? 0) > (precos[1].preco ?? 0)
              ? (precos[0].preco ?? 0) ~/ (precos[0].quantidade ?? 0)
              : (precos[1].preco ?? 0) ~/ (precos[1].quantidade ?? 0);
        }
      }
      var saidas = await _manipularSaidaI.pegarListaDoProduto(cada);

      var total = saidas.fold<int>(0, (previousValue, element) {
        if (element.motivo != Saida.MOTIVO_VENDA) {
          return previousValue;
        }
        if ((comapararDatas(element.data!, dataInicio) ||
                element.data!.isAfter(dataInicio)) &&
            (comapararDatas(element.data!, dataFim) ||
                element.data!.isBefore(dataFim))) {
          return (element.quantidade ?? 0) + previousValue;
        }
        return previousValue;
      });
      totalV += total * maiorPreco;
      totalL += total * (maiorPreco - (cada.precoCompra ?? 0));
      voltar();
      mostrarDialogoDeLayou(
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Entre: ${formatarData(dataInicio, semHora: true)} e ${formatarData(dataFim, semHora: true)}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Vendas Acumuladas: ${formatar(totalV)}",
                  style: const TextStyle(color: primaryColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Lucro Acumulado: ${formatar(totalL)}",
                  style: const TextStyle(color: primaryColor, fontSize: 14),
                ),
              ],
            ),
          ),
          layoutCru: true);
    }
  }
}
