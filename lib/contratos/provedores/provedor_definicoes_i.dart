import '../../dominio/entidades/definicoes.dart';

abstract class ProvedorDefinicoesI {
  Future<Definicoes> pegarDefinicoesActuais();
  Future<void> actualizarDefinicoes(Definicoes dado);
}
