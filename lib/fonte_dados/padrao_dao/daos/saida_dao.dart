part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaSaida, TabelaProduto])
class SaidaDao extends DatabaseAccessor<BancoDados> with _$SaidaDaoMixin {
  SaidaDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<Saida>> todas() async {
    var res = await (select(tabelaSaida).join([
      leftOuterJoin(
          tabelaProduto, tabelaSaida.idProduto.equalsExp(tabelaProduto.id))
    ])
          ..orderBy([OrderingTerm.desc(tabelaSaida.data)]))
        .get();
    var lista = res.map((linha) {
      var produto = linha.readTableOrNull(tabelaProduto);
      var saida = linha.readTable(tabelaSaida);
      return Saida(
          produto: Produto(
            id: produto?.id,
            estado: produto?.estado,
            nome: produto?.nome,
            precoCompra: produto?.precoCompra,
            recebivel: produto?.recebivel,
          ),
          estado: saida.estado,
          motivo: saida.motivo,
          idProduto: saida.idProduto,
          idVenda: saida.idVenda,
          quantidade: saida.quantidade,
          data: saida.data);
    }).toList();
    return lista;
  }

  Future<List<Saida>> todasComProdutoDeId(int idProduto) async {
    var res = await ((select(tabelaSaida)
              ..where((tbl) => tbl.idProduto.equals(idProduto)))
            .join([
      leftOuterJoin(
          tabelaProduto, tabelaSaida.idProduto.equalsExp(tabelaProduto.id))
    ])
          ..orderBy([OrderingTerm.desc(tabelaSaida.data)]))
        .get();
    var lista = res.map((linha) {
      var produto = linha.readTable(tabelaProduto);
      var saida = linha.readTable(tabelaSaida);
      return Saida(
          produto: Produto(
            id: produto.id,
            estado: produto.estado,
            nome: produto.nome,
            precoCompra: produto.precoCompra,
            recebivel: produto.recebivel,
          ),
          estado: saida.estado,
          motivo: saida.motivo,
          idProduto: saida.idProduto,
          idVenda: saida.idVenda,
          quantidade: saida.quantidade,
          data: saida.data);
    }).toList();
    return lista;
  }

  Future<int> adicionarSaida(Saida saida) async {
    var res = into(tabelaSaida).insert(TabelaSaidaCompanion.insert(
        estado: Estado.ATIVADO,
        idProduto: saida.idProduto!,
        idVenda: Value(saida.idVenda),
        motivo: Value(saida.motivo),
        quantidade: saida.quantidade!,
        data: saida.data!));
    return res;
  }

  Future<TabelaSaidaData?> pegarSaidaDeId(int id) async {
    var res = await (select(tabelaSaida)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<Saida?> pegarSaidaDeProdutoDeId(int id) async {
    var res = await (select(tabelaSaida)
          ..where((tbl) => tbl.idProduto.equals(id)))
        .get();
    Saida? saida;
    for (var cada in res) {
      if (comapararDatas(cada.data, DateTime.now()) == true &&
          cada.idProduto == id) {
        saida = Saida(
            estado: cada.estado,
            id: cada.id,
            idProduto: cada.idProduto,
            quantidade: cada.quantidade,
            data: cada.data,
            motivo: cada.motivo);
        break;
      }
    }
    return saida;
  }

  Future<void> actualizar(Saida saida) async {
    await update(tabelaSaida).replace(TabelaSaidaCompanion.insert(
        estado: saida.estado!,
        idProduto: saida.idProduto!,
        id: saida.id == null ? const Value.absent() : Value(saida.id!),
        idVenda: Value(saida.idVenda),
        motivo: Value(saida.motivo),
        quantidade: saida.quantidade!,
        data: saida.data!));
  }

  Future<bool> actualizarSaida(Saida dado) async {
    var res = await update(tabelaSaida).replace(dado.toCompanion(true));
    return res;
  }

  Future<void> removerSaida(int id) async {
    await (delete(tabelaSaida)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> removerTudo() async {
    await (delete(tabelaSaida)).go();
  }

  Future<void> removerAntes(DateTime data) async {
    await (delete(tabelaSaida)
          ..where((tbl) => tbl.data.isSmallerOrEqualValue(data)))
        .go();
  }
}
