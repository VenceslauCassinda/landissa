import 'package:yetu_gestor/dominio/entidades/usuario.dart';

abstract class ManipularUsuarioI {
  Future<List<Usuario>> todos();
  Future<List<Usuario>> pegarLista();
  Future<List<Usuario>> pegarListaEliminados();
  Future<int> registarUsuario(Usuario usuario);
  Future<bool> existeNomeUsuario(String nomeUsuario);
  Future<void> removerUsuario(Usuario usuario);
  Future<void> removerUsuarioDefinitivamente(Usuario usuario);
  Future<void> activarUsuario(Usuario usuario);
  Future<void> recuperarUsuario(Usuario usuario);
  Future<void> desactivarUsuario(Usuario usuario);
  Future<void> actualizarUsuario(Usuario usuario);
  Future<Usuario?> fazerLogin(String nomeUsuario, String palavraPasse);
  Future<void> terminarSessao(Usuario usuario);
}
