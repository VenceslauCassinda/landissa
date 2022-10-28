import 'package:yetu_gestor/dominio/entidades/receccao.dart';

import '../../dominio/entidades/funcionario.dart';
import '../../dominio/entidades/produto.dart';

abstract class ManipularRececcaoI {
  Future<int> receberProduto(
      Produto produto,
      int quantidadePorLotes,
      int quantidadeLotes,
      double precoLote,
      double custo,
      Funcionario funcionario,
      String motivo,
      bool pagavel);
  Future<List<Receccao>> pegarListaRececcoesFuncionario(
      Funcionario funcionario);
  Future<List<Receccao>> pegarListaRececcoesPagas(
      Funcionario funcionario, DateTime data);
  Future<List<Receccao>> todas();
  Future<List<Receccao>> pegarRececcoesDaData(DateTime data);
  Future<void> actualizaRececcao(Receccao receccao);
  Future<void> removerRececcao(Receccao receccao);
  Future<void> removerTudo();
  Future<void> removerAntes(DateTime data);
}
