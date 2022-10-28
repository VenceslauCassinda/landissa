import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/entidade.dart';

import '../../contratos/provedores/provedor_entidade_i.dart';
import '../padrao_dao/base_dados.dart';

class ProvedorEntidade implements ProvedorEntidadeI {
  late EntidadeDao _dao;
  ProvedorEntidade() {
    _dao = EntidadeDao(Get.find());
  }
  @override
  Future<bool> actualizaEntidade(Entidade dado) async {
    return await _dao.actualizarCliente(dado);
  }

  @override
  Future<int> existeEntidade(String nome, String numero) async {
    return (await _dao.existeEntidadeDeNome(nome, numero)) == null ? -1 : 1;
  }

  @override
  Future<Entidade?> pegarEntidadeDeId(int id) async {
    var res = await _dao.pegarEntidadeDeId(id);
    if (res != null) {
      return Entidade(
          endereco: res.endereco,
          estado: res.estado,
          id: res.id,
          nif: res.nif,
          nome: res.nome,
          telefone: res.telefone);
    }
    return null;
  }

  @override
  Future<int> registarEntidade(Entidade dado) async {
    return await _dao.adicionarEntidade(dado);
  }

  @override
  Future<void> removerEntidade(Entidade dado) async {
    await _dao.removerEntidadeDeId(dado.id!);
  }

  @override
  Future<List<Entidade>> todos() async {
    return (await _dao.pegarEntidades()).map((e) {
      return Entidade(
          endereco: e.endereco,
          estado: e.estado,
          id: e.id,
          nif: e.nif,
          nome: e.nome,
          telefone: e.telefone);
    }).toList();
  }
}
