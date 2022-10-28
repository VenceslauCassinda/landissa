import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';

import '../../contratos/casos_uso/manipular_entrada_i.dart';
import '../../contratos/casos_uso/manipular_stock_i.dart';
import '../../contratos/provedores/provedor_entrada_i.dart';

class ManipularEntrada implements ManipularEntradaI {
  final ProvedorEntradaI _provedorEntradaI;
  final ManipularStockI _manipularStockI;

  ManipularEntrada(this._provedorEntradaI, this._manipularStockI);

  @override
  Future<int> registarEntrada(Entrada entrada) async {
    var res = await _provedorEntradaI.registarEntrada(entrada);
    var id = await _manipularStockI.aumentarQuantidadeStock(
        entrada.idProduto!, entrada.quantidade!);
    // print((await _manipularStockI.pegarStockDeId(id))?.toString());
    return res;
  }

  @override
  Future<List<Entrada>> pegarLista() async {
    return await _provedorEntradaI.pegarLista();
  }

  @override
  Future<List<Entrada>> pegarListaDoProduto(Produto produto) async {
    return await _provedorEntradaI.pegarListaDoProduto(produto.id!);
  }

  @override
  Future<List<Entrada>> pegarListaEntradasFuncionario(
      Funcionario funcionario) async {
    return await _provedorEntradaI
        .pegarListaEntradasFuncionario(funcionario.id!);
  }

  @override
  Future<Entrada?> pegarEntradaDeProdutoDeId(int id) async {
    return await _provedorEntradaI.pegarEntradaDeProdutoDeId(id);
  }

  @override
  Future<int> actualizarEntrada(Entrada entrada) async {
    await _provedorEntradaI.actualizarEntrada(entrada);
    return 1;
  }

  @override
  Future removerAntes(DateTime data) async {
    await _provedorEntradaI.removerAntes(data);
  }

  @override
  Future removerTudo() async {
    await _provedorEntradaI.removerTudo();
  }
}
