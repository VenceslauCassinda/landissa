part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaSaidaCaixa, TabelaFuncionario])
class SaidaCaixaDao extends DatabaseAccessor<BancoDados>
    with _$SaidaCaixaDaoMixin {
  SaidaCaixaDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<SaidaCaixa>> todos() async {
    var res = await (select(tabelaSaidaCaixa).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaSaidaCaixa.idFuncionario.equalsExp(tabelaFuncionario.id))
    ])
          ..orderBy([OrderingTerm.desc(tabelaSaidaCaixa.data)]))
        .get();
    var lista = res.map((linha) {
      var funcionario = linha.readTable(tabelaFuncionario);
      var caixa = linha.readTable(tabelaSaidaCaixa);
      return SaidaCaixa(
        id: caixa.id,
        funcionario: SerializadorFuncionario().fromTabela(funcionario),
        estado: caixa.estado,
        idFuncionario: caixa.idFuncionario,
        valor: caixa.valor,
        data: caixa.data,
        motivo: caixa.motivo,
      );
    }).toList();
    return lista;
  }

  Future<int> adcionarSaidaCaixa(SaidaCaixa dado) async {
    var res = await into(tabelaSaidaCaixa).insert(dado.toCompanion(true));
    return res;
  }

  Future<int> removerSaidaCaixaDeId(int id) async {
    var res = await ((delete(tabelaSaidaCaixa))
          ..where((tbl) => tbl.id.equals(id)))
        .go();
    return res;
  }

  Future<bool> actualizar(SaidaCaixa dado) async {
    var res = await (update(tabelaSaidaCaixa).replace(dado.toCompanion(true)));
    return res;
  }

  Future<void> removerTudo() async {
    await (delete(tabelaSaidaCaixa)).go();
  }

  Future<void> removerAntes(DateTime data) async {
    await (delete(tabelaSaidaCaixa)
          ..where((tbl) => tbl.data.isSmallerOrEqualValue(data)))
        .go();
  }
}
