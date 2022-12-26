import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/item_venda.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import '../../contratos/casos_uso/manipular_saida_i.dart';
import '../../contratos/casos_uso/manipular_stock_i.dart';
import '../../contratos/provedores/provedor_saida_i.dart';

class ManipularSaida implements ManipularSaidaI {
  final ProvedorSaidaI _provedorSaidaI;
  final ManipularStockI _manipularStockI;

  ManipularSaida(this._provedorSaidaI, this._manipularStockI);
  @override
  Future<List<Saida>> pegarLista() async {
    return await _provedorSaidaI.pegarLista();
  }

  @override
  Future<int> registarSaida(Saida saida) async {
    var res = await _provedorSaidaI.registarSaida(saida);
    await _manipularStockI.diminuirQuantidadeStock(
        saida.idProduto!, saida.quantidade!);
    return res;
  }

  @override
  Future<void> registarListaSaidas(
      List<ItemVenda> lista, int idVenda, DateTime data) async {
    for (var cada in lista) {
      await registarSaida(Saida(
          idProduto: cada.idProduto,
          idVenda: idVenda,
          quantidade: cada.quantidade,
          data: data,
          motivo: Saida.MOTIVO_VENDA,
          estado: Estado.ATIVADO));
    }
  }

  @override
  Future<List<Saida>> pegarListaDoProduto(Produto produto) async {
    List<Saida> lista = [];
    var res = await _provedorSaidaI.pegarLista();
    for (var cada in res) {
      if (cada.idProduto == produto.id) {
        lista.add(cada);
      }
    }
    return lista;
  }

  @override
  Future<Saida?> pegarSaidaDeProdutoDeId(int id) async {
    return await _provedorSaidaI.pegarSaidaDeProdutoDeId(id);
  }

  @override
  Future<int> actualizarSaida(Saida saida) async {
    await _provedorSaidaI.actualizarSaida(saida);
    return 1;
  }

  @override
  Future removerAntes(DateTime data) async {
    await _provedorSaidaI.removerAntes(data);
  }

  @override
  Future removerTudo() async {
    await _provedorSaidaI.removerTudo();
  }

  @override
  Future<Saida?> pegarSaidaDeProdutoDeIdEmotivo(int id, String motivo) async {
    return await _provedorSaidaI.pegarSaidaDeProdutoDeIdEmotivo(id, motivo);
  }
}
