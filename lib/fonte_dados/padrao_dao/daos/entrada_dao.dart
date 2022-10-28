part of '../base_dados.dart';

@DriftAccessor(tables: [
  TabelaEntrada,
  TabelaProduto,
  TabelaRececcao,
  TabelaFuncionario,
  TabelaStock
])
class EntradaDao extends DatabaseAccessor<BancoDados> with _$EntradaDaoMixin {
  EntradaDao(BancoDados attachedDatabase) : super(attachedDatabase);

  Future<List<Entrada>> todas() async {
    List<Entrada> lista = [];
    var res = await (select(tabelaEntrada).join([
      leftOuterJoin(
          tabelaProduto, tabelaEntrada.idProduto.equalsExp(tabelaProduto.id)),
      leftOuterJoin(
          tabelaStock, tabelaProduto.id.equalsExp(tabelaStock.idProduto)),
    ])
          ..orderBy([OrderingTerm.desc(tabelaEntrada.data)]))
        .get();

    for (var linhaEntradaVsProdutoVsRececcao in res) {
      var produto =
          linhaEntradaVsProdutoVsRececcao.readTableOrNull(tabelaProduto);
      var entrada =
          linhaEntradaVsProdutoVsRececcao.readTableOrNull(tabelaEntrada);
      var stock = linhaEntradaVsProdutoVsRececcao.readTableOrNull(tabelaStock);
      if (stock == null || entrada == null) {
        continue;
      }
      lista.add(Entrada(
          produto: produto == null
              ? null
              : Produto(
                  id: produto.id,
                  estado: produto.estado,
                  nome: produto.nome,
                  precoCompra: produto.precoCompra,
                  recebivel: produto.recebivel,
                  stock: Stock(
                      id: stock.id,
                      estado: stock.estado,
                      idProduto: stock.idProduto,
                      quantidade: stock.quantidade),
                ),
          estado: entrada.estado,
          motivo: entrada.motivo,
          idProduto: entrada.idProduto,
          idRececcao: entrada.idRececcao,
          quantidade: entrada.quantidade,
          data: entrada.data));
    }

    return lista;
  }

  Future<List<Entrada>> todasComProdutoDeId(int idProduto) async {
    List<Entrada> lista = [];

    var res = await ((select(tabelaEntrada)
              ..where((tbl) => tbl.idProduto.equals(idProduto)))
            .join([
      leftOuterJoin(
          tabelaProduto, tabelaEntrada.idProduto.equalsExp(tabelaProduto.id)),
      leftOuterJoin(
          tabelaStock, tabelaProduto.id.equalsExp(tabelaStock.idProduto)),
    ])
          ..orderBy([OrderingTerm.desc(tabelaEntrada.data)]))
        .get();

    for (var linhaEntradaVsProdutoVsRececcao in res) {
      var produto =
          linhaEntradaVsProdutoVsRececcao.readTableOrNull(tabelaProduto);
      var entrada = linhaEntradaVsProdutoVsRececcao.readTable(tabelaEntrada);
      var stock = linhaEntradaVsProdutoVsRececcao.readTable(tabelaStock);

      var resRececcaoVsFuncionario = await select(tabelaRececcao).join([
        leftOuterJoin(tabelaFuncionario,
            tabelaRececcao.idFuncionario.equalsExp(tabelaFuncionario.id)),
      ]).get();

      lista.add(Entrada(
          produto: produto == null
              ? null
              : Produto(
                  id: produto.id,
                  estado: produto.estado,
                  nome: produto.nome,
                  precoCompra: produto.precoCompra,
                  recebivel: produto.recebivel,
                  stock: Stock(
                      id: stock.id,
                      estado: stock.estado,
                      idProduto: stock.idProduto,
                      quantidade: stock.quantidade),
                ),
          estado: entrada.estado,
          motivo: entrada.motivo,
          idProduto: entrada.idProduto,
          idRececcao: entrada.idRececcao,
          quantidade: entrada.quantidade,
          data: entrada.data));
    }

    return lista;
  }

  Future<int> adicionarEntrada(Entrada entrada) async {
    var res = into(tabelaEntrada).insert(entrada.toCompanion(true));
    return res;
  }

  Future<TabelaEntradaData?> pegarEntradaDeId(int id) async {
    var res = (select(tabelaEntrada)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<void> removerEntrada(int id) async {
    await (delete(tabelaEntrada)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<Entrada?> pegarEntradaDeProdutoDeId(int id) async {
    var res = await (select(tabelaEntrada)
          ..where((tbl) => tbl.idProduto.equals(id)))
        .get();
    Entrada? entrada;
    for (var cada in res) {
      if (comapararDatas(cada.data, DateTime.now()) == true &&
          cada.idProduto == id) {
        entrada = Entrada(
            estado: cada.estado,
            idProduto: cada.idProduto,
            quantidade: cada.quantidade,
            data: cada.data,
            id: cada.id,
            motivo: cada.motivo,
            idRececcao: null);
        break;
      }
    }
    return entrada;
  }

  Future<bool> actualizarEntrada(Entrada dado) async {
    var res = await update(tabelaEntrada).replace(dado.toCompanion(true));
    return res;
  }

  Future<void> actualizar(Entrada entrada) async {
    await update(tabelaEntrada).replace(TabelaEntradaCompanion.insert(
        estado: entrada.estado!,
        idProduto: entrada.idProduto!,
        id: entrada.id == null ? const Value.absent() : Value(entrada.id!),
        motivo: Value(entrada.motivo),
        quantidade: entrada.quantidade!,
        data: entrada.data!,
        idRececcao: -1));
  }

  Future<void> removerTudo() async {
    await (delete(tabelaEntrada)).go();
  }

  Future<void> removerAntes(DateTime data) async {
    await (delete(tabelaEntrada)
          ..where((tbl) => tbl.data.isSmallerOrEqualValue(data)))
        .go();
  }
}
