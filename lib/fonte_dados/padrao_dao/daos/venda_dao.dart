part of '../base_dados.dart';

@DriftAccessor(tables: [
  TabelaVenda,
  TabelaFuncionario,
  TabelaCliente,
  TabelaPagamento,
  TabelaFormaPagamento,
  TabelaItemVenda,
  TabelaProduto,
  TabelaPagamentoFinal
])
class VendaDao extends DatabaseAccessor<BancoDados> with _$VendaDaoMixin {
  VendaDao(BancoDados attachedDatabase) : super(attachedDatabase);
  Future<int> adicionarVenda(Venda dado) async {
    var res = await into(tabelaVenda).insert(dado.toCompanion(true));
    return res;
  }

  Future<int> removerVendaDeId(int id) async {
    var res =
        await (delete(tabelaVenda)..where((tbl) => tbl.id.equals(id))).go();
    return res;
  }

  Future<int> removerTodas() async {
    var res = await (delete(tabelaVenda)).go();
    return res;
  }

  Future<TabelaVendaData?> pegarVendaDeId(int id) async {
    var res = await (select(tabelaVenda)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return res;
  }

  Future<bool> actualizarVenda(Venda dado) async {
    var res = await update(tabelaVenda).replace(dado.toCompanion(true));
    return res;
  }

  Future<List<Venda>> todas() async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);
        var cada = ItemVenda(
            id: item.id,
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);
        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }

      vendas.add(cadaVenda);
    }

    return vendas;
  }

  Future<List<Venda>> pegarVendasDeFuncionarioNaData(
      Funcionario funcionario, DateTime data) async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..where((tabelaVenda.data.year.equals(data.year) &
          tabelaVenda.data.month.equals(data.month) &
          (tabelaVenda.data.day.equals(data.day)) &
          tabelaFuncionario.id.equals(funcionario.id!)))
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);

        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }

      vendas.add(cadaVenda);
    }

    return vendas;
  }

  Future<List<Venda>> pegarVendasDeFuncionarioNaDataModoSimples(
      Funcionario funcionario, DateTime data) async {
    var vendas = <Venda>[];
    var resVendasFuncionariosProdutos = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaProduto, tabelaVenda.idProduto.equalsExp(tabelaProduto.id)),
    ])
      ..where((tabelaVenda.data.year.equals(data.year) &
          tabelaVenda.data.month.equals(data.month) &
          (tabelaVenda.data.day.equals(data.day)) &
          tabelaFuncionario.id.equals(funcionario.id!)))
      ..orderBy([OrderingTerm.asc(tabelaProduto.nome)]);

    for (var linha in (await resVendasFuncionariosProdutos.get())) {
      var produto = linha.readTableOrNull(tabelaProduto);
      var venda = linha.readTable(tabelaVenda);
      if (produto != null) {
        var dadoUtil = Venda(
            id: venda.id,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ),
            idProduto: venda.idProduto,
            quantidadeVendida: venda.quantidadeVendida,
            estado: venda.estado,
            idFuncionario: venda.idFuncionario,
            idCliente: venda.idCliente,
            data: venda.data,
            dataLevantamentoCompra: venda.dataLevantamentoCompra,
            total: venda.total,
            parcela: venda.parcela);
        vendas.add(dadoUtil);
      }
    }

    return vendas;
  }

  Future<List<Venda>> pegarTodasVendasModoSimples() async {
    var vendas = <Venda>[];
    var resVendasFuncionariosProdutos = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaProduto, tabelaVenda.idProduto.equalsExp(tabelaProduto.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..orderBy([OrderingTerm.asc(tabelaProduto.nome)]);

    for (var linha in (await resVendasFuncionariosProdutos.get())) {
      var produto = linha.readTableOrNull(tabelaProduto);
      var venda = linha.readTable(tabelaVenda);
      var cliente = linha.readTableOrNull(tabelaCliente);
      if (produto != null && cliente != null) {
        var cadaCliente = Cliente(
            estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);
        var dadoUtil = Venda(
            id: venda.id,
            cliente: cadaCliente,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ),
            idProduto: venda.idProduto,
            quantidadeVendida: venda.quantidadeVendida,
            estado: venda.estado,
            idFuncionario: venda.idFuncionario,
            idCliente: venda.idCliente,
            data: venda.data,
            dataLevantamentoCompra: venda.dataLevantamentoCompra,
            total: venda.total,
            parcela: venda.parcela);
        vendas.add(dadoUtil);
      }
    }

    return vendas;
  }

  Future<List<Venda>> pegarVendasNaData(DateTime data) async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..where((tabelaVenda.data.year.equals(data.year) &
          tabelaVenda.data.month.equals(data.month) &
          (tabelaVenda.data.day.equals(data.day))))
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);

        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }

      vendas.add(cadaVenda);
    }

    return vendas;
  }

  Future<List<Venda>> pegarVendasDeFuncionario(Funcionario funcionario) async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..distinct
      ..where(tabelaFuncionario.id.equals(funcionario.id!))
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);

        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }

      if (vendas.isNotEmpty) {
        var teste = vendas.firstWhereOrNull((element) {
          var conversao1 = DateTime(
            element.data!.year,
            element.data!.month,
            element.data!.day,
          );
          var conversao2 = DateTime(
            cadaVenda.data!.year,
            cadaVenda.data!.month,
            cadaVenda.data!.day,
          );

          if (conversao1.isAtSameMomentAs(conversao2)) {
            return true;
          }
          return false;
        });

        if (teste == null) {
          vendas.add(cadaVenda);
        } else {
          continue;
        }
      } else {
        vendas.add(cadaVenda);
      }
    }

    return vendas;
  }

  Future<List<Venda>> pegarVendasComDatasUnicas() async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..distinct
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);

        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }

      if (vendas.isNotEmpty) {
        var teste = vendas.firstWhereOrNull((element) {
          var conversao1 = DateTime(
            element.data!.year,
            element.data!.month,
            element.data!.day,
          );
          var conversao2 = DateTime(
            cadaVenda.data!.year,
            cadaVenda.data!.month,
            cadaVenda.data!.day,
          );

          if (conversao1.isAtSameMomentAs(conversao2)) {
            return true;
          }
          return false;
        });

        if (teste == null) {
          vendas.add(cadaVenda);
        } else {
          continue;
        }
      } else {
        vendas.add(cadaVenda);
      }
    }

    return vendas;
  }

  Future<List<Venda>> pegarDividasDeFuncionario(Funcionario funcionario) async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..where(tabelaFuncionario.id.equals(funcionario.id!) &
          ((tabelaVenda.total.equalsExp(tabelaVenda.parcela)).not()))
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);
        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        // print("============> $resPagamentosEformas");
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }
      vendas.add(cadaVenda);
    }

    return vendas;
  }

  Future<List<Venda>> todasDividas() async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..where(((tabelaVenda.total.equalsExp(tabelaVenda.parcela)).not()))
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);

        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        // print("============> $resPagamentosEformas");
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }
      vendas.add(cadaVenda);
    }

    return vendas;
  }

  Future<List<Venda>> pegarEncomendasDeFuncionario(
      Funcionario funcionario) async {
    var vendas = <Venda>[];
    var resVendasFuncionariosClientes1 = select(tabelaVenda).join([
      leftOuterJoin(tabelaFuncionario,
          tabelaVenda.idFuncionario.equalsExp(tabelaFuncionario.id)),
      leftOuterJoin(
          tabelaCliente, tabelaVenda.idCliente.equalsExp(tabelaCliente.id)),
    ])
      ..where(tabelaFuncionario.id.equals(funcionario.id!) &
          ((tabelaVenda.data.year
                  .equalsExp(tabelaVenda.dataLevantamentoCompra.year)
                  .not() |
              tabelaVenda.data.month
                  .equalsExp(tabelaVenda.dataLevantamentoCompra.month)
                  .not() |
              (tabelaVenda.data.day
                  .equalsExp(tabelaVenda.dataLevantamentoCompra.day)
                  .not()))))
      ..orderBy([OrderingTerm.desc(tabelaVenda.data)]);

    var resVendasFuncionariosClientes2 =
        await resVendasFuncionariosClientes1.get();
    for (var cadaLinha in resVendasFuncionariosClientes2) {
      var venda = cadaLinha.readTable(tabelaVenda);
      var cliente = cadaLinha.readTable(tabelaCliente);
      var resVendasPagamentos = await ((select(tabelaVenda).join([
        leftOuterJoin(
            tabelaPagamento, tabelaPagamento.idVenda.equalsExp(tabelaVenda.id)),
      ]))
            ..where(tabelaPagamento.idVenda.equals(venda.id)))
          .get();
      var resVendasItemVenda = await ((select(tabelaItemVenda).join([
        leftOuterJoin(tabelaProduto,
            tabelaItemVenda.idProduto.equalsExp(tabelaProduto.id)),
      ]))
            ..where(tabelaItemVenda.idVenda.equals(venda.id)))
          .get();

      var listaItensVenda = <ItemVenda>[];
      for (var e in resVendasItemVenda) {
        var item = e.readTable(tabelaItemVenda);
        var produto = e.readTable(tabelaProduto);

        var cada = ItemVenda(
            estado: item.estado,
            idProduto: item.idProduto,
            quantidade: item.quantidade,
            desconto: item.desconto,
            idVenda: item.idVenda,
            total: item.total,
            produto: Produto(
              id: produto.id,
              estado: produto.estado,
              precoCompra: produto.precoCompra,
              recebivel: produto.recebivel,
              nome: produto.nome,
            ));
        listaItensVenda.add(cada);
      }
      var cadaCliente = Cliente(
          estado: cliente.estado, nome: cliente.nome, numero: cliente.numero);

      var cadaVenda = Venda(
          id: venda.id,
          idProduto: venda.idProduto,
          quantidadeVendida: venda.quantidadeVendida,
          cliente: cadaCliente,
          itensVenda: listaItensVenda,
          estado: venda.estado,
          idFuncionario: venda.idFuncionario,
          idCliente: venda.idCliente,
          data: venda.data,
          dataLevantamentoCompra: venda.dataLevantamentoCompra,
          total: venda.total,
          parcela: venda.parcela);

      for (var linhaVendasPagamentos in resVendasPagamentos) {
        var pagamento = linhaVendasPagamentos.readTable(tabelaPagamento);

        var pagamentoFInal = await (select(tabelaPagamentoFinal)
              ..where((tbl) => tbl.idPagamento.equals(pagamento.id)))
            .getSingleOrNull();

        var resPagamentosEformas = await ((select(tabelaPagamento).join([
          leftOuterJoin(
              tabelaFormaPagamento,
              tabelaFormaPagamento.id
                  .equalsExp(tabelaPagamento.idFormaPagamento)),
        ]))
              ..where(tabelaPagamento.id.equals(pagamento.id)))
            .getSingle();
        // print("============> $resPagamentosEformas");
        var forma = resPagamentosEformas.readTableOrNull(tabelaFormaPagamento);
        var cadaPagamento = Pagamento(
            id: pagamento.id,
            pagamentoFinal: pagamentoFInal == null
                ? null
                : PagamentoFinal(
                    id: pagamentoFInal.id,
                    estado: pagamentoFInal.estado,
                    idPagamento: pagamentoFInal.idPagamento,
                    data: pagamentoFInal.data),
            formaPagamento: forma == null
                ? null
                : FormaPagamento(
                    id: forma.id,
                    estado: forma.estado,
                    tipo: forma.tipo,
                    descricao: forma.descricao),
            idFormaPagamento: forma?.id,
            estado: pagamento.estado,
            idVenda: pagamento.idVenda,
            valor: pagamento.valor);
        cadaVenda.pagamentos ??= [];
        cadaVenda.pagamentos!.add(cadaPagamento);
      }

      vendas.add(cadaVenda);
    }

    return vendas;
  }

  Future<List<Pagamento>> pegarListaPagamentoDaData(DateTime data) async {
    var res = await (select(tabelaPagamento).join([
      leftOuterJoin(tabelaPagamentoFinal,
          tabelaPagamentoFinal.idPagamento.equalsExp(tabelaPagamento.id))
    ])
          ..where((tabelaPagamentoFinal.data.year.equals(data.year) &
              tabelaPagamentoFinal.data.month.equals(data.month) &
              (tabelaPagamentoFinal.data.day.equals(data.day)))))
        .get();
    var lista = <Pagamento>[];
    for (var linha in res) {
      var cada = linha.readTable(tabelaPagamento);
      var pagFinal = linha.readTable(tabelaPagamentoFinal);
      lista.add(Pagamento(
          estado: cada.estado,
          valor: cada.valor,
          pagamentoFinal: PagamentoFinal(
              data: pagFinal.data,
              estado: pagFinal.estado,
              idPagamento: cada.id,
              id: pagFinal.id)));
    }
    return lista;
  }

  Future<List<Pagamento>> pegarListaPagamentoDaDataFuncionario(
      Funcionario funcionario, DateTime data) async {
    var vendas = await pegarVendasDeFuncionarioNaData(funcionario, data);
    var res = await (select(tabelaPagamento).join([
      leftOuterJoin(tabelaPagamentoFinal,
          tabelaPagamentoFinal.idPagamento.equalsExp(tabelaPagamento.id)),
    ])
          ..where((tabelaPagamentoFinal.data.year.equals(data.year) &
              tabelaPagamentoFinal.data.month.equals(data.month) &
              (tabelaPagamentoFinal.data.day.equals(data.day)))))
        .get();
    var lista = <Pagamento>[];
    for (var linha in res) {
      var cada = linha.readTable(tabelaPagamento);
      var pagFinal = linha.readTable(tabelaPagamentoFinal);
      lista.add(Pagamento(
          id: cada.id,
          idFormaPagamento: cada.idFormaPagamento,
          idVenda: cada.idVenda,
          estado: cada.estado,
          valor: cada.valor,
          pagamentoFinal: PagamentoFinal(
              data: pagFinal.data,
              estado: pagFinal.estado,
              idPagamento: cada.id,
              id: pagFinal.id)));
    }

    if (vendas.isEmpty == true) {
      lista.clear();
    } else {
      lista.removeWhere((p) {
        var existe = vendas.firstWhereOrNull((v) => p.idVenda == v.id);
        return existe == null;
      });
    }

    return lista;
  }
}
