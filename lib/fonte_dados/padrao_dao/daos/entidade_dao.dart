part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaEntidade])
class EntidadeDao extends DatabaseAccessor<BancoDados> with _$EntidadeDaoMixin {
  EntidadeDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<TabelaEntidadeData>> pegarEntidades() async {
    var lista = await (select(tabelaEntidade)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.nome, mode: OrderingMode.asc)
          ]))
        .get();
    return lista;
  }

  Future<TabelaEntidadeData?> pegarEntidadeDeId(int id) async {
    var res = await (select(tabelaEntidade)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.nome, mode: OrderingMode.asc)
          ])
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<TabelaEntidadeData?> existeEntidadeDeNome(
      String nome, String numero) async {
    var res = await (select(tabelaEntidade)
          ..where((tbl) => tbl.nome.equals(nome)))
        .getSingleOrNull();
    return res;
  }

  Future<int> adicionarEntidade(Entidade entidade) async {
    return await (into(tabelaEntidade).insert(entidade.toCompanion(true)));
  }

  Future<bool> actualizarCliente(Entidade entidade) async {
    return await (update(tabelaEntidade).replace(entidade.toCompanion(true)));
  }

  Future<int> removerEntidadeDeId(int id) async {
    var res = (delete(tabelaEntidade)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }
}
