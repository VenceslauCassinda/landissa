part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaCliente])
class ClienteDao extends DatabaseAccessor<BancoDados> with _$ClienteDaoMixin {
  ClienteDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<TabelaClienteData>> pegarClientes() async {
    var lista = await (select(tabelaCliente)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.nome, mode: OrderingMode.asc)
          ]))
        .get();
    return lista;
  }

  Future<TabelaClienteData?> pegarClienteDeId(int id) async {
    var res = await (select(tabelaCliente)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.nome, mode: OrderingMode.asc)
          ])
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<TabelaClienteData?> existeClienteDeNomeEnumero(
      String nome, String numero) async {
    var res = await (select(tabelaCliente)
          ..where((tbl) => tbl.nome.equals(nome) & tbl.numero.equals(numero)))
        .getSingleOrNull();
    return res;
  }

  Future<int> adicionarCliente(Cliente cliente) async {
    return await (into(tabelaCliente).insert(cliente.toCompanion(true)));
  }

  Future<bool> actualizarCliente(Cliente cliente) async {
    return await (update(tabelaCliente).replace(cliente.toCompanion(true)));
  }

  Future<int> removerClienteDeId(int id) async {
    var res = (delete(tabelaCliente)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }

  Future removerTudo() async {
    await (delete(tabelaCliente)).go();
  }
}
