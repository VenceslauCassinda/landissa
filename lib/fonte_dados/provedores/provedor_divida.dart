import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/divida.dart';

import '../../contratos/provedores/provedor_dividas_i.dart';
import '../padrao_dao/base_dados.dart';

class ProvedorDivida implements ProvedorDividaI {
  late DividaDao _dao;
  ProvedorDivida() {
    _dao = DividaDao(Get.find());
  }
  @override
  Future<bool> actualizarDivida(Divida divida) async {
    return await _dao.actualizarDivida(divida);
  }

  @override
  Future<List<Divida>> pegarListaTodasDividas() async {
    return await _dao.pegarTodasDividasModoSimples();
  }

  @override
  Future<int> registarDivida(Divida divida) async {
    return await _dao.adicionarDivida(divida);
  }

  @override
  Future<bool> removerDivida(Divida divida) async {
    await _dao.removerDividaDeId(divida.id!);
    return false;
  }

  @override
  Future<bool> removerTodasDividas() async {
    await _dao.removerTodasDivida();
    return true;
  }
}
