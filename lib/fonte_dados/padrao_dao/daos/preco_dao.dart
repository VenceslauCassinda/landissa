part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaPreco, TabelaProduto])
class PrecoDao extends DatabaseAccessor<BancoDados> with _$PrecoDaoMixin {
  PrecoDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<int> adicionarPrecoDeProduto(Preco preco) async {
    var res = await into(tabelaPreco).insert(preco.toCompanion(true));

    return res;
  }

  Future<bool> atualizarPrecoProduto(Preco preco) async {
    var res = update(tabelaPreco);
    return await res.replace(preco.toCompanion(true));
  }

  Future<int> removerPrecoDoProduto(double preco, int idProduto) async {
    var res = await (delete(tabelaPreco)
          ..where((tbl) =>
              tbl.idProduto.equals(idProduto) & tbl.preco.equals(preco)))
        .go();
    return res;
  }

  Future<TabelaPrecoData?> existeProdutoComPreco(
      int idProduto, double preco) async {
    var res = await (select(tabelaPreco)
          ..where((tbl) =>
              tbl.preco.equals(preco) & tbl.idProduto.equals(idProduto)))
        .getSingleOrNull();
    return res;
  }

  Future<List<Preco>> pegarPrecoDeIdDeProduto(int id) async {
    var res = await (select(tabelaPreco)
          ..where((tbl) => tbl.idProduto.equals(id)))
        .get();
    return res.map(((e) {
      return Preco(
          estado: e.estado,
          quantidade: e.quantidade,
          idProduto: e.idProduto,
          preco: e.preco);
    })).toList();
  }
}
