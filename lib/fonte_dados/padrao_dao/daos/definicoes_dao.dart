part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaDefinicoes])
class DefinicoesDao extends DatabaseAccessor<BancoDados>
    with _$DefinicoesDaoMixin {
  DefinicoesDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<int> adicionarDefinicoes(Definicoes dado) async {
    var res = await into(tabelaDefinicoes).insert(dado.toCompanion(true));
    return res;
  }

  Future<bool> atualizarDefinicoes(Definicoes dado) async {
    var res = update(tabelaDefinicoes);
    return await res.replace(dado.toCompanion(true));
  }

  Future<Definicoes> pegarDefinicoes() async {
    var res = await (select(tabelaDefinicoes)).get();
    var def = res[0];
    return Definicoes(
      id: def.id,
      estado: def.estado,
      idLicenca: def.idLicenca,
      licenciado: def.licenciado,
      dataAcesso: def.dataAcesso,
      dataExpiracao: def.dataExpiracao,
      licenca: def.licenca,
      tipoEntidade: def.tipoEntidade,
      tipoNegocio: def.tipoNegocio,
    );
  }
}
