import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_receccao_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipula_stock.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_entrada.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_fincionario.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_preco.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_produto.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_receccao.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_entrada.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_preco.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_produto.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_receccao.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_stock.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';

import '../configuracao/test_config.dart';

void main() {
  TestConfig.prepareInitDataBase();
  Get.put(BancoDados());
  var maniStock = ManipularStock(ProvedorStock());
  ManipularProdutoI manipularProdutoI = ManipularProduto(
      ProvedorProduto(), maniStock, ManipularPreco(ProvedorPreco()));
  ManipularRececcaoI manipularRececcaoI = ManipularRececcao(
      ProvedorRececcao(),
      ManipularEntrada(
        ProvedorEntrada(),
        ManipularStock(ProvedorStock()),
      ),
      manipularProdutoI);
  ManipularFuncionario manipularFuncionario = ManipularFuncionario(
      ManipularUsuario(ProvedorUsuario()), ProveedorFuncionario());

  test("LISTAR PRODUTOS", () async {
    var funacionarios = await manipularProdutoI.pegarLista();
    funacionarios.forEach((element) {
      print(element.toString());
    });
  });
  test("RECBER PRODUTO", () async {
    var funacionarios = await manipularFuncionario.pegarLista();
    if (funacionarios.isEmpty) {
      print("NENHUM FUNCIONARIO!");
      return;
    }
    var produtos = await manipularProdutoI.pegarLista();
    if (produtos.isEmpty) {
      print("NENHUM PRODUTO");
      return;
    }

    var produto = produtos.first;
    int qtd = produto.stock!.quantidade!;

    var funcionario = funacionarios.first;
    // await manipularRececcaoI.receberProduto(produto, 100, funcionario, Entrada.MOTIVO_ABASTECIMENTO);

    produtos = await manipularProdutoI.pegarLista();
    produto = produtos.first;
    expect(produto.stock!.quantidade!, qtd + 100);
  });
}
