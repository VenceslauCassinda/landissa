part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaProduto, TabelaStock, TabelaPreco])
class ProdutoDao extends DatabaseAccessor<BancoDados> with _$ProdutoDaoMixin {
  ProdutoDao(BancoDados bancoDados) : super(bancoDados);

  Future<List<Produto>> todos() async {
    var res = await (select(tabelaProduto)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.nome, mode: OrderingMode.asc)
          ]))
        .get();
    var lista = res.map((produto) {
      return Produto(
        id: produto.id,
        estado: produto.estado,
        nome: produto.nome,
        precoCompra: produto.precoCompra,
        recebivel: produto.recebivel,
      );
    }).toList();
    return lista;
  }

  Future<TabelaProdutoData?> existeProdutoDeNome(String nomeProduto) async {
    var res = (await (select(tabelaProduto)
          ..where((tbl) => tbl.nome.equals(nomeProduto)))
        .getSingleOrNull());
    return res;
  }

  Future<TabelaProdutoData?> existeProdutoDiferenteDeNome(
      int id, String nomeProduto) async {
    var res = (await (select(tabelaProduto)
          ..where((tbl) =>
              (tbl.id.equals(id)).not() & tbl.nome.equals(nomeProduto)))
        .getSingleOrNull());
    return res;
  }

  Future<int> adicionarProduto(Produto tabela) async {
    var res = await into(tabelaProduto).insert(tabela.toCompanion(true));
    return res;
  }

  Future<void> actualizarProduto(TabelaProdutoCompanion tabela) async {
    await update(tabelaProduto).replace(tabela);
  }

  Future<void> removerProduto(int id) async {
    await (delete(tabelaProduto)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<TabelaProdutoData?> pagarProdutoDeId(int id) async {
    return await (select(tabelaProduto)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
}
