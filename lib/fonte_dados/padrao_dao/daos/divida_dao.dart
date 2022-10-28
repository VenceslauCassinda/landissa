part of '../base_dados.dart';

@DriftAccessor(tables: [
  TabelaFuncionario,
  TabelaCliente,
  TabelaDivida,
  TabelaProduto,
])
class DividaDao extends DatabaseAccessor<BancoDados> with _$DividaDaoMixin {
  DividaDao(BancoDados attachedDatabase) : super(attachedDatabase);
  Future<int> adicionarDivida(Divida dado) async {
    var res = await into(tabelaDivida).insert(dado.toCompanion(true));
    return res;
  }

  Future<int> removerDividaDeId(int id) async {
    var res =
        await (delete(tabelaDivida)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }

  Future<void> removerTodasDivida() async {
    await (delete(tabelaDivida)).go();
  }

  Future<TabelaDividaData?> pegarDividaDeId(int id) async {
    var res = await (select(tabelaDivida)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<bool> actualizarDivida(Divida dado) async {
    var res = await update(tabelaDivida).replace(dado.toCompanion(true));
    return res;
  }

  Future<List<Divida>> pegarTodasDividasModoSimples() async {
    var dividas = <Divida>[];
    var resDividasFuncionariosProdutos = select(tabelaDivida).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaDivida.idFuncionario.equalsExp(tabelaFuncionario.id)),
    ])
      ..orderBy([OrderingTerm.desc(tabelaDivida.data)]);

    for (var linha in (await resDividasFuncionariosProdutos.get())) {
      var divida = linha.readTable(tabelaDivida);
      var dadoUtil = Divida(
          id: divida.id,
          idProduto: divida.idProduto,
          estado: divida.estado,
          idFuncionario: divida.idFuncionario,
          idCliente: divida.idCliente,
          data: divida.data,
          total: divida.total,
          dataPagamento: divida.dataPagamento,
          idFuncionarioPagante: divida.idFuncionarioPagante,
          paga: divida.paga,
          quantidadeDevida: divida.quantidadeDevida);
      dividas.add(dadoUtil);
    }

    return dividas;
  }
}
