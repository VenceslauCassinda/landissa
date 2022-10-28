import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipula_stock.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_preco.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_produto.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_preco.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_stock.dart';

import '../configuracao/test_config.dart';

void main() {
  TestConfig.prepareInitDataBase();
  Get.put(BancoDados());
  ManipularSaidaI manipularSaidaI =
      ManipularSaida(ProvedorSaida(), ManipularStock(ProvedorStock()));
  ManipularProdutoI manipularProdutoI = ManipularProduto(ProvedorProduto(),
      ManipularStock(ProvedorStock()), ManipularPreco(ProvedorPreco()));
  test("REGISTAR SAIDA", () async {
    var produtos = await manipularProdutoI.pegarLista();
    if (produtos.isEmpty) {
      return;
    }
    var produto = produtos.first;
    var qtdAntiga = produto.stock!.quantidade!;
    await manipularSaidaI.registarSaida(Saida(
        idVenda: 1,
        quantidade: 100,
        motivo: Saida.MOTIVO_DESPERDICIO,
        estado: Estado.ATIVADO,
        data: DateTime.now(),
        idProduto: produto.id));
    produtos = await manipularProdutoI.pegarLista();
    produto = produtos.first;
    expect(qtdAntiga - 100, produto.stock!.quantidade!);
  });
}
