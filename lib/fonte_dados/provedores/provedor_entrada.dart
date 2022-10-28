import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';

import '../../contratos/provedores/provedor_entrada_i.dart';

class ProvedorEntrada implements ProvedorEntradaI {
  late EntradaDao _dao;
  ProvedorEntrada() {
    _dao = EntradaDao(Get.find());
  }
  @override
  Future<int> registarEntrada(Entrada entrada) async {
    return await _dao.adicionarEntrada(entrada);
  }

  @override
  Future<List<Entrada>> pegarLista() async {
    return await _dao.todas();
  }

  @override
  Future<List<Entrada>> pegarListaDoProduto(int idProduto) async {
    return await _dao.todasComProdutoDeId(idProduto);
  }

  @override
  Future<List<Entrada>> pegarListaEntradasFuncionario(int idFuncionario) {
    // TODO: implement pegarListaEntradasFuncionario
    throw UnimplementedError();
  }

  @override
  Future<Entrada?> pegarEntradaDeProdutoDeId(int id) async {
    return await _dao.pegarEntradaDeProdutoDeId(id);
  }

  @override
  Future<int> actualizarEntrada(Entrada entrada) async {
    await _dao.actualizarEntrada(entrada);
    return 1;
  }

  @override
  Future removerAntes(DateTime data) async {
    await _dao.removerAntes(data);
  }

  @override
  Future removerTudo() async {
    await _dao.removerTudo();
  }
}
