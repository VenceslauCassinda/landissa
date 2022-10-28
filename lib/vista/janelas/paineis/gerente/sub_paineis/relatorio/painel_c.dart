import 'dart:io';

import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_funcionario_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_receccao_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_entrada.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_preco.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_produto.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_receccao.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/relatorio.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_entrada.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_preco.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_receccao.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/solucoes_uteis/pdf_api/caixa_pdf.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/layouts/layout_receber_completo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

import '../../../../../../../contratos/casos_uso/manipular_stock_i.dart';
import '../../../../../../../dominio/casos_uso/manipular_fincionario.dart';
import '../../../../../../../dominio/casos_uso/manipular_usuario.dart';
import '../../../../../../../dominio/entidades/estado.dart';
import '../../../../../../../fonte_dados/provedores/provedor_saida.dart';
import '../../../../../../../fonte_dados/provedores/provedor_stock.dart';
import '../../../../../../../recursos/constantes.dart';
import '../../../../../../contratos/casos_uso/manipular_entidade_i.dart';
import '../../../../../../contratos/casos_uso/manipular_entrada_i.dart';
import '../../../../../../contratos/casos_uso/manipular_item_venda_i.dart';
import '../../../../../../contratos/casos_uso/manipular_saida_caixa_i.dart';
import '../../../../../../contratos/casos_uso/manipular_venda_i.dart';
import '../../../../../../dominio/casos_uso/manipula_stock.dart';
import '../../../../../../dominio/casos_uso/manipular_cliente.dart';
import '../../../../../../dominio/casos_uso/manipular_entidade.dart';
import '../../../../../../dominio/casos_uso/manipular_item_venda.dart';
import '../../../../../../dominio/casos_uso/manipular_pagamento.dart';
import '../../../../../../dominio/casos_uso/manipular_saida_caixa.dart';
import '../../../../../../dominio/casos_uso/manipular_venda.dart';
import '../../../../../../dominio/entidades/caixa.dart';
import '../../../../../../dominio/entidades/customer.dart';
import '../../../../../../dominio/entidades/invoice.dart';
import '../../../../../../dominio/entidades/pdf_page.dart';
import '../../../../../../dominio/entidades/supplier.dart';
import '../../../../../../fonte_dados/provedores/provedor_cliente.dart';
import '../../../../../../fonte_dados/provedores/provedor_entidade.dart';
import '../../../../../../fonte_dados/provedores/provedor_item_venda.dart';
import '../../../../../../fonte_dados/provedores/provedor_pagamento.dart';
import '../../../../../../fonte_dados/provedores/provedor_saida_caixa.dart';
import '../../../../../../fonte_dados/provedores/provedor_venda.dart';
import '../../../../../../solucoes_uteis/pdf_api/investimento_pdf.dart';
import '../../../../../../solucoes_uteis/pdf_api/pdf_api.dart';
import '../../../../../../solucoes_uteis/pdf_api/entradas_pdf.dart';
import '../../../../../../solucoes_uteis/pdf_api/vendas_pdf.dart';
import '../../../../../aplicacao_c.dart';
import '../../layouts/layout_produto.dart';
import '../../layouts/layout_quantidade.dart';

class PainelRelatorioC extends GetxController {
  var lista = RxList<Produto>();
  late ManipularProdutoI _manipularProdutoI;
  late ManipularStockI _manipularStockI;
  late ManipularRececcaoI _manipularRececcaoI;
  late ManipularFuncionarioI _manipularFuncionarioI;
  late ManipularSaidaI _manipularSaidaI;
  late ManipularEntradaI _manipularEntradaI;
  late ManipularVendaI _manipularVendaI;
  late ManipularItemVendaI _manipularItemVendaI;
  late ManipularSaidaCaixaI _manipularSaidaCaixaI;
  late ManipularEntidadeI _manipularEntidadeI;
  var indiceTabActual = 1.obs;

