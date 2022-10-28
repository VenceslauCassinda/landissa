import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/provedores/provedor_item_venda_i.dart';
import 'package:yetu_gestor/dominio/entidades/item_venda.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';

class ProvedorItemVenda implements ProvedorItemVendaI {
  late ItemVendaDao _dao;
  ProvedorItemVenda() {
    _dao = ItemVendaDao(Get.find());
  }
  @override
  Future<bool> actualizaItemVenda(ItemVenda dado) async {
    var res = await _dao.actualizarItemVenda(dado);
    return res;
  }

  @override
  Future<ItemVenda?> pegarItemVendaDeId(int id) async {
    var res = await _dao.pegarItemVendaDeId(id);
    if (res != null) {
      return ItemVenda(
          estado: res.estado,
          idProduto: res.idProduto,
          idVenda: res.idVenda,
          quantidade: res.quantidade,
          total: res.total,
          desconto: res.desconto);
    }
    return null;
  }

  @override
  Future<int> registarItemVenda(ItemVenda dado) async {
    var res = await _dao.adicionarItemVenda(dado);
    return res;
  }

  @override
  Future<int> removerItemVenda(ItemVenda dado) async {
    return await _dao.removerItemVenda(dado.id!);
  }

  @override
  Future<List<ItemVenda>> todos() async {
    var lista = await _dao.todos();

    return lista.map((cada) {
      mostrar(cada.total);
      return ItemVenda(
          estado: cada.estado,
          idProduto: cada.idProduto,
          idVenda: cada.idVenda,
          quantidade: cada.quantidade,
          total: cada.total,
          desconto: cada.desconto);
    }).toList();
  }
}
