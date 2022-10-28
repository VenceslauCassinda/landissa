import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_funcionario_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_item_venda_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_pagamento_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_venda_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipula_stock.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_cliente.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_fincionario.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_item_venda.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_pagamento.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_preco.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_produto.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_venda.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/item_venda.dart';
import 'package:yetu_gestor/dominio/entidades/pagamento.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_cliente.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_item_venda.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_pagamento.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_preco.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_stock.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_venda.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';

import '../configuracao/test_config.dart';

void main() {
  TestConfig.prepareInitDataBase();
  Get.put(BancoDados());

  ManipularProdutoI manipularProdutoI = ManipularProduto(ProvedorProduto(),
      ManipularStock(ProvedorStock()), ManipularPreco(ProvedorPreco()));
  var manipularUsuario = ManipularUsuario(ProvedorUsuario());

  ManipularFuncionarioI manipularFuncionarioI =
      ManipularFuncionario(manipularUsuario, ProveedorFuncionario());

  var manipularCliente = ManipularCliente(ProvedorCliente());
  ManipularVendaI manipularVendaI = ManipularVenda(
      ProvedorVenda(),
      ManipularSaida(ProvedorSaida(), ManipularStock(ProvedorStock())),
      ManipularPagamento(ProvedorPagamento()),
      manipularCliente,
      ManipularStock(ProvedorStock()),
      ManipularItemVenda(
          ProvedorItemVenda(),
          ManipularProduto(ProvedorProduto(), ManipularStock(ProvedorStock()),
              ManipularPreco(ProvedorPreco())),
          ManipularStock(ProvedorStock())));

  ManipularItemVendaI manipularItemVendaI = ManipularItemVenda(
      ProvedorItemVenda(), manipularProdutoI, ManipularStock(ProvedorStock()));

  ManipularPagamentoI manipularPagamentoI =
      ManipularPagamento(ProvedorPagamento());

  test("LISTAR VENDAS", () async {
    // var vendas = await ProvedorVenda().pegarLista();
    // for (var cada in vendas) {
    //   print(cada.toString());
    // }
  });

  test("VENDER", () async {
    var produtos = await manipularProdutoI.pegarLista();
    if (produtos.isEmpty) {
      print("NENHUM PRODUCTO CADASTRADO!");
      return;
    }

    var funcionarios = await manipularFuncionarioI.pegarLista();

    if (funcionarios.isEmpty) {
      print("NENHUM FUNCIOANRIO CADASTRADO!");
      return;
    }

    var produto = produtos.first;
    var listaItens = [
      ItemVenda(
          produto: produto,
          estado: Estado.ATIVADO,
          idProduto: produto.id,
          quantidade: 10,
          desconto: 0)
    ];
    var formasPagamento = await manipularPagamentoI.pegarListaFormasPagamento();
    if (formasPagamento.isEmpty) {
      print("NENHUMA FORMA DE PAGAMENTO ADICIONADA!");
      return;
    }

    var listaPagamentos = [
      Pagamento(
          idFormaPagamento: formasPagamento.first.id,
          estado: Estado.ATIVADO,
          valor: 100)
    ];

    listaItens = await manipularItemVendaI.calcularTotalPorItem(listaItens);

    try {
      // await manipularVendaI.vender(
      //     listaItens,
      //     listaPagamentos,
      //     manipularVendaI.calcularTotalVenda(listaItens),
      //     funcionarios.first,
      //     Cliente(estado: Estado.ATIVADO, nome: "Vences", numero: "926886839"),
      //     DateTime(2022, 04, 01),
      //     DateTime(2022, 04, 01),
      //     10);
    } catch (e) {
      expect(e, isA<ErroStockInsuficiente>());
      print((e as Erro).sms);
    }
  });

  test("MOSTRAR PREÇO", () {
    print(formatar(200));
  });
}
