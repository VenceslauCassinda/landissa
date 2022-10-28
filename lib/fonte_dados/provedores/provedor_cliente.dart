import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';

import '../../contratos/provedores/provedor_cliente_i.dart';
import '../padrao_dao/base_dados.dart';

class ProvedorCliente implements ProvedorClienteI {
  late ClienteDao _dao;
  ProvedorCliente() {
    _dao = ClienteDao(Get.find());
  }
  @override
  Future<bool> actualizaCliente(Cliente dado) async {
    return await _dao.actualizarCliente(dado);
  }

  @override
  Future<int> adicionarCliente(Cliente dado) async {
    return await _dao.adicionarCliente(dado);
  }

  @override
  Future<Cliente?> pegarClienteDeId(int id) async {
    var res = await _dao.pegarClienteDeId(id);
    if (res != null) {
      return Cliente(estado: res.estado, nome: res.nome, numero: res.numero);
    }
    return null;
  }

  @override
  Future<void> removerCliente(Cliente dado) async {}

  @override
  Future<List<Cliente>> todos() async {
    return (await _dao.pegarClientes())
        .map((e) =>
            Cliente(estado: e.estado, nome: e.nome, numero: e.numero, id: e.id))
        .toList();
  }

  @override
  Future<int?> existeCliente(String nome, String numero) async {
    var res = await _dao.existeClienteDeNomeEnumero(nome, numero);
    return (res != null) ? res.id : -1;
  }

  @override
  Future<void> removerTudo() async {
    await _dao.removerTudo();
  }
}
