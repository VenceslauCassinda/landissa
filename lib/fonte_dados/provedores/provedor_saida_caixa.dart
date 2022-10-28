import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/saida_caixa.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';

import '../../contratos/provedores/provedor_saida_caixa_i.dart';

class ProvedorSaidaCaixa implements ProvedorSaidaCaixaI {
  late SaidaCaixaDao _saidaCaixaDao;
  ProvedorSaidaCaixa() {
    _saidaCaixaDao = SaidaCaixaDao(Get.find());
  }
  @override
  Future<bool> actualizarSaidaCaixa(SaidaCaixa saidaCaixa) async {
    return await _saidaCaixaDao.actualizar(saidaCaixa);
  }

  @override
  Future<int> adicionarSaidaCaixa(SaidaCaixa saidaCaixa) async {
    return await _saidaCaixaDao.adcionarSaidaCaixa(saidaCaixa);
  }

  @override
  Future<List<SaidaCaixa>> pegarLista() async {
    return await _saidaCaixaDao.todos();
  }

  @override
  Future<int> removerSaidaCaixaDeId(int id) async {
    return await _saidaCaixaDao.removerSaidaCaixaDeId(id);
  }

  @override
  Future<void> removerTudo() async {
    await _saidaCaixaDao.removerTudo();
  }

  @override
  @override
  Future<void> removerAntesDe(DateTime data) async {
    await _saidaCaixaDao.removerAntes(data);
  }
}
