part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaFuncionario, TabelaUsuario])
class FuncionarioDao extends DatabaseAccessor<BancoDados>
    with _$FuncionarioDaoMixin {
  FuncionarioDao(BancoDados bancoDados) : super(bancoDados);
  Future<List<Funcionario>> todos() async {
    var consulta = select(tabelaFuncionario).join([
      leftOuterJoin(tabelaUsuario,
          tabelaFuncionario.idUsuario.equalsExp(tabelaUsuario.id))
    ])
      ..where(tabelaUsuario.estado.isBiggerOrEqualValue(Estado.DESACTIVADO) &
          tabelaUsuario.nivelAcesso.isSmallerThanValue(NivelAcesso.GERENTE))..orderBy([OrderingTerm.asc(tabelaFuncionario.nomeCompleto)]);

    var res = (await consulta.get()).map((linhas) {
      var tabela1 = linhas.readTable(tabelaFuncionario);
      var tabela2 = linhas.readTable(tabelaUsuario);
      var funcionario =
          SerializadorFuncionario().fromTabela(tabela1, usuario: tabela2);
      funcionario.idUsuario = tabela2.id;
      funcionario.nomeUsuario = tabela2.nomeUsuario;
      funcionario.estado = tabela2.estado;
      return funcionario;
    }).toList();

    return res;
  }

  Future<List<TabelaFuncionarioData>> todosSemFiltro() async {
    var consulta = await (select(tabelaFuncionario)).get();

    return consulta;
  }

  Future<int> pegarIdFuncioanrioDeNome(String nome) async {
    var consulta = await (select(tabelaFuncionario)
          ..where((tbl) => tbl.nomeCompleto.equals(nome)))
        .getSingle();

    return consulta.id;
  }

  Future<List<Funcionario>> eliminados() async {
    var consulta = select(tabelaFuncionario).join([
      leftOuterJoin(
          tabelaUsuario, tabelaFuncionario.id.equalsExp(tabelaUsuario.id))
    ])
      ..where(tabelaFuncionario.estado.isSmallerThanValue(0))..orderBy([OrderingTerm.asc(tabelaFuncionario.nomeCompleto)]);
    var res = (await consulta.get()).map((linhas) {
      var tabela1 = linhas.readTable(tabelaFuncionario);
      var tabela2 = linhas.readTable(tabelaUsuario);
      var funcionario = SerializadorFuncionario().fromTabela(tabela1);
      funcionario.idUsuario = tabela2.id;
      funcionario.nomeUsuario = tabela2.nomeUsuario;
      return funcionario;
    }).toList();
    return res;
  }

  Future<int> adicionar(TabelaFuncionarioCompanion usuarioData) async {
    return await (into(tabelaFuncionario)).insert(usuarioData);
  }

  Future<TabelaFuncionarioData?> existeFuncionario(String nomeUsuario) async {
    var teste = await ((select(tabelaFuncionario)..limit(1))
          ..where((tbl) => tbl.nomeCompleto.equals(nomeUsuario)))
        .getSingleOrNull();
    return teste;
  }

  Future<TabelaFuncionarioData> pegarFuncionarioDeNome(String nome) async {
    var teste = await ((select(tabelaFuncionario))
          ..where((tbl) => tbl.nomeCompleto.equals(nome)))
        .getSingle();
    return teste;
  }

  Future<TabelaFuncionarioData> pegarFuncionarioDeId(int id) async {
    var teste = await ((select(tabelaFuncionario))
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
    return teste;
  }

  Future<Funcionario> pegarFuncionarioDoUsuarioDeId(int id) async {
    var res = await (select(tabelaUsuario).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaUsuario.id.equalsExp(tabelaFuncionario.idUsuario))
    ])
          ..where(tabelaUsuario.id.equals(id)))
        .getSingle();
    var funcioanrio = res.readTable(tabelaFuncionario);
    var usuario = res.readTable(tabelaUsuario);
    return SerializadorFuncionario().fromTabela(funcioanrio, usuario: usuario);
  }

  Future<void> remover(TabelaFuncionarioData usuarioData) async {
    await (delete(tabelaFuncionario)
          ..where((tbl) => tbl.id.equals(usuarioData.id)))
        .go();
  }

  Future<void> actualizar(TabelaFuncionarioData usuarioData) async {
    await (update(tabelaFuncionario).replace(usuarioData));
  }
}
