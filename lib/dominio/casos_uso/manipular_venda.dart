import 'package:yetu_gestor/contratos/casos_uso/manipular_cliente_I.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_item_venda_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_pagamento_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_stock_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_entrada.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/pagamento.dart';

import 'package:yetu_gestor/dominio/entidades/item_venda.dart';

import 'package:yetu_gestor/dominio/entidades/funcionario.dart';

import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/dominio/entidades/venda.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_entrada.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';

import '../../contratos/casos_uso/manipular_venda_i.dart';
import '../../contratos/provedores/provedor_venda_i.dart';

class ManipularVenda implements ManipularVendaI {
  final ProvedorVendaI _provedorVendaI;
  final ManipularSaidaI _manipularSaidaI;
  final ManipularPagamentoI _manipularPagamentoI;
  final ManipularClienteI _manipularClienteI;
  final ManipularStockI _manipularStockI;
  final ManipularItemVendaI _manipularItemVendaI;

  ManipularVenda(
      this._provedorVendaI,
      this._manipularSaidaI,
      this._manipularPagamentoI,
      this._manipularClienteI,
      this._manipularStockI,
      this._manipularItemVendaI);
  @override
  Future<int> registarVenda(
      double total,
      double parcela,
      Funcionario funcionario,
      Cliente cliente,
      DateTime data,
      DateTime dataLevantamentoCompra,
      int idProduto,
      int quantidadeVendida) async {
    var idCliente = await _manipularClienteI.registarCliente(cliente);

    var novaVenda = Venda(
        estado: Estado.ATIVADO,
        idFuncionario: funcionario.id,
        dataLevantamentoCompra: dataLevantamentoCompra,
        idCliente: idCliente,
        data: data,
        total: total,
        parcela: parcela,
        quantidadeVendida: quantidadeVendida,
        idProduto: idProduto);
    var idVenda = await _provedorVendaI.adicionarVenda(novaVenda);
    return idVenda;
  }

  @override
  double calcularTotalVenda(List<ItemVenda> itensVenda) {
    var total = 0.0;
    for (var cada in itensVenda) {
      total += cada.total!;
    }
    return total;
  }

  @override
  double aplicarDescontoVenda(double totalApagar, int porcentagem) {
    if (porcentagem >= 0 && porcentagem <= 100) {
      totalApagar = totalApagar - ((porcentagem / 100) * 100);
    } else {
      throw ErroPercentagemInvalida("PERCENTAGEM INCORRECTA!");
    }
    return totalApagar;
  }

  @override
  double calcularParcelaApagar(double totalApagar, double parcelaJaPaga) {
    var total = totalApagar - parcelaJaPaga;
    return total;
  }

  @override
  Future<List<Venda>> pegarLista(
      Funcionario? funcionario, DateTime data) async {
    return await _provedorVendaI.pegarLista(funcionario, data);
  }

  @override
  Future<int> vender(
      List<ItemVenda> itensVenda,
      List<Pagamento> pagamentos,
      double total,
      Funcionario funcionario,
      Cliente cliente,
      DateTime data,
      DateTime dataLevantamentoCompra,
      double parcela,
      int idProduto,
      int quantidadeVendida) async {
    var teste = await pegarItemComStockInsuficiente(itensVenda);
    if (teste != null) {
      throw ErroStockInsuficiente(
          "PRODUTO ${teste.produto?.nome} COM QUANTIDADE INSUFICIENTE!");
    }
    if (parcela > total) {
      throw ErroPagamentoInvalido(
          "PAGAMENTOS INCORRECTOS!\nRETIFIQUE O VALOR DOS PAGAMENTOS!");
    }

    int idVenda = await registarVenda(total, parcela, funcionario, cliente,
        data, dataLevantamentoCompra, idProduto, quantidadeVendida);
    var vendaFeita = await _provedorVendaI.pegarVendaDeId(idVenda);
    if (vendaFeita != null) {
      await _manipularPagamentoI.registarListaPagamentos(pagamentos, idVenda);
      await _manipularSaidaI.registarListaSaidas(
          itensVenda, idVenda, vendaFeita.data!);
      for (var cada in itensVenda) {
        cada.idVenda = idVenda;
        await _manipularItemVendaI.registarItemVenda(cada);
      }
    } else {
      throw ErroVendaInvalida("VENDA INVÁLIDA!");
    }
    return idVenda;
  }

  @override
  List<Pagamento> associarPagamentosAvenda(
      List<Pagamento> pagamentos, int idVenda) {
    for (var i = 0; i < pagamentos.length; i++) {
      pagamentos[i].idVenda = idVenda;
    }
    return pagamentos;
  }

  @override
  double calcularParcelaPaga(List<Pagamento> pagamentos) {
    var total = 0.0;
    for (var cada in pagamentos) {
      total += cada.valor!;
    }
    return total;
  }

  @override
  bool vendaEstaPaga(Venda venda) {
    return venda.total! == venda.parcela;
  }

  @override
  bool vendaOuEncomenda(Venda venda) {
    var dataVenda =
        DateTime(venda.data!.year, venda.data!.month, venda.data!.day);
    var dataLevantamento = DateTime(venda.dataLevantamentoCompra!.year,
        venda.dataLevantamentoCompra!.month, venda.dataLevantamentoCompra!.day);
    return dataVenda == dataLevantamento;
  }

  @override
  Future<ItemVenda?> pegarItemComStockInsuficiente(
      List<ItemVenda> lista) async {
    ItemVenda? item;
    for (var cada in lista) {
      var stock =
          await _manipularStockI.pegarStockDoProdutoDeId(cada.produto!.id!);
      // if (cada.quantidade! > stock.quantidade!) {
      //   item = cada;
      //   break;
      // }
    }
    return item;
  }

