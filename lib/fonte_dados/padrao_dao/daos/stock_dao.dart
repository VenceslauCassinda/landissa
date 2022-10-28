part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaStock])
class StockDao extends DatabaseAccessor<BancoDados> with _$StockDaoMixin {
  StockDao(BancoDados attachedDatabase) : super(attachedDatabase);
  Future<int> inicializarStockProduto(int idProduto) async {
    var res = await into(tabelaStock).insert(TabelaStockCompanion.insert(
        estado: Estado.ATIVADO, idProduto: idProduto, quantidade: 0));
    return res;
  }

  Future<void> alterarQuantidadeStock(int idProduto, int quantidade) async {
    var res = update(tabelaStock)
      ..where((tbl) => tbl.idProduto.equals(idProduto));
    await res.write(TabelaStockCompanion(quantidade: Value(quantidade)));
  }

  Future<TabelaStockData?> pegarStockDeId(int id) async {
    var res = (select(tabelaStock)..where((tbl) => tbl.id.equals(id)));
    return (await res.getSingleOrNull());
  }

  Future<TabelaStockData?> pegarStockDoProdutoDeId(int id) async {
    var res = (select(tabelaStock)..where((tbl) => tbl.idProduto.equals(id)));
    return (await res.getSingleOrNull());
  }

  Future<int> removerStockDeId(int id) async {
    var res = (delete(tabelaStock)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }

  Future<int> removerStockProdutoDeId(int id) async {
    var res =
        (delete(tabelaStock)..where((tbl) => tbl.idProduto.equals(id))).go();
    return res;
  }
}
