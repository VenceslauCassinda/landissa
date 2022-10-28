import 'package:yetu_gestor/dominio/entidades/cliente.dart';

abstract class ManipularClienteI {
  Future<List<Cliente>> todos();
  Future<Cliente?> pegarClienteDeId(int id);
  Future<bool> actualizaCliente(Cliente dado);
  Future<int> registarCliente(Cliente dado);
  Future<int> existeCliente(String nome, String numero);
  Future<void> removerCliente(Cliente dado);

  Future<void> removerTudo();

  removerAntes(DateTime dataSelecionada) {}
}
