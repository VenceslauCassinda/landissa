import 'dart:math';

import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/dominio/entidades/usuario.dart';

import '../../contratos/casos_uso/manipular_funcionario_i.dart';
import '../../contratos/casos_uso/manipular_usuario_i.dart';
import '../../contratos/provedores/provedor_funcionario_i.dart';
import '../../fonte_dados/erros.dart';

class ManipularFuncionario implements ManipularFuncionarioI {
  final ManipularUsuarioI _manipularUsuarioI;
  final ProvedorFuncionarioI _provedorFuncionarioI;

  ManipularFuncionario(this._manipularUsuarioI, this._provedorFuncionarioI);
  @override
  Future<void> actualizarFuncionario(Funcionario dado) async {
    await _provedorFuncionarioI.actualizarFuncionario(dado);
  }

  @override
  Future<Usuario> adicionarFuncionario(Funcionario dado) async {
    String nomeUsuario;
    if (dado.nomeCompelto!.contains(" ")) {
      nomeUsuario = dado.nomeCompelto!.split(" ")[0];
    } else {
      nomeUsuario = dado.nomeCompelto!;
    }
    nomeUsuario = nomeUsuario.toLowerCase();
    if ((await _manipularUsuarioI.existeNomeUsuario(nomeUsuario)) == true) {
      String acrescimoId =
          "${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}";
      nomeUsuario = "${nomeUsuario.toLowerCase()}$acrescimoId";
    }
    dado.nomeUsuario = nomeUsuario;
    if ((await _provedorFuncionarioI
            .existeFuncionarioComNomeUsuario(dado.nomeCompelto!)) ==
        true) {
      throw ErroFuncionarioJaExiste("FUNCIONARIO JA EXISTENTE!");
    }
    var novoUsuario = Usuario.registo(nomeUsuario, dado.palavraPasse);
    var id = await _manipularUsuarioI.registarUsuario(novoUsuario);
    dado.idUsuario = id;
    await _provedorFuncionarioI.adicionarFuncionario(dado);
    novoUsuario.palavraPasse = "";
    if (nomeUsuario == "admin") {
      novoUsuario.nivelAcesso = NivelAcesso.ADMINISTRADOR;
    }
    return novoUsuario;
  }

  @override
  Future<List<Funcionario>> pegarLista() async {
    return (await _provedorFuncionarioI.pegarLista());
  }

  @override
  Future<List<Funcionario>> pegarListaEliminados() async {
    return (await _provedorFuncionarioI.pegarListaEliminados());
  }

  @override
  Future<void> removerFuncionario(Funcionario dado) async {
    await _provedorFuncionarioI.removerFuncionario(dado);
  }

  @override
  Future<void> activarFuncionario(Funcionario dado) async {
    await _provedorFuncionarioI.activarFuncionario(dado);
  }

  @override
  Future<void> desactivarFuncionario(Funcionario dado) async {
    await _provedorFuncionarioI.desactivarFuncionario(dado);
  }

  @override
  Future<void> recuperarFuncionario(Funcionario dado) async {
    await _provedorFuncionarioI.recuperarFuncionario(dado);
  }

  @override
  Future<List<Funcionario>> todos() async {
    return (await _provedorFuncionarioI.todos());
  }

  @override
  Future<int> pegarIdFuncionarioDeNome(String nomeCompleto) async {
    return await _provedorFuncionarioI.pegarIdFuncionarioDeNome(nomeCompleto);
  }

  @override
  Future<Funcionario> pegarFuncionarioDeId(int id) async {
    return await _provedorFuncionarioI.pegarFuncionarioDeId(id);
  }

  @override
  Future<Funcionario> pegarFuncionarioDeNome(String nomeCompleto) async {
    return await _provedorFuncionarioI.pegarFuncionarioDeNome(nomeCompleto);
  }

  @override
  Future<Funcionario> pegarFuncionarioDoUsuarioDeId(int id) async {
    return await _provedorFuncionarioI.pegarFuncionarioDoUsuarioDeId(id);
  }
}