  var totalInvestido = 0.0.obs;
  PainelRelatorioC() {
    _manipularEntidadeI = ManipularEntidade(ProvedorEntidade());
    _manipularEntradaI =
        ManipularEntrada(ProvedorEntrada(), ManipularStock(ProvedorStock()));
    _manipularStockI = ManipularStock(ProvedorStock());
    _manipularProdutoI = ManipularProduto(
        ProvedorProduto(), _manipularStockI, ManipularPreco(ProvedorPreco()));
    _manipularRececcaoI = ManipularRececcao(ProvedorRececcao(),
        ManipularEntrada(ProvedorEntrada(), _manipularStockI), _manipularProdutoI);
    _manipularFuncionarioI = ManipularFuncionario(
        ManipularUsuario(ProvedorUsuario()), ProveedorFuncionario());
    _manipularSaidaI = ManipularSaida(ProvedorSaida(), _manipularStockI);
    _manipularItemVendaI = ManipularItemVenda(
        ProvedorItemVenda(),
        ManipularProduto(ProvedorProduto(), _manipularStockI,
            ManipularPreco(ProvedorPreco())),
        ManipularStock(ProvedorStock()));
    _manipularVendaI = ManipularVenda(
        ProvedorVenda(),
        ManipularSaida(ProvedorSaida(), _manipularStockI),
        ManipularPagamento(ProvedorPagamento()),
        ManipularCliente(ProvedorCliente()),
        _manipularStockI,
        _manipularItemVendaI);
    _manipularSaidaCaixaI = ManipularSaidaCaixa(ProvedorSaidaCaixa());
  }
  @override
  void onInit() async {
    await pegarActivos();
    super.onInit();
  }

