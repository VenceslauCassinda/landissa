import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';

import '../../contratos/provedores/provedor_produto_i.dart';
import '../padrao_dao/base_dados.dart';

class ProvedorProduto implements ProvedorProdutoI {
  late ProdutoDao _dao;
  ProvedorProduto() {
    _dao = ProdutoDao(Get.find());
  }
  @override
  Future<void> actualizarProduto(Produto dado) async {
    await _dao.actualizarProduto(dado.toCompanion(true));
  }

  @override
  Future<int> adicionarProduto(Produto dado) async {
    return await _dao.adicionarProduto(dado);
  }

  @override
  Future<bool> existeProdutoComNome(String nome) async {
    var res = await _dao.existeProdutoDeNome(nome);
    return res != null;
  }

  @override
  Future<List<Produto>> pegarLista() async {
    return await _dao.todos();
  }

  @override
  Future<void> removerProduto(Produto dado) async {
    await _dao.removerProduto(dado.id!);
  }

  @override
  Future<bool> existeProdutoDiferenteDeNome(int id, String nomeProduto) async {
    return (await _dao.existeProdutoDiferenteDeNome(id, nomeProduto)) != null;
  }

  @override
  Future<Produto?> pegarProdutoDeId(int id) async {
    var res = await _dao.pagarProdutoDeId(id);
    if (res != null) {
      return Produto(
        id: res.id,
        nome: res.nome,
        estado: res.estado,
        precoCompra: res.precoCompra,
        recebivel: res.recebivel,
      );
    }
    return null;
  }
}
