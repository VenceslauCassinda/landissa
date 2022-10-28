import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/usuario.dart';
import '../padrao_dao/base_dados.dart';

class SerializadorFuncionario {
  Map toJson(Funcionario model) {
    return {
      "id": model.id,
      "nome_usuario": model.nomeUsuario,
      "nome_completo": model.nomeUsuario,
      "logado": model.logado,
      "nivel_acesso": model.nivelAcesso,
      "palavra_passe": model.palavraPasse,
      "imagem_perfil": model.imagemPerfil,
    };
  }

  Funcionario fromJson(Map json) {
    return Funcionario(
      nomeCompelto: json["nome_completo"],
      id: json["id"],
      nomeUsuario: json["id"],
      estado: json["estado"],
      logado: json["logado"],
      nivelAcesso: json["nivel_acesso"],
      palavraPasse: json["palavra_passe"],
      imagemPerfil: json["imagem_perfil"],
    );
  }

  Funcionario fromTabela(TabelaFuncionarioData tabela,
      {TabelaUsuarioData? usuario}) {
    return Funcionario(
      id: tabela.id,
      idUsuario: usuario?.id,
      imagemPerfil: usuario?.imagemPerfil,
      logado: usuario?.logado,
      nomeUsuario: usuario?.nomeUsuario,
      estado: usuario?.estado,
      nivelAcesso: usuario?.nivelAcesso,
      nomeCompelto: tabela.nomeCompleto,
    );
  }

  TabelaFuncionarioData toTabela(Funcionario model) {
    return TabelaFuncionarioData(
      idUsuario: model.idUsuario ?? -1,
      id: model.id ?? -1,
      nomeCompleto: model.nomeCompelto!,
      estado: model.estado!,
    );
  }

  TabelaFuncionarioCompanion toCompanion(Funcionario model) {
    return TabelaFuncionarioCompanion.insert(
      idUsuario: model.idUsuario ?? -1,
      nomeCompleto: model.nomeCompelto!,
      estado: model.estado ?? 0,
    );
  }
}
