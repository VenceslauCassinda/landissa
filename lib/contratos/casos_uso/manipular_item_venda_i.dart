import '../../dominio/entidades/item_venda.dart';

abstract class ManipularItemVendaI {
  Future<List<ItemVenda>> todos();
  Future<ItemVenda?> pegarItemVendaDeId(int id);
  Future<bool> actualizaItemVenda(ItemVenda dado);
  Future<int> registarItemVenda(ItemVenda dado);
  Future<List<ItemVenda>> calcularTotalPorItem(List<ItemVenda> itens);
  Future<double> calcularTotalApagar(List<ItemVenda> itens);
  double aplicarDescontoVenda(double totalApagar, int porcentagem);
  Future<int> removerItemVenda(ItemVenda dado);
}
