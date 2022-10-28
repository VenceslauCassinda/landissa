import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/dominio/entidades/usuario.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';

import '../configuracao/test_config.dart';

void main() {
  TestConfig.prepareInitDataBase();
  Get.put(BancoDados());
  ManipularUsuario manipularUsuario = ManipularUsuario(ProvedorUsuario());

  test("LISTAR USUARIOS", () async {
    var lista = await manipularUsuario.todos();
    for (var cada in lista) {
      print(cada.nomeUsuario.toString());
      print(cada.nivelAcesso.toString());
    }
  });
  test("REGISTAR USUARIO", () async {
    Usuario usuario = Usuario(
        nomeUsuario: "admin",
        imagemPerfil: "imagemPerfil",
        palavraPasse: "11111111",
        nivelAcesso: NivelAcesso.ADMINISTRADOR);
    try {
      await manipularUsuario.registarUsuario(usuario);
      var lista = (await manipularUsuario.pegarLista());
      expect(usuario.nomeUsuario, lista.last.nomeUsuario);
      expect(1, lista.last.estado);
    } catch (e) {
      expect(e, isA<ErroUsuarioJaExiste>());
    }
  });

  test("FAZER LOGIN", () async {
    // var lista = (await manipularUsuario.pegarLista());
    // if (lista.isNotEmpty) {
    // var usuario = lista.last;

    var usuario = Usuario.registo("Loja", "11111111", NivelAcesso.GERENTE);

    try {
      var usuarioLogado = await manipularUsuario.fazerLogin(
          usuario.nomeUsuario!, usuario.palavraPasse!);
      expect(usuarioLogado != null, true);
      expect(usuarioLogado!.logado, true);
      expect(usuarioLogado.nomeUsuario, usuario.nomeUsuario);
    } catch (e) {
      expect(true, e is ErroUsuarioJaLogado || e is ErroUsuarioNaoExiste);
    }
    // }
  });

  test("TERMINAR SESSAO", () async {
    // var lista = (await manipularUsuario.pegarLista());
    // if (lista.isNotEmpty) {
    // var usuario = lista[lista.length - 1];
    var usuario = Usuario.registo("admin", "11111111", NivelAcesso.ADMINISTRADOR);
    try {
      await manipularUsuario.terminarSessao(usuario);
    } catch (e) {
      expect(e, isA<ErroUsuarioNaoLogado>());
    }
    // }
  });

  test("ACTIVAR USUARIO", () async {
    var lista = (await manipularUsuario.pegarLista());
    if (lista.isNotEmpty) {
      var usuario = lista
          .firstWhereOrNull((element) => element.estado == Estado.DESACTIVADO);
      if (usuario != null) {
        await manipularUsuario.activarUsuario(usuario);
        usuario = (await manipularUsuario.pegarLista()).firstWhere(
            (element) => element.nomeUsuario == usuario!.nomeUsuario);
        expect(usuario.estado, 1);
      }
    }
  });

  test("DESACTIVAR USUARIO", () async {
    var lista = (await manipularUsuario.pegarLista());
    if (lista.isNotEmpty) {
      var usuario =
          lista.firstWhereOrNull((element) => element.estado == Estado.ATIVADO);
      if (usuario != null) {
        await manipularUsuario.desactivarUsuario(usuario);
        usuario = (await manipularUsuario.pegarLista()).firstWhere(
            (element) => element.nomeUsuario == usuario!.nomeUsuario);
        expect(usuario.estado, 0);
      }
    }
  });

  test("ELIMINAR USUARIO", () async {
    var lista = (await manipularUsuario.pegarLista());
    if (lista.isNotEmpty) {
      var usuario = lista.first;
      await manipularUsuario.removerUsuario(usuario);
      var eliminados = (await manipularUsuario.pegarListaEliminados());
      var eliminado = eliminados
          .firstWhere((element) => element.nomeUsuario == usuario.nomeUsuario);
      expect(eliminado.estado, -1);
      expect(true, (await manipularUsuario.pegarLista()).length < lista.length);
    }
  });

  test("ACTUALIZAR USUARIO", () async {
    var lista = (await manipularUsuario.pegarLista());
    if (lista.isNotEmpty) {
      var usuario = lista.first;
      usuario.imagemPerfil = "CC";
      await manipularUsuario.actualizarUsuario(usuario);
      var actualizados = (await manipularUsuario.pegarLista());
      var actualizado =
          actualizados.firstWhere((element) => element.id == usuario.id);
      expect(actualizado.imagemPerfil, "CC");
    }
  });
}
