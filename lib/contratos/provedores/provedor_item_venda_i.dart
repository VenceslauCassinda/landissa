import '../../dominio/entidades/item_venda.dart';

abstract class ProvedorItemVendaI {
  Future<List<ItemVenda>> todos();
  Future<ItemVenda?> pegarItemVendaDeId(int id);
  Future<bool> actualizaItemVenda(ItemVenda dado);
  Future<int> registarItemVenda(ItemVenda dado);
  Future<int> removerItemVenda(ItemVenda dado);
}