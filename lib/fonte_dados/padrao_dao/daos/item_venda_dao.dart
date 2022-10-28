part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaItemVenda])
class ItemVendaDao extends DatabaseAccessor<BancoDados>
    with _$ItemVendaDaoMixin {
  ItemVendaDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<TabelaItemVendaData>> todos() async {
    var res = await select(tabelaItemVenda).get();
    return res;
  }

  Future<int> adicionarItemVenda(ItemVenda dado) async {
    mostrar(dado.total);
    var res = await (into(tabelaItemVenda).insert(dado.toCompanion(true)));
    return res;
  }

  Future<int> removerItemVenda(int id) async {
    var res =
        await (delete(tabelaItemVenda)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }

  Future<TabelaItemVendaData?> pegarItemVendaDeId(int id) async {
    var res = await (select(tabelaItemVenda)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<bool> actualizarItemVenda(ItemVenda item) async {
    var res = await update(tabelaItemVenda).replace(item.toCompanion(false));
    return res;
  }
}
