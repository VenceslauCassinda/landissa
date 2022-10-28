import 'package:yetu_gestor/dominio/entidades/funcionario.dart';

import '../../dominio/entidades/pagamento.dart';
import '../../dominio/entidades/venda.dart';

abstract class ProvedorVendaI {
  Future<List<Venda>> pegarLista(Funcionario? funcionario, DateTime data);
  Future<List<Venda>> pegarListaTodasDividas(Funcionario funcionario);
  Future<List<Venda>> pegarListaTodasEncomendas(Funcionario funcionario);
  Future<List<Pagamento>> pegarListaTodasPagamentoDividas(DateTime data);
  Future<List<Pagamento>> pegarListaTodasPagamentoDividasFuncionario(
      Funcionario funcionario, DateTime data);
  Future<int> adicionarVenda(Venda venda);
  Future<int> removerVendaDeId(int id);
  Future<int> removerTodas();
  Future<Venda?> pegarVendaDeId(int id);
  Future<bool> actualizarVenda(Venda venda);
  Future<List<Venda>> pegarListaVendasFuncionario(Funcionario funcionario);
  Future<List<Venda>> pegarListaVendas();
  Future<List<Venda>> todasDividas();
  Future<List<Venda>> todas();
  Future<List<Venda>> pegarListaTodasVendas();
}