  Future<void> pegarTodos() async {
    lista.clear();
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      lista.add(cada);
    }
  }

  Future<void> pegarActivos() async {
    lista.clear();
    totalInvestido.value = 0;
    var res = await _manipularProdutoI.pegarLista();
    for (var cada in res) {
      if (cada.estado == Estado.ATIVADO) {
        lista.add(cada);
        totalInvestido.value +=
            (cada.stock?.quantidade ?? 0) * (cada.precoCompra ?? 0);
      }
    }
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
      accaoAoFinalizar: (nome, precoCompra) async {
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

  void mostrarDialogoGerarRelatorioEntrada(BuildContext context) async {
    var entidades = await _manipularEntidadeI.todos();
    if (entidades.isEmpty) {
      mostrarDialogoDeInformacao("Por favor! Insira os dados da Entidade!");
      return;
    }
    List<List<String>> listaItens = [];
    mostrarDialogoDeLayou(Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .6,
        child: PdfPage(
          nomeRelatorio: "Entradas",
          accaoAoCriarPdf: () async {
            final hoje = DateTime.now();
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

            var todos = await _manipularEntradaI.pegarLista();
            for (var cada in todos) {
              var depoisDoInicio = ((DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  )).isAfter(DateTime(
                    dataInicio.year,
                    dataInicio.month,
                    dataInicio.day,
                  )) ||
                  DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  ).isAtSameMomentAs(DateTime(
                    dataInicio.year,
                    dataInicio.month,
                    dataInicio.day,
                  )));
              var antesDoFim = ((DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  )).isBefore(DateTime(
                    dataFim.year,
                    dataFim.month,
                    dataFim.day,
                  )) ||
                  DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  ).isAtSameMomentAs(DateTime(
                    dataFim.year,
                    dataFim.month,
                    dataFim.day,
                  )));
              if (depoisDoInicio == true && antesDoFim == true) {
                listaItens.add([
                  (cada.data == null
                      ? "INDIESPONÍVEL"
                      : formatarData(cada.data!)),
                  "${cada.quantidade ?? 0}",
                  (cada.produto?.nome ?? "NÃO CONSIDERADO"),
                  (cada.motivo ?? "SEM MOTIVO"),
                ]);
              }
            }

            var realtorio = Relatorio(
                nomeRelatorio: "Relatório de Entradas",
                listaItens: listaItens,
                caixa: Caixa(
                    caixaDigital: "caixaDigital",
                    caixaFisico: "caixaFisico",
                    caixaFisicoAcomulado: "caixaFisicoAcomulado",
                    caixaDigitalAcomulado: "caixaDigitalAcomulado",
                    totalDespesas: "totalDespesas"),
                data: hoje,
                nomeEmpresa: entidades[0].nome!,
                enderecoEmpresa: entidades[0].endereco!,
                nifEmpresa: entidades[0].nif!);

            try {
              var pdfFile = await EntradasPdf.generate(
                  realtorio.toInvoice(hoje),
                  cabecalho: [
                    "Data de Entrada",
                    "Quantidade",
                    "Produto",
                    "Motivo"
                  ]);
              voltar();
              PdfApi.openFile(pdfFile);
            } catch (e) {
              mostrarDialogoDeInformacao(
                  "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
            }
          },
        )));
  }

  void mostrarDialogoGerarRelatorioSaidas(BuildContext context) async {
    List<List<String>> listaItens = [];
    var entidades = await _manipularEntidadeI.todos();
    if (entidades.isEmpty) {
      mostrarDialogoDeInformacao("Por favor! Insira os dados da Entidade");
      return;
    }
    mostrarDialogoDeLayou(Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .6,
        child: PdfPage(
          nomeRelatorio: "Saídas",
          accaoAoCriarPdf: () async {
            final hoje = DateTime.now();
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

            var todos = await _manipularSaidaI.pegarLista();
            for (var cada in todos) {
              var depoisDoInicio = ((DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  )).isAfter(DateTime(
                    dataInicio.year,
                    dataInicio.month,
                    dataInicio.day,
                  )) ||
                  DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  ).isAtSameMomentAs(DateTime(
                    dataInicio.year,
                    dataInicio.month,
                    dataInicio.day,
                  )));
              var antesDoFim = ((DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  )).isBefore(DateTime(
                    dataFim.year,
                    dataFim.month,
                    dataFim.day,
                  )) ||
                  DateTime(
                    cada.data!.year,
                    cada.data!.month,
                    cada.data!.day,
                  ).isAtSameMomentAs(DateTime(
                    dataFim.year,
                    dataFim.month,
                    dataFim.day,
                  )));
              if (depoisDoInicio == true && antesDoFim == true) {
                listaItens.add([
                  (cada.data == null
                      ? "INDIESPONÍVEL"
                      : formatarData(cada.data!)),
                  "${cada.quantidade ?? 0}",
                  (cada.produto?.nome ?? "NÃO CONSIDERADO"),
                  (cada.motivo ?? "SEM MOTIVO"),
                ]);
              }
            }

            var realtorio = Relatorio(
                nomeRelatorio: "Relatório de Saídas",
                listaItens: listaItens,
                caixa: Caixa(
                    caixaDigital: "caixaDigital",
                    caixaFisico: "caixaFisico",
                    caixaFisicoAcomulado: "caixaFisicoAcomulado",
                    caixaDigitalAcomulado: "caixaDigitalAcomulado",
                    totalDespesas: "totalDespesas"),
                data: hoje,
                nomeEmpresa: entidades[0].nome!,
                enderecoEmpresa: entidades[0].endereco!,
                nifEmpresa: entidades[0].nif!);

            try {
              var pdfFile = await EntradasPdf.generate(
                  realtorio.toInvoice(hoje),
                  cabecalho: [
                    "Data de Saída",
                    "Quantidade",
                    "Produto",
                    "Motivo"
                  ]);
              voltar();
              PdfApi.openFile(pdfFile);
            } catch (e) {
              mostrarDialogoDeInformacao(
                  "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
            }
          },
        )));
  }

  void mostrarDialogoGerarRelatorioExistencial(BuildContext context) async {
    var entidades = await _manipularEntidadeI.todos();
    if (entidades.isEmpty) {
      mostrarDialogoDeInformacao("Por favor! Insira os dados da Entidade");
      return;
    }
    List<List<String>> listaItens = [];
    mostrarDialogoDeLayou(Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .6,
        child: PdfPage(
          nomeRelatorio: "Existências",
          accaoAoCriarPdf: () async {
            var hoje = DateTime.now();
            var todos = await _manipularProdutoI.pegarLista();
            for (var cada in todos) {
              listaItens.add([
                (cada.nome ?? "NÃO CONSIDERADO"),
                "${cada.stock?.quantidade ?? 0}",
              ]);
            }

            var realtorio = Relatorio(
                nomeRelatorio: "Relatório de Existências",
                listaItens: listaItens,
                caixa: Caixa(
                    caixaDigital: "caixaDigital",
                    caixaFisico: "caixaFisico",
                    caixaFisicoAcomulado: "caixaFisicoAcomulado",
                    caixaDigitalAcomulado: "caixaDigitalAcomulado",
                    totalDespesas: "totalDespesas"),
                data: hoje,
                nomeEmpresa: entidades[0].nome!,
                enderecoEmpresa: entidades[0].endereco!,
                nifEmpresa: entidades[0].nif!);

            try {
              var pdfFile = await EntradasPdf.generate(
                  realtorio.toInvoice(hoje),
                  cabecalho: [
                    "Nome do Produto",
                    "Quantidade Existente",
                  ]);
              voltar();
              PdfApi.openFile(pdfFile);
            } catch (e) {
              mostrarDialogoDeInformacao(
                  "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
            }
          },
        )));
  }

  void mostrarDialogoGerarRelatorioInvestimento(BuildContext context) async {
    var entidades = await _manipularEntidadeI.todos();
    if (entidades.isEmpty) {
      mostrarDialogoDeInformacao("Por favor! Insira os dados da Entidade");
      return;
    }
    List<List<String>> listaItens = [];
    mostrarDialogoDeLayou(Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .6,
        child: PdfPage(
          nomeRelatorio: "Investimento",
          accaoAoCriarPdf: () async {
            double total = 0;
            var hoje = DateTime.now();
            var todos = await _manipularProdutoI.pegarLista();
            for (var cada in todos) {
              listaItens.add([
                (cada.nome ?? "NÃO CONSIDERADO"),
                "${formatar(cada.precoCompra ?? 0)} KZ",
                "${cada.stock?.quantidade ?? 0}",
                "${formatar((cada.precoCompra ?? 0) * (cada.stock?.quantidade ?? 0))} KZ",
              ]);
              total += (cada.precoCompra ?? 0) * (cada.stock?.quantidade ?? 0);
            }

            var realtorio = Relatorio(
                nomeRelatorio: "Relatório de Investimento",
                listaItens: listaItens,
                caixa: Caixa(
                    caixaDigital: "caixaDigital",
                    caixaFisico: "caixaFisico",
                    caixaFisicoAcomulado: "caixaFisicoAcomulado",
                    caixaDigitalAcomulado: "caixaDigitalAcomulado",
                    totalDespesas: "totalDespesas"),
                data: hoje,
                nomeEmpresa: entidades[0].nome!,
                enderecoEmpresa: entidades[0].endereco!,
                nifEmpresa: entidades[0].nif!);

            try {
              var pdfFile = await InvestimentoPdf.generate(
                  realtorio.toInvoice(hoje), total,
                  cabecalho: [
                    "Nome do Produto",
                    "Preço de Compra",
                    "Quantidade",
                    "Investimento",
                  ]);
              voltar();
              PdfApi.openFile(pdfFile);
            } catch (e) {
              mostrarDialogoDeInformacao(
                  "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
            }
          },
        )));
  }

  void mostrarDialogoGerarRelatorioVendas(BuildContext context) async {
    var entidades = await _manipularEntidadeI.todos();
    if (entidades.isEmpty) {
      mostrarDialogoDeInformacao("Por favor! Insira os dados da Entidade");
      return;
    }
    List<List<String>> listaItens = [];
    mostrarDialogoDeLayou(Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .6,
        child: PdfPage(
          nomeRelatorio: "Vendas",
          accaoAoCriarPdf: () async {
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

            var datas = await _manipularVendaI.pegarListaDataVendas();
            for (var cadaData in datas) {
              var todos = await _manipularVendaI.pegarLista(null, cadaData);
              var depoisDoInicio = ((DateTime(
                    cadaData.year,
                    cadaData.month,
                    cadaData.day,
                  )).isAfter(DateTime(
                    dataInicio.year,
                    dataInicio.month,
                    dataInicio.day,
                  )) ||
                  DateTime(
                    cadaData.year,
                    cadaData.month,
                    cadaData.day,
                  ).isAtSameMomentAs(DateTime(
                    dataInicio.year,
                    dataInicio.month,
                    dataInicio.day,
                  )));
              var antesDoFim = ((DateTime(
                    cadaData.year,
                    cadaData.month,
                    cadaData.day,
                  )).isBefore(DateTime(
                    dataFim.year,
                    dataFim.month,
                    dataFim.day,
                  )) ||
                  DateTime(
                    cadaData.year,
                    cadaData.month,
                    cadaData.day,
                  ).isAtSameMomentAs(DateTime(
                    dataFim.year,
                    dataFim.month,
                    dataFim.day,
                  )));
              if (depoisDoInicio == true && antesDoFim == true) {
                double totalVendido = 0.0;
                for (var cada in todos) {
                  var vendido = (cada.pagamentos ?? []).fold<double>(
                      0,
                      (previousValue, element) =>
                          ((element.valor ?? 0) + previousValue));
                  totalVendido += vendido;
                }
                var existe = listaItens.firstWhereOrNull((element) =>
                    element[0] == formatarData(cadaData, semHora: true));
                if (existe == null) {
                  listaItens.add([
                    formatarData(cadaData, semHora: true),
                    "${formatar(totalVendido)} KZ",
                  ]);
                }
              }
            }

            var realtorio = Relatorio(
                nomeRelatorio: "Relatório de Vendas",
                listaItens: listaItens,
                caixa: Caixa(
                    caixaDigital: "caixaDigital",
                    caixaFisico: "caixaFisico",
                    caixaFisicoAcomulado: "caixaFisicoAcomulado",
                    caixaDigitalAcomulado: "caixaDigitalAcomulado",
                    totalDespesas: "totalDespesas"),
                data: hoje,
                nomeEmpresa: entidades[0].nome!,
                enderecoEmpresa: entidades[0].endereco!,
                nifEmpresa: entidades[0].nif!);

            try {
              var pdfFile = await VendasPdf.generate(realtorio.toInvoice(hoje),
                  cabecalho: [
                    "Data",
                    "Total Vendido",
                  ]);
              voltar();
              PdfApi.openFile(pdfFile);
            } catch (e) {
              mostrarDialogoDeInformacao(
                  "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
            }
          },
        )));
  }

  void mostrarDialogoGerarRelatorioCaixa(BuildContext context) async {
    var entidades = await _manipularEntidadeI.todos();
    if (entidades.isEmpty) {
      mostrarDialogoDeInformacao("Por favor! Insira os dados da Entidade");
      return;
    }
    List<List<String>> listaItens = [];
    mostrarDialogoDeLayou(Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width * .6,
        child: PdfPage(
          nomeRelatorio: "Fluxo de Caixa",
          accaoAoCriarPdf: () async {
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

            double totalCashVendido = 0.0;
            double totalCashVendidoAcomulado = 0.0;
            double totalBancoVendido = 0.0;
            double totalBancoVendidoAcomulado = 0.0;
            double totalDespesas = 0.0;
            var cadaData = DateTime(
              dataInicio.year,
              dataInicio.month,
              dataInicio.day,
            );
            while (!DateTime(
              hoje.year,
              hoje.month,
              hoje.day,
            ).isAtSameMomentAs(cadaData)) {
              var todos = await _manipularVendaI.pegarLista(null, cadaData);

              for (var cada in todos) {
                double vendidoBanco = 0.0;
                var vendidoCash = (cada.pagamentos ?? []).fold<double>(0,
                    (previousValue, element) {
                  if (!(element.formaPagamento?.descricao ?? "")
                      .contains("CASH")) {
                    vendidoBanco += (element.valor ?? 0);
                    return 0;
                  }
                  return (element.valor ?? 0) + previousValue;
                });
                if (vendidoBanco > 0) {
                  totalBancoVendido += vendidoBanco;
                  totalBancoVendidoAcomulado += vendidoBanco;
                  listaItens.add([
                    formatarData(cadaData, semHora: true),
                    "${formatar(vendidoBanco)} KZ",
                    "+",
                    "VENDAS",
                    "VALOR BANCÁRIO",
                    "${formatar(totalCashVendido)} KZ",
                    "${formatar(totalBancoVendido)} KZ",
                  ]);
                }
                if (vendidoCash > 0) {
                  totalCashVendido += vendidoCash;
                  totalCashVendidoAcomulado += vendidoCash;
                  listaItens.add([
                    formatarData(cadaData, semHora: true),
                    "${formatar(vendidoCash)} KZ",
                    "+",
                    "VENDAS",
                    "VALOR EM CASH",
                    "${formatar(totalCashVendido)} KZ",
                    "${formatar(totalBancoVendido)} KZ",
                  ]);
                }
              }

              var saidasCaixa = await _manipularSaidaCaixaI.pegarLista();
              saidasCaixa.removeWhere((element) => !DateTime(
                    element.data!.year,
                    element.data!.month,
                    element.data!.day,
                  ).isAtSameMomentAs(cadaData));
              for (var cadaSaida in saidasCaixa) {
                totalCashVendido -= (cadaSaida.valor ?? 0);
                listaItens.add([
                  formatarData(cadaData, semHora: true),
                  "${formatar((cadaSaida.valor ?? 0))} KZ",
                  "-",
                  cadaSaida.motivo ?? "Gerência",
                  "VALOR EM CASH",
                  "${formatar(totalCashVendido)} KZ",
                  "${formatar(totalBancoVendido)} KZ",
                ]);
                totalDespesas += (cadaSaida.valor ?? 0);
              }
              cadaData = cadaData.add(const Duration(days: 1));
            }

            var realtorio = Relatorio(
                nomeRelatorio: "Relatório de Fluxo de Caixa",
                listaItens: listaItens,
                caixa: Caixa(
                    caixaDigital: "caixaDigital",
                    caixaFisico: "caixaFisico",
                    caixaFisicoAcomulado: "caixaFisicoAcomulado",
                    caixaDigitalAcomulado: "caixaDigitalAcomulado",
                    totalDespesas: "totalDespesas"),
                data: hoje,
                nomeEmpresa: entidades[0].nome!,
                enderecoEmpresa: entidades[0].endereco!,
                nifEmpresa: entidades[0].nif!);

            try {
              var pdfFile = await CaixaPdf.generate(realtorio.toInvoice(hoje),
                  totalBanco: totalBancoVendido,
                  totalCash: totalCashVendido,
                  totalBancoAcomulado: totalBancoVendidoAcomulado,
                  totalCashAcomulado: totalCashVendidoAcomulado,
                  totalDespesas: totalDespesas,
                  cabecalho: [
                    "DATA",
                    "VALOR",
                    "+/-",
                    "MOTIVO",
                    "TIPO",
                    "CASH",
                    "CONTA"
                  ]);
              voltar();
              PdfApi.openFile(pdfFile);
            } catch (e) {
              mostrarDialogoDeInformacao(
                  "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
            }
          },
        )));
  }
}
