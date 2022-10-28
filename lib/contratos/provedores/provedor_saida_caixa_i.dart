import '../../dominio/entidades/saida_caixa.dart';

abstract class ProvedorSaidaCaixaI {
  Future<int> adicionarSaidaCaixa(SaidaCaixa saidaCaixa);
  Future<bool> actualizarSaidaCaixa(SaidaCaixa saidaCaixa);
  Future<int> removerSaidaCaixaDeId(int id);
  Future<List<SaidaCaixa>> pegarLista();
  Future<void> removerTudo();
  Future<void> removerAntesDe(DateTime data);
}
