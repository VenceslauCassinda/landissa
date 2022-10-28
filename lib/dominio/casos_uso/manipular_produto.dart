import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/preco.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';

import '../../contratos/casos_uso/manipular_preco_i.dart';
import '../../contratos/casos_uso/manipular_produto_i.dart';
import '../../contratos/casos_uso/manipular_stock_i.dart';
import '../../contratos/provedores/provedor_produto_i.dart';

class ManipularProduto implements ManipularProdutoI {
  late ProvedorProdutoI _provedorProdutoI;
  late ManipularStockI _manipularStockI;
  final ManipularPrecoI _manipularPrecoI;

  ManipularProduto(
      this._provedorProdutoI, this._manipularStockI, this._manipularPrecoI) {}
  @override
  Future<void> actualizarProduto(Produto dado) async {
    await _provedorProdutoI.actualizarProduto(dado);
  }

  @override
  Future<int> adicionarProduto(Produto dado) async {
    if ((await existeProdutoComNome(dado.nome!)) == true) {
      throw ErroProdutoExistente("JÁ EXISTE UM PRODUCTO COM ESTE NOME!");
    }
    var res = await _provedorProdutoI.adicionarProduto(dado);
    var id = await _manipularStockI.inicializarStockProduto(res);

    return res;
  }

  @override
  Future<bool> existeProdutoComNome(String nome) async {
    return await _provedorProdutoI.existeProdutoComNome(nome);
  }

  @override
  Future<List<Produto>> pegarLista() async {
    return await _provedorProdutoI.pegarLista();
  }

  @override
  Future<void> removerProduto(Produto dado) async {
    var precos = await _manipularPrecoI.pegarPrecoProdutoDeId(dado.id!);
    for (var cada in precos) {
      await _manipularPrecoI.removerPrecoProduto(cada);
    }

    var stock = await _manipularStockI.pegarStockDoProdutoDeId(dado.id!);
    await _manipularStockI.removerProdutoStock(stock?.id ?? -1);
    stock = await _manipularStockI.pegarStockDoProdutoDeId(dado.id!);
    await _provedorProdutoI.removerProduto(dado);
  }

  @override
  Future<bool> existeProdutoDiferenteDeNome(int id, String nomeProduto) async {
    return await _provedorProdutoI.existeProdutoDiferenteDeNome(
        id, nomeProduto);
  }

  @override
  Future<int> adicionarPrecoProduto(
      Produto dado, double preco, int quantidade) async {
    if ((await existeProdutoComPreco(dado, preco)) == true) {
      throw ErroProdutoComPrecoExistente(
          "JÁ EXISTE UM PRODUTO COM ESTE PREÇO!");
    }
    var res = await _manipularPrecoI.adicionarPrecoProduto(Preco(
        estado: Estado.ATIVADO,
        idProduto: dado.id,
        quantidade: quantidade,
        preco: preco));
    return res;
  }

  @override
  Future<bool> existeProdutoComPreco(Produto dado, double preco) async {
    return await _manipularPrecoI.existeProdutoComPreco(dado, preco);
  }

  @override
  Future<void> removerPrecoProduto(
      Produto dado, double preco, int quantidade) async {
    await _manipularPrecoI.removerPrecoProduto(Preco(
        estado: Estado.ELIMINADO,
        idProduto: dado.id,
        preco: preco,
        quantidade: quantidade));
  }

  @override
  Future<Produto?> pegarProdutoDeId(int id) async {
    return await _provedorProdutoI.pegarProdutoDeId(id);
  }

  @override
  Future<bool> atualizarPrecoProduto(
      Produto dado, double preco, int quantidade) async {
    // if (dado.preco != null) {
    //   dado.preco!.preco = preco;
    // } else {
    //   await adicionarPrecoProduto(dado, preco, quantidade);
    //   return true;
    // }
    // return await _manipularPrecoI.atualizarPrecoProduto(dado.preco!);
    return true;
  }

  @override
  Future<void> recuperarProduto(Produto dado) async {
    dado.estado = Estado.ATIVADO;
    await _provedorProdutoI.actualizarProduto(dado);
  }

  @override
  Future<void> activarProduto(Produto dado) async {
    dado.estado = Estado.ATIVADO;
    await _provedorProdutoI.actualizarProduto(dado);
  }

  @override
  Future<void> desactivarrProduto(Produto dado) async {
    dado.estado = Estado.DESACTIVADO;
    await _provedorProdutoI.actualizarProduto(dado);
  }

  @override
  Future<List<Preco>> pegarPrecoProdutoDeId(int id) async {
    return await _manipularPrecoI.pegarPrecoProdutoDeId(id);
  }

  @override
  Future<Stock?> pegarStockDoProdutoDeId(int id) async {
    return await _manipularStockI.pegarStockDoProdutoDeId(id);
  }
}
