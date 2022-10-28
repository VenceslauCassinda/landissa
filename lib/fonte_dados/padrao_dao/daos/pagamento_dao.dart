part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaPagamento, TabelaPagamentoFinal])
class PagamentoDao extends DatabaseAccessor<BancoDados>
    with _$PagamentoDaoMixin {
  PagamentoDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<Pagamento>> todos() async {
    var res = await select(tabelaPagamento).get();
    var lista = <Pagamento>[];
    for (var cada in res) {
      var subRes = await (select(tabelaPagamentoFinal)
            ..where((tbl) => tbl.id.equals(cada.id)))
          .getSingleOrNull();
      if (subRes != null) {
        // lista.add(cada);
      }
    }
    return lista;
  }

  Future<int> adicionarPagamento(Pagamento dado) async {
    var res = await (into(tabelaPagamento).insert(dado.toCompanion(true)));
    return res;
  }
  
  Future<int> adicionarPagamentoFinal(PagamentoFinal dado) async {
    var res = await (into(tabelaPagamentoFinal).insert(dado.toCompanion(true)));
    return res;
  }

  Future<int> removerPagamento(int id) async {
    var res =
        await (delete(tabelaPagamento)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }

  Future<bool> actualizarPagamento(Pagamento dado) async {
    var res = await (update(tabelaPagamento)).replace(dado.toCompanion(true));
    return res;
  }
}
