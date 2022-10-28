import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_funcionario_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_receccao_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipula_stock.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_entrada.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_preco.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_produto.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_receccao.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_entrada.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_preco.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_receccao.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/layouts/layout_receber_completo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

import '../../../../../../../contratos/casos_uso/manipular_stock_i.dart';
import '../../../../../../../dominio/casos_uso/manipular_fincionario.dart';
import '../../../../../../../dominio/casos_uso/manipular_usuario.dart';
import '../../../../../../../dominio/entidades/estado.dart';
import '../../../../../../../fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../../fonte_dados/provedores/provedor_stock.dart';
import '../../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/pdf_api/geral_pdf.dart';
import '../../../../../../solucoes_uteis/pdf_api/pdf_api.dart';
import '../../../../../aplicacao_c.dart';
import '../../layouts/layout_produto.dart';
import '../../layouts/layout_quantidade.dart';

class PainelInvestimentoC extends GetxController {
  var lista = RxList<Produto>();
  var listaCopia = <Produto>[];
  late ManipularProdutoI _manipularProdutoI;
  late ManipularStockI _manipularStockI;
  late ManipularRececcaoI _manipularRececcaoI;
  late ManipularFuncionarioI _manipularFuncionarioI;
  late ManipularSaidaI _manipularSaidaI;
  var indiceTabActual = 1.obs;

  var totalInvestido = 0.0.obs;
  PainelInvestimentoC() {
    _manipularStockI = ManipularStock(ProvedorStock());
    _manipularProdutoI = ManipularProduto(
        ProvedorProduto(), _manipularStockI, ManipularPreco(ProvedorPreco()));
    _manipularRececcaoI = ManipularRececcao(
        ProvedorRececcao(),
        ManipularEntrada(ProvedorEntrada(), _manipularStockI),
        _manipularProdutoI);
    _manipularFuncionarioI = ManipularFuncionario(
        ManipularUsuario(ProvedorUsuario()), ProveedorFuncionario());
    _manipularSaidaI = ManipularSaida(ProvedorSaida(), _manipularStockI);
  }

  @override
  void onInit() async {
    await pegarActivos();
    super.onInit();
  }

  void aoPesquisar(String f) {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      if (cada.nome!.toLowerCase().contains(f.toLowerCase()) ||
          cada.precoCompra!
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase()) ||
          (cada.stock?.quantidade ?? 0)
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  Future<void> pegarTodos() async {
    lista.clear();
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      lista.add(cada);
    }
  }

  Future<void> pegarActivos() async {
    totalInvestido.value = 0;
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      var s = await _manipularStockI.pegarStockDoProdutoDeId(cada.id ?? -1);
      if (cada.estado == Estado.ATIVADO) {
        cada.stock = s;
        lista.add(cada);
        totalInvestido.value += (s?.quantidade ?? 0) * (cada.precoCompra ?? 0);
      }
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  Future<void> pegarDesactivos() async {
    lista.clear();
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      if (cada.estado == Estado.DESACTIVADO) {
        lista.add(cada);
      }
    }
  }

