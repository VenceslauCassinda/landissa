import '../../dominio/entidades/divida.dart';

abstract class ProvedorDividaI {
  Future<int> registarDivida(Divida divida);
  Future<List<Divida>> pegarListaTodasDividas();
  Future<bool> actualizarDivida(Divida divida);
  Future<bool> removerDivida(Divida divida);
  Future<bool> removerTodasDividas();
}
