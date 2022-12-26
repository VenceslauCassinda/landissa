import 'package:yetu_gestor/dominio/entidades/entrada.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';

abstract class ProvedorSaidaI {
  Future<int> registarSaida(Saida saida);
  Future<int> actualizarSaida(Saida saida);
  Future<List<Saida>> pegarLista();
  Future<List<Saida>> pegarListaDoProduto(int idProduto);
  Future<Saida?> pegarSaidaDeProdutoDeId(int id);
  Future<Saida?> pegarSaidaDeProdutoDeIdEmotivo(int id, String motivo);
  Future removerTudo();
  Future removerAntes(DateTime data);
}
