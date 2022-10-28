import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/dinheiro_sobra.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';

import '../../contratos/provedores/provedor_dinheiro_sobra_i.dart';

class ProvedorDinheiroSobra implements ProvedorDinheiroSobraI {
  late DinheiroSobraDao _dao;

  ProvedorDinheiroSobra() {
    _dao = DinheiroSobraDao(Get.find());
  }
  @override
  Future<bool> actualizarDinheiroSobra(DinheiroSobra dinheiroSobra) async {
    return await _dao.actualizarDinheiro(dinheiroSobra);
  }

  @override
  Future<int> adicionarDinheiroSobra(DinheiroSobra dinheiroSobra) async {
    return await _dao.adcionarDinheiro(dinheiroSobra);
  }

  @override
  Future<List<DinheiroSobra>> pegarLista() async {
    return await _dao.todos();
  }

  @override
  Future<int> removerDinheiroSobraDeId(int id) async {
    return await _dao.removerDinheiroDeId(id);
  }
  
  @override
  Future<int> removerAntes(DateTime data) async{
    await _dao.removerAntes(data);
    return 1;
  }
  
  @override
  Future<int> removerTudo() async{
    await _dao.removerTudo();
    return 1;
  }
}
