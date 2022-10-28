import 'package:yetu_gestor/dominio/entidades/produto.dart';

abstract class ProvedorProdutoI {
  Future<List<Produto>> pegarLista();
  Future<int> adicionarProduto(Produto dado);
  Future<bool> existeProdutoComNome(String nome);
  Future<void> removerProduto(Produto dado);
  Future<void> actualizarProduto(Produto dado);
  Future<Produto?> pegarProdutoDeId(int id);
  Future<bool> existeProdutoDiferenteDeNome(int id, String nomeProduto);
}
