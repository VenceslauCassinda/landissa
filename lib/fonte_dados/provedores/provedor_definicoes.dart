import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/provedores/provedor_definicoes_i.dart';
import 'package:yetu_gestor/dominio/entidades/definicoes.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';

class ProvedorDefinicoes implements ProvedorDefinicoesI {
  late DefinicoesDao _definicoesDao;
  ProvedorDefinicoes() {
    _definicoesDao = DefinicoesDao(Get.find());
  }
  @override
  Future<void> actualizarDefinicoes(Definicoes dado) async {
    await _definicoesDao.atualizarDefinicoes(dado);
  }

  @override
  Future<Definicoes> pegarDefinicoesActuais() async {
    return await _definicoesDao.pegarDefinicoes();
  }
}
