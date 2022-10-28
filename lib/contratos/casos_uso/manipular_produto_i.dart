import 'package:yetu_gestor/dominio/entidades/preco.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';

import '../../dominio/entidades/stock.dart';

abstract class ManipularProdutoI {
  Future<List<Produto>> pegarLista();
  Future<int> adicionarProduto(Produto dado);
  Future<int> adicionarPrecoProduto(Produto dado, double preco, int quantidade);
  Future<bool> atualizarPrecoProduto(
      Produto dado, double preco, int quantidade);
  Future<void> removerProduto(Produto dado);
  Future<void> activarProduto(Produto dado);
  Future<void> desactivarrProduto(Produto dado);
  Future<void> recuperarProduto(Produto dado);
  Future<Produto?> pegarProdutoDeId(int id);
  Future<List<Preco>> pegarPrecoProdutoDeId(int id);
  Future<void> removerPrecoProduto(Produto dado, double preco, int quantidade);
  Future<bool> existeProdutoComNome(String nome);
  Future<bool> existeProdutoComPreco(Produto dado, double preco);
  Future<void> actualizarProduto(Produto dado);
  Future<bool> existeProdutoDiferenteDeNome(int id, String nomeProduto);
  Future<Stock?> pegarStockDoProdutoDeId(int id);
}
