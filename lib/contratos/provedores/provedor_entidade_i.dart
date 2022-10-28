import '../../dominio/entidades/entidade.dart';

abstract class ProvedorEntidadeI {
  Future<List<Entidade>> todos();
  Future<Entidade?> pegarEntidadeDeId(int id);
  Future<bool> actualizaEntidade(Entidade dado);
  Future<int> registarEntidade(Entidade dado);
  Future<int> existeEntidade(String nome, String numero);
  Future<void> removerEntidade(Entidade dado);
}
