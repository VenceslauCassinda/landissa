import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/fonte_dados/serializadores/serializador_usuario.dart';

import '../../contratos/casos_uso/manipular_usuario_i.dart';
import '../../contratos/provedores/provedor_usuario_i.dart';
import '../entidades/usuario.dart';

class ManipularUsuario implements ManipularUsuarioI {
  late final ProvedorUsuarioI _provedorUsuario;
  ManipularUsuario(this._provedorUsuario);
  @override
  Future<void> actualizarUsuario(Usuario usuario) async {
    await _provedorUsuario.actualizarUsuario(usuario);
  }

  @override
  Future<int> registarUsuario(Usuario usuario) async {
    usuario.estado = Estado.ATIVADO;
    return await _provedorUsuario.adicionarUsuario(usuario);
  }

  @override
  Future<List<Usuario>> pegarLista() async {
    return await _provedorUsuario.pegarLista();
  }

  @override
  Future<void> removerUsuario(Usuario usuario) async {
    usuario.estado = Estado.ELIMINADO;
    await _provedorUsuario.actualizarUsuario(usuario);
  }

  @override
  Future<Usuario?> fazerLogin(String nomeUsuario, String palavraPasse) async {
    return await _provedorUsuario.fazerLogin(nomeUsuario, palavraPasse);
  }

  @override
  Future<void> terminarSessao(Usuario usuario) async {
    await _provedorUsuario.terminarSessao(usuario);
  }

  @override
  Future<void> activarUsuario(Usuario usuario) async {
    usuario.estado = Estado.ATIVADO;
    await _provedorUsuario.actualizarUsuario(usuario);
  }

  @override
  Future<void> desactivarUsuario(Usuario usuario) async {
    usuario.estado = Estado.DESACTIVADO;
    await _provedorUsuario.actualizarUsuario(usuario);
  }

  @override
  Future<List<Usuario>> pegarListaEliminados() async {
    return await _provedorUsuario.pegarListaEliminados();
  }

  @override
  Future<void> recuperarUsuario(Usuario usuario) async {
    usuario.estado = Estado.ATIVADO;
    await _provedorUsuario.actualizarUsuario(usuario);
  }

  @override
  Future<bool> existeNomeUsuario(String nomeUsuario) async {
    return await _provedorUsuario.existeUsuarioComNomeUsuario(nomeUsuario);
  }

  @override
  Future<List<Usuario>> todos() async {
    return (await _provedorUsuario.todos())
        .map((e) => SerializadorUsuario().fromTabela(e))
        .toList();
  }

  @override
  Future<void> removerUsuarioDefinitivamente(Usuario usuario) async {
    await _provedorUsuario.removerUsuario(usuario);
  }
}
