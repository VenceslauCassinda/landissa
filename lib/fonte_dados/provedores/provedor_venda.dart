import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/pagamento.dart';
import 'package:yetu_gestor/dominio/entidades/venda.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';

import '../../contratos/provedores/provedor_venda_i.dart';
import '../../dominio/entidades/funcionario.dart';

class ProvedorVenda implements ProvedorVendaI {
  late VendaDao _dao;
  ProvedorVenda() {
    _dao = VendaDao(Get.find());
  }

  @override
  Future<bool> actualizarVenda(Venda venda) async {
    return await _dao.actualizarVenda(venda);
  }

  @override
  Future<int> adicionarVenda(Venda venda) async {
    return await _dao.adicionarVenda(venda);
  }

  @override
  Future<List<Venda>> pegarLista(
      Funcionario? funcionario, DateTime data) async {
    if (funcionario == null) {
      return await _dao.pegarVendasNaData(data);
    }
    return await _dao.pegarVendasDeFuncionarioNaDataModoSimples(
        funcionario, data);
  }

  @override
  Future<int> removerVendaDeId(int id) async {
    return await _dao.removerVendaDeId(id);
  }

  @override
  Future<Venda?> pegarVendaDeId(int id) async {
    var res = await _dao.pegarVendaDeId(id);
    if (res != null) {
      return Venda(
          estado: res.estado,
          idProduto: res.idProduto,
          quantidadeVendida: res.quantidadeVendida,
          idFuncionario: res.idFuncionario,
          idCliente: res.idCliente,
          data: res.data,
          total: res.total,
          parcela: res.parcela);
    }
    return null;
  }

  @override
  Future<List<Venda>> pegarListaVendasFuncionario(
      Funcionario funcionario) async {
    return await _dao.pegarVendasDeFuncionario(funcionario);
  }

  @override
  Future<List<Venda>> pegarListaTodasDividas(Funcionario funcionario) async {
    return await _dao.pegarDividasDeFuncionario(funcionario);
  }

  @override
  Future<List<Venda>> pegarListaTodasEncomendas(Funcionario funcionario) async {
    return await _dao.pegarEncomendasDeFuncionario(funcionario);
  }

  @override
  Future<List<Pagamento>> pegarListaTodasPagamentoDividas(DateTime data) async {
    return await _dao.pegarListaPagamentoDaData(data);
  }

  @override
  Future<List<Venda>> todasDividas() async {
    return await _dao.todasDividas();
  }

  @override
  Future<List<Venda>> todas() async {
    return await _dao.todas();
  }

  @override
  Future<List<Venda>> pegarListaVendas() async {
    return await _dao.pegarVendasComDatasUnicas();
  }

  @override
  Future<List<Pagamento>> pegarListaTodasPagamentoDividasFuncionario(
      Funcionario funcionario, DateTime data) async {
    return await _dao.pegarListaPagamentoDaDataFuncionario(funcionario, data);
  }

  @override
  Future<List<Venda>> pegarListaTodasVendas() async {
    return await _dao.pegarTodasVendasModoSimples();
  }

  @override
  Future<int> removerTodas() async {
    return await _dao.removerTodas();
  }
}
