part of '../base_dados.dart';

@DriftAccessor(tables: [TabelaRececcao, TabelaProduto, TabelaFuncionario])
class RececcaoDao extends DatabaseAccessor<BancoDados> with _$RececcaoDaoMixin {
  RececcaoDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<Receccao>> todas() async {
    Funcionario? pagante;
    var res = await (select(tabelaRececcao).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaFuncionario.id.equalsExp(tabelaRececcao.idFuncionario)),
      leftOuterJoin(
          tabelaProduto, tabelaProduto.id.equalsExp(tabelaRececcao.idProduto))
    ])
          ..orderBy([OrderingTerm.desc(tabelaRececcao.data)]))
        .get();

    List<Receccao> lista = [];

    for (var linha in res) {
      var receccao = linha.readTable(tabelaRececcao);
      var funcionario = linha.readTableOrNull(tabelaFuncionario);
      var produto = linha.readTableOrNull(tabelaProduto);
      if (receccao.idPagante != null &&
          produto != null &&
          funcionario != null) {
        var conversor = await FuncionarioDao(getx.Get.find())
            .pegarFuncionarioDeId(receccao.idPagante!);
        pagante = Funcionario(
          id: conversor.id,
          estado: conversor.estado,
          idUsuario: conversor.idUsuario,
          nomeCompelto: conversor.nomeCompleto,
        );
      }
      var nova = Receccao(
        id: receccao.id,
        pagante: pagante,
        pagavel: receccao.pagavel,
        paga: receccao.paga,
        precoLote: receccao.precoLote,
        quantidadePorLotes: receccao.quantidadePorLotes,
        quantidadeLotes: receccao.quantidadeLotes,
        custoAquisicao: receccao.custoAquisicao,
        estado: receccao.estado,
        funcionario: Funcionario(
          id: funcionario?.id,
          estado: funcionario?.estado,
          idUsuario: funcionario?.idUsuario,
          nomeCompelto: funcionario?.nomeCompleto,
        ),
        produto: Produto(
            id: produto?.id,
            estado: produto?.estado,
            nome: produto?.nome,
            precoCompra: produto?.precoCompra,
            recebivel: produto?.recebivel),
        idFuncionario: receccao.idFuncionario,
        idPagante: receccao.idPagante,
        idProduto: receccao.idProduto,
        data: receccao.data,
        dataPagamento: receccao.dataPagamento,
      );
      lista.add(nova);
    }
    return lista;
  }

  Future<List<Receccao>> todasDoFuncionario(int id) async {
    Funcionario? pagante;
    var res = await ((select(tabelaRececcao)
              ..where((tbl) => tbl.idFuncionario.equals(id)))
            .join([
      leftOuterJoin(
          tabelaProduto, tabelaProduto.id.equalsExp(tabelaRececcao.idProduto)),
      leftOuterJoin(tabelaFuncionario,
          tabelaFuncionario.id.equalsExp(tabelaRececcao.idFuncionario)),
    ])
          ..orderBy([OrderingTerm.desc(tabelaRececcao.data)]))
        .get();
    List<Receccao> lista = [];

    for (var linha in res) {
      var receccao = linha.readTable(tabelaRececcao);
      var funcionario = linha.readTable(tabelaFuncionario);
      var produto = linha.readTable(tabelaProduto);
      if (receccao.idPagante != null) {
        var conversor = await FuncionarioDao(getx.Get.find())
            .pegarFuncionarioDeId(receccao.idPagante!);
        pagante = Funcionario(
          id: conversor.id,
          estado: conversor.estado,
          idUsuario: conversor.idUsuario,
          nomeCompelto: conversor.nomeCompleto,
        );
      }
      var nova = Receccao(
        id: receccao.id,
        pagante: pagante,
        pagavel: receccao.pagavel,
        paga: receccao.paga,
        precoLote: receccao.precoLote,
        quantidadePorLotes: receccao.quantidadePorLotes,
        quantidadeLotes: receccao.quantidadeLotes,
        custoAquisicao: receccao.custoAquisicao,
        estado: receccao.estado,
        funcionario: Funcionario(
          id: funcionario.id,
          estado: funcionario.estado,
          idUsuario: funcionario.idUsuario,
          nomeCompelto: funcionario.nomeCompleto,
        ),
        produto: Produto(
            id: produto.id,
            estado: produto.estado,
            nome: produto.nome,
            precoCompra: produto.precoCompra,
            recebivel: produto.recebivel),
        idFuncionario: receccao.idFuncionario,
        idPagante: receccao.idPagante,
        idProduto: receccao.idProduto,
        data: receccao.data,
        dataPagamento: receccao.dataPagamento,
      );
      lista.add(nova);
    }
    return lista;
  }

  Future<int> adicionarRececcao(Receccao receccao) async {
    return await into(tabelaRececcao).insert(receccao.toCompanion(true));
  }

  Future<void> actualizaRececcao(Receccao receccao) async {
    await update(tabelaRececcao).replace(receccao.toCompanion(true));
  }

  Future<void> removerRececcao(Receccao receccao) async {
    await (delete(tabelaRececcao)..where((tbl) => tbl.id.equals(receccao.id!)))
        .go();
  }

  Future<void> removerTudo() async {
    await (delete(tabelaRececcao)).go();
  }

  Future<void> removerAntes(DateTime data) async {
    await (delete(tabelaRececcao)
          ..where((tbl) => tbl.data.isSmallerOrEqualValue(data)))
        .go();
  }

  Future<TabelaRececcaoData?> pegarRececcaoDeId(int id) async {
    return await (select(tabelaRececcao)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
}
