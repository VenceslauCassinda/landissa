import '../../dominio/entidades/stock.dart';

abstract class ProvedorStockI {
  Future<int> inicializarStockProduto(int idProduto);
  Future<void> alterarQuantidadeStock(int idProduto, int quantidade);
  Future<Stock?> pegarStockDeId(int id);
  Future<Stock?> pegarStockDoProdutoDeId(int id);
  Future<void> removerStock(int id);
  Future<void> removerProdutoStock(int id);
}
