part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaDinheiroSobra, TabelaFuncionario])
class DinheiroSobraDao extends DatabaseAccessor<BancoDados>
    with _$DinheiroSobraDaoMixin {
  DinheiroSobraDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<DinheiroSobra>> todos() async {
    var res = await (select(tabelaDinheiroSobra).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaDinheiroSobra.idFuncionario.equalsExp(tabelaFuncionario.id))
    ])
          ..orderBy([OrderingTerm.desc(tabelaDinheiroSobra.data)]))
        .get();
    var lista = res.map((linha) {
      var funcionario = linha.readTable(tabelaFuncionario);
      var dinheiroSobra = linha.readTable(tabelaDinheiroSobra);
      return DinheiroSobra(
          id: dinheiroSobra.id,
          funcionario: SerializadorFuncionario().fromTabela(funcionario),
          estado: dinheiroSobra.estado,
          idFuncionario: dinheiroSobra.idFuncionario,
          data: DateTime(
              dinheiroSobra.data.year,
              dinheiroSobra.data.month,
              dinheiroSobra.data.day,
              dinheiroSobra.data.hour,
              dinheiroSobra.data.minute),
          valor: dinheiroSobra.valor);
    }).toList();
    return lista;
  }
  
  Future<List<DinheiroSobra>> pegarListaDinheiroData(DateTime data) async {
    var res = await (select(tabelaDinheiroSobra).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaDinheiroSobra.idFuncionario.equalsExp(tabelaFuncionario.id))
    ])
          ..orderBy([OrderingTerm.desc(tabelaDinheiroSobra.data)]))
        .get();
    var lista = res.map((linha) {
      var funcionario = linha.readTable(tabelaFuncionario);
      var dinheiroSobra = linha.readTable(tabelaDinheiroSobra);
      return DinheiroSobra(
          id: dinheiroSobra.id,
          funcionario: SerializadorFuncionario().fromTabela(funcionario),
          estado: dinheiroSobra.estado,
          idFuncionario: dinheiroSobra.idFuncionario,
          data: DateTime(
              dinheiroSobra.data.year,
              dinheiroSobra.data.month,
              dinheiroSobra.data.day,
              dinheiroSobra.data.hour,
              dinheiroSobra.data.minute),
          valor: dinheiroSobra.valor);
    }).toList();
    return lista;
  }

  Future<int> adcionarDinheiro(DinheiroSobra dinheiroSobra) async {
    var res =
        await into(tabelaDinheiroSobra).insert(dinheiroSobra.toCompanion(true));
    return res;
  }

  Future<int> removerDinheiroDeId(int id) async {
    var res = await ((delete(tabelaDinheiroSobra))
          ..where((tbl) => tbl.id.equals(id)))
        .go();
    return res;
  }

  Future<bool> actualizarDinheiro(DinheiroSobra dinheiroSobra) async {
    var res = await (update(tabelaDinheiroSobra)
        .replace(dinheiroSobra.toCompanion(true)));
    return res;
  }

  Future<void> removerTudo() async {
    await (delete(tabelaDinheiroSobra)).go();
  }

  Future<void> removerAntes(DateTime data) async {
    await (delete(tabelaDinheiroSobra)
          ..where((tbl) => tbl.data.isSmallerOrEqualValue(data)))
        .go();
  }
}
