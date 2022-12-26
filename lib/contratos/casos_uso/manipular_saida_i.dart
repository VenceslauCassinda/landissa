import 'package:yetu_gestor/dominio/entidades/item_venda.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';

abstract class ManipularSaidaI {
  Future<int> registarSaida(Saida saida);
  Future<int> actualizarSaida(Saida saida);
  Future<void> registarListaSaidas(
      List<ItemVenda> lista, int idVenda, DateTime data);
  Future<List<Saida>> pegarLista();
  Future<Saida?> pegarSaidaDeProdutoDeId(int id);
  Future<Saida?> pegarSaidaDeProdutoDeIdEmotivo(int id, String motivo);
  Future<List<Saida>> pegarListaDoProduto(Produto produto);
  Future removerTudo();
  Future removerAntes(DateTime data);
}
