part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaUsuario])
class UsuarioDao extends DatabaseAccessor<BancoDados> with _$UsuarioDaoMixin {
  UsuarioDao(BancoDados bancoDados) : super(bancoDados);
  Future<List<TabelaUsuarioData>> todos() async {
    // (await ((select(tabelaUsuario))).get()).forEach((element) {
    //   print("=======> ${element.nomeUsuario}");
    //   print(element.estado);
    // });

    await ((select(tabelaUsuario))
          ..where((tbl) {
            return tbl.estado.isBiggerOrEqualValue(Estado.DESACTIVADO);
          })
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.nomeUsuario, mode: OrderingMode.asc)
          ]))
        .get();
    return [];
  }

  Future<List<TabelaUsuarioData>> todosSemFiltro() async {
    var consulta = await ((select(tabelaUsuario))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.nomeUsuario, mode: OrderingMode.asc)
          ]))
        .get();
    return consulta;
  }

  Future<List<TabelaUsuarioData>> eliminados() async {
    return await ((select(tabelaUsuario)
          ..orderBy(
              [(tbl) => OrderingTerm(expression: tbl.nomeUsuario, mode: OrderingMode.asc)]))
          ..where((tbl) {
            return tbl.estado.equals(Estado.ELIMINADO) | tbl.estado.isNull();
          }))
        .get();
  }

  Future<int> adicionar(TabelaUsuarioCompanion usuarioData) async {
    return await (into(tabelaUsuario)).insert(usuarioData);
  }

  Future<TabelaUsuarioData?> existeUsuario(
      String nomeUsuario, String palavraPasse) async {
    return await ((select(tabelaUsuario))
          ..where((tbl) =>
              tbl.nomeUsuario.equals(nomeUsuario) &
              tbl.palavraPasse.equals(palavraPasse)))
        .getSingleOrNull();
  }

  Future<TabelaUsuarioData> pegarUsuario(String nomeUsuario) async {
    return await ((select(tabelaUsuario))
          ..where((tbl) => tbl.nomeUsuario.equals(nomeUsuario)))
        .getSingle();
  }

  Future<bool> usuarioLogado(String nomeUsuario) async {
    var resposta = await ((select(tabelaUsuario))
          ..where((tbl) => (tbl.logado.equals(true) &
              (tbl.nomeUsuario.equals(nomeUsuario)))))
        .getSingleOrNull();
    return resposta != null;
  }

  Future<void> logarUsuario(String nomeUsuario, String palavraPasse) async {
    var resposta = await ((select(tabelaUsuario))
          ..where((tbl) => ((tbl.nomeUsuario.equals(nomeUsuario) &
              tbl.palavraPasse.equals(palavraPasse)))))
        .getSingleOrNull();

    if (resposta != null) {
      actualizar(TabelaUsuarioData(
          id: resposta.id,
          nivelAcesso: resposta.nivelAcesso,
          nomeUsuario: resposta.nomeUsuario,
          logado: true,
          estado: resposta.estado,
          imagemPerfil: resposta.imagemPerfil,
          palavraPasse: resposta.palavraPasse));
    }
  }

  Future<void> terminarSessao(String nomeUsuario, String palavraPasse) async {
    var resposta = await ((select(tabelaUsuario))
          ..where((tbl) => ((tbl.nomeUsuario.equals(nomeUsuario)))))
        .getSingleOrNull();

    if (resposta != null) {
      actualizar(TabelaUsuarioData(
          id: resposta.id,
          nivelAcesso: resposta.nivelAcesso,
          nomeUsuario: resposta.nomeUsuario,
          estado: resposta.estado,
          logado: false,
          imagemPerfil: resposta.imagemPerfil,
          palavraPasse: resposta.palavraPasse));
    }
  }

  Future<bool> existeNomeUsuario(String nomeUsuario) async {
    return (await ((select(tabelaUsuario))
              ..where((tbl) => tbl.nomeUsuario.equals(nomeUsuario)))
            .get())
        .isNotEmpty;
  }

  Future<void> remover(int idUsuario) async {
    await (delete(tabelaUsuario)..where((tbl) => tbl.id.equals(idUsuario)))
        .go();
  }

  Future<void> actualizar(TabelaUsuarioData usuarioData) async {
    await (update(tabelaUsuario).replace(usuarioData));
  }
}
