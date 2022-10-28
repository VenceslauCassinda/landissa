import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/pagamento.dart';
import 'package:yetu_gestor/dominio/entidades/venda.dart';

import '../../dominio/entidades/funcionario.dart';
import '../../dominio/entidades/item_venda.dart';

abstract class ManipularVendaI {
  Future<int> registarVenda(
      double total,
      double parcela,
      Funcionario funcionario,
      Cliente cliente,
      DateTime data,
      DateTime dataLevantamentoCompra,
      int idProduto,
      int quantidadeVendida);
  Future<int> vender(
      List<ItemVenda> itensVenda,
      List<Pagamento> pagamentos,
      double total,
      Funcionario funcionario,
      Cliente cliente,
      DateTime data,
      DateTime dataLevantamentoCompra,
      double parcela,
      int idProduto,
      int quantidadeVendida);
  double calcularTotalVenda(List<ItemVenda> itensVenda);
  List<Pagamento> associarPagamentosAvenda(
      List<Pagamento> pagamentos, int idVenda);
  double calcularParcelaApagar(double totalApagar, double parcelaJaPaga);
  double calcularParcelaPaga(List<Pagamento> pagamentos);
  double aplicarDescontoVenda(double totalApagar, int porcentagem);
  Future<List<Venda>> pegarLista(Funcionario? funcionario, DateTime data);
  Future<List<Venda>> todasDividas();
  Future<List<Venda>> pegarListaTodasDividas(Funcionario? funcionario);
  Future<List<Pagamento>> pegarListaTodasPagamentoDividas(DateTime data);
  Future<List<Pagamento>> pegarListaTodasPagamentoDividasFuncionario(
      Funcionario funcionario, DateTime data);
  Future<List<Venda>> pegarListaTodasEncomendas(Funcionario? funcionario);
  Future<List<Venda>> pegarListaVendas(Funcionario? funcionario, DateTime data);
  Future<List<Venda>> pegarListaEncomendas(
      Funcionario? funcionario, DateTime data);
  Future<List<Venda>> pegarListaDividas(
      Funcionario? funcionario, DateTime data);
  Future<void> entregarEncomenda(Venda venda);
  bool vendaEstaPaga(Venda venda);
  bool vendaOuEncomenda(Venda venda);
  bool vendaOuDivida(Venda venda);
  Future<ItemVenda?> pegarItemComStockInsuficiente(List<ItemVenda> lista);
  Future<bool> actualizarVenda(Venda venda, bool fazerOuDesfazer);
  Future<bool> removerVenda(Venda venda);
  Future<bool> removerTodasVendas();
  Future<bool> removerVendasAntesData(DateTime data);

  Future<List<DateTime>> pegarListaDataVendasFuncionario(
      Funcionario funcionario);

  Future<List<DateTime>> pegarListaDataVendas();
  Future<List<Venda>> pegarListaTodasVendas();
}
