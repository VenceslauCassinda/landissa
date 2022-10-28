import 'package:yetu_gestor/dominio/entidades/stock.dart';

import '../../contratos/casos_uso/manipular_stock_i.dart';
import '../../contratos/provedores/provedor_stock_i.dart';

class ManipularStock implements ManipularStockI {
  late ProvedorStockI _provedorStockI;
  ManipularStock(this._provedorStockI) {}
  @override
  Future<int> inicializarStockProduto(int idProduto) async {
    return await _provedorStockI.inicializarStockProduto(idProduto);
  }

  @override
  Future<void> aumentarQuantidadeStock(int idProduto, int quantidade) async {
    var stock = await pegarStockDoProdutoDeId(idProduto);
    if (stock != null) {
      var novaQuantidade = stock.quantidade! + quantidade;
      await _provedorStockI.alterarQuantidadeStock(idProduto, novaQuantidade);
    }
  }

  @override
  Future<Stock?> pegarStockDeId(int id) async {
    return await _provedorStockI.pegarStockDeId(id);
  }

  @override
  Future<void> diminuirQuantidadeStock(int idProduto, int quantidade) async {
    var stock = await pegarStockDoProdutoDeId(idProduto);
    if (stock != null) {
      var novaQuantidade = stock.quantidade! - quantidade;
      await _provedorStockI.alterarQuantidadeStock(idProduto, novaQuantidade);
    }
  }

  @override
  Future<Stock?> pegarStockDoProdutoDeId(int id) async {
    return await _provedorStockI.pegarStockDoProdutoDeId(id);
  }

  @override
  Future<void> removerStock(int id) async {
    await _provedorStockI.removerStock(id);
  }

  @override
  Future<void> removerProdutoStock(int id) async {
    await _provedorStockI.removerProdutoStock(id);
  }
}
