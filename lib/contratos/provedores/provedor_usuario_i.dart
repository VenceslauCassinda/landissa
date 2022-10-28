import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';

import '../../dominio/entidades/usuario.dart';

abstract class ProvedorUsuarioI {
  Future<List<TabelaUsuarioData>> todos();
  Future<List<Usuario>> pegarLista();
  Future<List<Usuario>> pegarListaEliminados();
  Future<int> adicionarUsuario(Usuario usuario);
  Future<Usuario?> fazerLogin(String nomeUsuario, String palavraPasse);
  Future<void> terminarSessao(Usuario usuario);
  Future<bool> existeUsuarioComNomeUsuario(String nomeUsuario);
  Future<void> removerUsuario(Usuario usuario);
  Future<void> actualizarUsuario(Usuario usuario);
}
