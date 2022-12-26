import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_preco_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_stock_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../contratos/casos_uso/manipular_produto_i.dart';
import '../../../../../../dominio/casos_uso/manipula_stock.dart';
import '../../../../../../dominio/casos_uso/manipular_preco.dart';
import '../../../../../../dominio/casos_uso/manipular_produto.dart';
import '../../../../../../dominio/entidades/preco.dart';
import '../../../../../../fonte_dados/provedores/provedor_preco.dart';
import '../../../../../../fonte_dados/provedores/provedor_produto.dart';
import '../../../../../../fonte_dados/provedores/provedor_stock.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../../solucoes_uteis/pdf_api/geral_pdf.dart';
import '../../../../../../solucoes_uteis/pdf_api/pdf_api.dart';
import '../../../funcionario/sub_paineis/vendas/layouts/mesa_venda/mesa_venda.dart';

class PainelInventarioC extends GetxController {
  var produtos = <Produto>[].obs;
  var produtosCopia = <Produto>[];
  var totalVendas = 0.0.obs;
  var totalLucros = 0.0.obs;
  final Funcionario funcionario;
  late ManipularProdutoI _manipularProdutoI;
  late ManipularStockI _manipularStockI;
  late ManipularPrecoI _manipularPrecoI;

  PainelInventarioC({required this.funcionario}) {
    _manipularPrecoI = ManipularPreco(ProvedorPreco());
    _manipularStockI = ManipularStock(ProvedorStock());
    _manipularProdutoI =
        ManipularProduto(ProvedorProduto(), _manipularStockI, _manipularPrecoI);
  }

  @override
  void onInit() async {
    await pegarDados();
    super.onInit();
  }

  Future<void> pegarDados() async {
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      var s = await _manipularStockI.pegarStockDoProdutoDeId(cada.id ?? -1);
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
        cada.precoGeral = maiorPreco.toDouble();
        cada.quantidade = (s?.quantidade ?? 0);
        cada.dinheiro = (s?.quantidade ?? 0) * cada.precoGeral;
        cada.investimento = (s?.quantidade ?? 0) * (cada.precoCompra ?? 0);
        cada.lucro = cada.dinheiro - cada.investimento;
      } else {
        cada.precoGeral = 0;
        cada.quantidade = (s?.quantidade ?? 0);
        cada.dinheiro = 0;
      }
      produtos.add(cada);
    }
    produtosCopia.addAll(produtos);
  }

  void mostrarDialogoNovaVenda(BuildContext context) {
    mostrarDialogoDeLayou(LayoutMesaVenda(DateTime.now(), funcionario));
  }

  Future<Stock?> pegarStock(Produto produto) async {
    var res = await _manipularStockI.pegarStockDoProdutoDeId(produto.id ?? -1);
    return res;
  }

  Future<void> calcularDiferenca(int indice, String dado) async {
    var produto = produtos[indice];
    if (dado.isEmpty) {
      produto.quantidadeExistente = 0;
      produto.diferenca = 0;
      produto.vendaEstimado = 0;
      produto.lucroEstimado = 0;
    } else {
      produto.quantidadeExistente = int.parse(dado);
      produto.diferenca = produto.quantidade - int.parse(dado);
      produto.vendaEstimado = produto.diferenca * produto.precoGeral;
      produto.lucroEstimado = produto.vendaEstimado -
          (produto.diferenca) * (produto.precoCompra ?? 0);
    }

    totalVendas.value = 0;
    totalLucros.value = 0;

    for (var i = 0; i < produtos.length; i++) {
      if (produtos[i].nome == produto.nome) {
        produtos[i] = produto;
      }
    }
    for (var i = 0; i < produtosCopia.length; i++) {
      if (produtosCopia[i].nome == produto.nome) {
        produtosCopia[i] = produto;
      }

      totalVendas.value += produtosCopia[i].vendaEstimado;
      totalLucros.value += produtosCopia[i].lucroEstimado;
    }
  }

  Future<List<Preco>> pegarPreco(Produto produto) async {
    return await _manipularPrecoI.pegarPrecoProdutoDeId(produto.id ?? -1);
  }

  Future<double> pegarPrecoGeral(Produto produto) async {
    var precos = await pegarPreco(produto);
    if (precos.isNotEmpty) {
      if (precos.length == 1) {
        return precos[0].preco ?? 0;
      }
      return (precos[0].preco ?? 0) > (precos[1].preco ?? 0)
          ? (precos[0].preco ?? 0)
          : (precos[1].preco ?? 0);
    }
    return 0;
  }

  void mostrarDialogoPerguntar() {
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            corButaoSim: primaryColor,
            pergunta:
                "Deseja mesmo realizar esta tarefa?\nEsta acção não pode ser revertida!\nSeus produtos irão sofrer baixa de Stock!",
            accaoAoConfirmar: () async {
              voltar();
              gerarRelatorio();
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }

  void gerarRelatorio({bool? modoDemo}) async {
    mostrarCarregandoDialogoDeInformacao("Fazendo Demonstração de Inventário");
    List<List<String>> listaItens = [];
    var hoje = DateTime.now();
    double totalVendas = 0;
    double totalLucro = 0;
    var maniStock = ManipularSaida(ProvedorSaida(), _manipularStockI);
    for (var cada in produtos) {
      if (modoDemo == false || modoDemo == null) {
        await maniStock.registarSaida(Saida(
            estado: Estado.ATIVADO,
            idProduto: cada.id,
            quantidade: cada.diferenca,
            motivo: Saida.MOTIVO_INVENTARIO,
            data: hoje));
      }
      totalVendas += cada.vendaEstimado;
      totalLucro += cada.lucroEstimado;
      listaItens.add([
        (cada.nome ?? "SEM REGISTO"),
        formatar(cada.precoGeral),
        formatarInteiroComMilhares(cada.quantidade),
        formatar(cada.dinheiro),
        formatarInteiroComMilhares(cada.quantidadeExistente ?? 0),
        formatarInteiroComMilhares(cada.diferenca),
        formatar(cada.vendaEstimado),
        formatar(cada.lucroEstimado),
      ]);
    }
    gerarPDF(listaItens, hoje, totalVendas, totalLucro, modoDemo: modoDemo);
    if (modoDemo == false || modoDemo == null) {
      produtos.clear();
      produtosCopia.clear();
      await pegarDados();
    }
  }

  void gerarPDF(List<List<String>> dados, DateTime data, double totalVendas,
      double totalLucro,
      {bool? modoDemo}) async {
    try {
      var pdfFile = await GeralPdf.generate(
          modoDemo == true ? "DEMONSTRAÇÃO DE INVENTÁRIO" : "INVENTÁRIO",
          [
            "Produto",
            "Preço de Venda",
            "Qtd Recebida",
            "Venda Esperada",
            "Qtd Existente",
            "Qtd Vendida",
            "Venda Est.",
            "Lucro Est.",
          ],
          dados,
          data,
          informacaoExtra:
              "Total Estimado de Vendas: ${formatar(totalVendas)} \nTotal Estimado de Lucro: ${formatar(totalLucro)}");
      voltar();
      PdfApi.openFile(pdfFile);
    } catch (e) {
      mostrarDialogoDeInformacao(
          "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
    }
  }

  void aoPesquisar(String dado) async {
    produtos.clear();
    for (var cada in produtosCopia) {
      if ((cada.nome ?? "").toLowerCase().contains(dado.toLowerCase())) {
        produtos.add(cada);
      }
    }
  }
}