  Future<void> pegarElimindados() async {
    lista.clear();
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      if (cada.estado == Estado.ELIMINADO) {
        lista.add(cada);
      }
    }
  }

  Future<void> navegar(int tab) async {
    indiceTabActual.value = tab;
    if (tab == 0) {
      await pegarTodos();
    }
    if (tab == 1) {
      await pegarActivos();
    }
    if (tab == 2) {
      await pegarDesactivos();
    }
    if (tab == 3) {
      await pegarElimindados();
    }
  }

  void mostrarDialogoAdicionarProduto() {
    mostrarDialogoDeLayou(LayoutProduto(
      accaoAoFinalizar: (
        nome,
        precoCompra,
      ) async {
        await _adicionarProduto(nome, precoCompra);
      },
    ));
  }

  void _somarQuantidadeProduto(Produto produto, String quantidade) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i].id == produto.id) {
        produto.stock!.quantidade =
            ((lista[i].stock!.quantidade! + int.parse(quantidade)));
        lista[i] = produto;
        fecharDialogoCasoAberto();
        break;
      }
    }
  }

  void _subtrairQuantidadeProduto(Produto produto, String quantidade) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i].id == produto.id) {
        produto.stock!.quantidade =
            ((lista[i].stock!.quantidade! - int.parse(quantidade)));
        lista[i] = produto;
        fecharDialogoCasoAberto();
        break;
      }
    }
  }

  void _alterarProduto(Produto produto) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i].id == produto.id) {
        lista[i] = produto;
        fecharDialogoCasoAberto();
        break;
      }
    }
  }

  void mostrarDialogoActualizarProduto(Produto produto) {
    mostrarDialogoDeLayou(LayoutProduto(
      produto: produto,
      accaoAoFinalizar: (nome, precoCompra) async {
        await _actualizarProduto(nome, precoCompra, produto);
      },
    ));
  }

  void mostrarDialogoEliminarProduto(Produto produto) {
    mostrarDialogoDeLayou(LayoutConfirmacaoAccao(
        corButaoSim: primaryColor,
        pergunta: "Deseja mesmo eliminar o Produto ${produto.nome}",
        accaoAoConfirmar: () async {
          await _manipularProdutoI.removerProduto(produto);
          await _eliminarProduto(produto);
        },
        accaoAoCancelar: () {}));
  }

  void recuperarProduto(Produto produto) async {
    await _manipularProdutoI.recuperarProduto(produto);
    _eliminarProduto(produto);
  }

  void activarProduto(Produto produto) async {
    await _manipularProdutoI.activarProduto(produto);
    _eliminarProduto(produto);
  }

  void desactivarProduto(Produto produto) async {
    await _manipularProdutoI.desactivarrProduto(produto);
    _eliminarProduto(produto);
  }

  Future<void> _eliminarProduto(Produto produto) async {
    lista.removeWhere((element) => element.id == produto.id);
    fecharDialogoCasoAberto();
  }

  Future<void> _adicionarProduto(
    String nome,
    String precoCompra,
  ) async {
    try {
      var novoProduto =
          Produto(nome: nome, precoCompra: double.parse(precoCompra));
      var id = await _manipularProdutoI.adicionarProduto(novoProduto);
      novoProduto.id = id;
      // await _manipularProdutoI.adicionarPrecoProduto(
      //     novoProduto, double.parse(precoVenda));
      novoProduto.stock = Stock.zerado();
      lista.add(novoProduto);
      fecharDialogoCasoAberto();
    } on Erro catch (e) {
      mostrarDialogoDeInformacao(e.sms);
    }
  }

  Future<void> _actualizarProduto(
      String nome, String precoCompra, Produto produto) async {
    try {
      for (var i = 0; i < lista.length; i++) {
        if (lista[i].id == produto.id) {
          produto.nome = nome;
          produto.precoCompra = double.parse(precoCompra);
          lista[i] = produto;
          await _manipularProdutoI.actualizarProduto(produto);
          // await _manipularProdutoI.atualizarPrecoProduto(
          //     produto, double.parse(precoVenda));
          fecharDialogoCasoAberto();
          break;
        }
      }
    } on Erro catch (e) {
      mostrarDialogoDeInformacao(e.sms);
    }
  }

  void terminarSessao() {
    AplicacaoC.terminarSessao();
  }

  Future<void> _retirarProduto(Produto produto, String quantidade,
      String opcaoRetiradaSelecionada) async {
    try {
      var data = DateTime.now();
      await _manipularSaidaI.registarSaida(Saida(
          idProduto: produto.id,
          quantidade: int.parse(quantidade),
          estado: Estado.ATIVADO,
          data: data,
          motivo: opcaoRetiradaSelecionada));
      _subtrairQuantidadeProduto(produto, quantidade);
    } on Erro catch (e) {
      mostrarDialogoDeInformacao(e.sms);
    }
  }

  void verEntradas(Produto produto) {
    PainelGerenteC c = Get.find();
    c.irParaPainel(PainelActual.ENTRADAS, valor: produto);
  }

  void verSaidas(Produto produto) {
    PainelGerenteC c = Get.find();
    c.irParaPainel(PainelActual.SAIDAS, valor: produto);
  }

  void gerarRelatorio() async {
    List<List<String>> listaItens = [];
    var hoje = DateTime.now();
    for (var cada in lista) {
      var s = await _manipularStockI.pegarStockDoProdutoDeId(cada.id ?? -1);
      listaItens.add([
        (cada.nome ?? "SEM REGISTO"),
        formatarInteiroComMilhares(s?.quantidade ?? 0).toString(),
        formatar(cada.precoCompra ?? 0),
        formatar((s?.quantidade ?? 0) * (cada.precoCompra ?? 0)),
      ]);
    }
    gerarPDF(listaItens, hoje, totalInvestido.value);
  }

  void gerarPDF(List<List<String>> dados, DateTime data, double total) async {
    try {
      var pdfFile = await GeralPdf.generate(
          "RELATÓRIO DE INVESTIMENTO",
          [
            "Produto",
            "Quantidade",
            "Preço(Compra)",
            "Investimento",
          ],
          dados,
          data,
          informacaoExtra: "Total: ${formatar(total)}");
      voltar();
      PdfApi.openFile(pdfFile);
    } catch (e) {
      mostrarDialogoDeInformacao(
          "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
    }
  }
}