  @override
  bool vendaOuDivida(Venda venda) {
    return venda.pagamentos!.isNotEmpty;
  }

  @override
  Future<List<Venda>> pegarListaDividas(
      Funcionario? funcionario, DateTime data) async {
    var lista = <Venda>[];
    var originais = await pegarLista(funcionario, data);
    for (var cada in originais) {
      if (cada.divida == true) {
        lista.add(cada);
      }
    }
    return lista;
  }

  @override
  Future<List<Venda>> pegarListaEncomendas(
      Funcionario? funcionario, DateTime data) async {
    var lista = <Venda>[];
    var originais = await pegarLista(funcionario, data);
    for (var cada in originais) {
      if (cada.encomenda == true) {
        lista.add(cada);
      }
    }
    return lista;
  }

  @override
  Future<List<Venda>> pegarListaVendas(
      Funcionario? funcionario, DateTime data) async {
    var lista = <Venda>[];
    var originais = await pegarLista(funcionario, data);
    for (var cada in originais) {
      if (cada.venda == true) {
        lista.add(cada);
      }
    }
    return lista;
  }

  @override
  Future<void> entregarEncomenda(Venda venda) async {
    venda.dataLevantamentoCompra = venda.data;
    await _provedorVendaI.actualizarVenda(venda);
  }

  @override
  Future<bool> actualizarVenda(Venda venda, bool fazerOuDesfazer) async {
    await _provedorVendaI.actualizarVenda(venda);
    var saida =
        await _manipularSaidaI.pegarSaidaDeProdutoDeId(venda.idProduto ?? -1);
    if (saida == null) {
      await _manipularSaidaI.registarSaida(Saida(
          estado: Estado.ATIVADO,
          idProduto: venda.idProduto,
          quantidade: fazerOuDesfazer == true
              ? venda.quantidade
              : -(venda.quantidade ?? 0),
          motivo: Saida.MOTIVO_VENDA,
          data: venda.data));
      return true;
    } else {
      saida.data = DateTime.now();
      if (fazerOuDesfazer == true) {
        await _manipularStockI.diminuirQuantidadeStock(
            venda.idProduto!, (venda.quantidade ?? 0));
        saida.quantidade = (saida.quantidade ?? 0) + (venda.quantidade ?? 0);
      } else {
        await _manipularStockI.aumentarQuantidadeStock(
            venda.idProduto!, (venda.quantidade ?? 0));
        saida.quantidade = (saida.quantidade ?? 0) - (venda.quantidade ?? 0);
      }
      await _manipularSaidaI.actualizarSaida(saida);
    }
    return false;
  }

  @override
  Future<List<DateTime>> pegarListaDataVendasFuncionario(
      Funcionario funcionario) async {
    return (await _provedorVendaI.pegarListaVendasFuncionario(funcionario))
        .map((e) => e.data!)
        .toList();
  }

  @override
  Future<List<Venda>> pegarListaTodasDividas(Funcionario? funcionario) async {
    return await _provedorVendaI.pegarListaTodasDividas(funcionario!);
  }

  @override
  Future<List<Venda>> pegarListaTodasEncomendas(
      Funcionario? funcionario) async {
    return await _provedorVendaI.pegarListaTodasEncomendas(funcionario!);
  }

  @override
  Future<List<Pagamento>> pegarListaTodasPagamentoDividas(DateTime data) async {
    return await _provedorVendaI.pegarListaTodasPagamentoDividas(data);
  }

  @override
  Future<List<Venda>> todasDividas() async {
    return await _provedorVendaI.todasDividas();
  }

  @override
  Future<bool> removerVenda(Venda venda) async {
    var itens = venda.itensVenda ?? [];
    var pagamentos = venda.pagamentos ?? [];
    for (var item in itens) {
      await _manipularItemVendaI.removerItemVenda(item);
    }
    for (var pagamento in pagamentos) {
      await _manipularPagamentoI.registarPagamento(pagamento);
    }
    await _provedorVendaI.removerVendaDeId(venda.id!);
    return false;
  }

  @override
  Future<bool> removerVendasAntesData(DateTime data) async {
    for (var venda in (await _provedorVendaI.todas())) {
      if (venda.data!.isBefore(data)) {
        var itens = venda.itensVenda ?? [];
        var pagamentos = venda.pagamentos ?? [];
        for (var item in itens) {
          await _manipularItemVendaI.removerItemVenda(item);
        }
        for (var pagamento in pagamentos) {
          await _manipularPagamentoI.registarPagamento(pagamento);
        }
        await _provedorVendaI.removerVendaDeId(venda.id!);
      }
    }
    return false;
  }

  @override
  Future<bool> removerTodasVendas() async {
    await _provedorVendaI.removerTodas();
    return false;
  }

  @override
  Future<List<DateTime>> pegarListaDataVendas() async {
    return (await _provedorVendaI.pegarListaVendas())
        .map((e) => e.data!)
        .toList();
  }

  @override
  Future<List<Pagamento>> pegarListaTodasPagamentoDividasFuncionario(
      Funcionario funcionario, DateTime data) async {
    return await _provedorVendaI.pegarListaTodasPagamentoDividasFuncionario(
        funcionario, data);
  }

  @override
  Future<List<Venda>> pegarListaTodasVendas() async {
    return await _provedorVendaI.pegarListaTodasVendas();
  }
}
