import 'package:yetu_gestor/contratos/provedores/provedor_dinheiro_sobra_i.dart';
import 'package:yetu_gestor/dominio/entidades/dinheiro_sobra.dart';

import '../../contratos/casos_uso/manipular_dinheiro_sobra_i.dart';

class ManipularDinheiroSobra implements ManipularDinheiroSobraI {
  final ProvedorDinheiroSobraI _provedorDinheiroSobraI;

  ManipularDinheiroSobra(this._provedorDinheiroSobraI);
  @override
  Future<bool> actualizarDinheiroSobra(DinheiroSobra dinheiroSobra) async {
    return await _provedorDinheiroSobraI.actualizarDinheiroSobra(dinheiroSobra);
  }

  @override
  Future<int> adicionarDinheiroSobra(DinheiroSobra dinheiroSobra) async {
    return await _provedorDinheiroSobraI.adicionarDinheiroSobra(dinheiroSobra);
  }

  @override
  Future<List<DinheiroSobra>> pegarLista() async {
    return await _provedorDinheiroSobraI.pegarLista();
  }

  @override
  Future<int> removerDinheiroSobraDeId(int id) async {
    return await _provedorDinheiroSobraI.removerDinheiroSobraDeId(id);
  }

  @override
  Future<int> removerAntes(DateTime data) async {
    return await _provedorDinheiroSobraI.removerAntes(data);
  }

  @override
  Future<int> removerTudo() async {
    return await _provedorDinheiroSobraI.removerTudo();
  }
}
