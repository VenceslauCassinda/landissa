import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/dominio/entidades/usuario.dart';
import '../padrao_dao/base_dados.dart';

class SerializadorUsuario {
  Map toJson(Usuario model) {
    return {
      "id": model.id,
      "nome_usuario": model.nomeUsuario,
      "logado": model.logado,
      "nivel_acesso": model.nivelAcesso,
      "palavra_passe": model.palavraPasse,
      "imagem_perfil": model.imagemPerfil,
    };
  }

  Usuario fromJson(Map json) {
    return Usuario(
      id: json["id"],
      nomeUsuario: json["id"],
      estado: json["estado"],
      logado: json["logado"],
      nivelAcesso: json["nivel_acesso"],
      palavraPasse: json["palavra_passe"],
      imagemPerfil: json["imagem_perfil"],
    );
  }

  Usuario fromTabela(TabelaUsuarioData tabela) {
    return Usuario(
      id: tabela.id,
      nomeUsuario: tabela.nomeUsuario,
      nivelAcesso: tabela.nivelAcesso,
      estado: tabela.estado ?? 0,
      logado: tabela.logado ?? false,
      palavraPasse: tabela.palavraPasse,
      imagemPerfil: tabela.imagemPerfil,
    );
  }

  TabelaUsuarioData toTabela(Usuario model) {
    return TabelaUsuarioData(
      id: model.id ?? -1,
      nomeUsuario: model.nomeUsuario!,
      logado: model.logado ?? false,
      estado: model.estado ?? Estado.ELIMINADO,
      nivelAcesso: model.nivelAcesso ?? NivelAcesso.FUNCIONARIO,
      palavraPasse: model.palavraPasse!,
      imagemPerfil: model.imagemPerfil!,
    );
  }

  TabelaUsuarioCompanion toCompanion(Usuario model) {
    return TabelaUsuarioCompanion.insert(
      nomeUsuario: model.nomeUsuario!,
      logado: Value(model.logado ?? false),
      estado: Value(model.estado ?? Estado.ELIMINADO),
      nivelAcesso: model.nivelAcesso ?? NivelAcesso.FUNCIONARIO,
      palavraPasse: model.palavraPasse!,
      imagemPerfil: model.imagemPerfil ?? "",
    );
  }
}
