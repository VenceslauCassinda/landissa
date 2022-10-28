import 'package:yetu_gestor/dominio/entidades/entidade.dart';

import '../../contratos/casos_uso/manipular_entidade_i.dart';
import '../../contratos/provedores/provedor_entidade_i.dart';

class ManipularEntidade implements ManipularEntidadeI {
  ProvedorEntidadeI _provedor;
  ManipularEntidade(this._provedor);
  @override
  Future<bool> actualizaEntidade(Entidade dado) async {
    return await _provedor.actualizaEntidade(dado);
  }

  @override
  Future<int> existeEntidade(String nome, String numero) async {
    return await _provedor.existeEntidade(nome, numero);
  }

  @override
  Future<Entidade?> pegarEntidadeDeId(int id) async {
    return await _provedor.pegarEntidadeDeId(id);
  }

  @override
  Future<int> registarEntidade(Entidade dado) async {
    return await _provedor.registarEntidade(dado);
  }

  @override
  Future<void> removerEntidade(Entidade dado) async {
    return await _provedor.removerEntidade(dado);
  }

  @override
  Future<List<Entidade>> todos() async {
    return await _provedor.todos();
  }
}
