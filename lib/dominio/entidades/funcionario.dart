// ignore_for_file: overridden_fields

import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/usuario.dart';

class Funcionario {
  String? nomeCompelto;
  int? id;
  int? idUsuario;
  String? nomeUsuario;
  String? imagemPerfil;
  String? palavraPasse;
  int? nivelAcesso;
  int? estado;
  bool? logado;

  Funcionario(
      {this.nomeCompelto,
      this.id,
      this.estado,
      this.logado,
      this.idUsuario,
      this.nomeUsuario,
      this.imagemPerfil,
      this.palavraPasse,
      this.nivelAcesso})
      ;

  @override
  String toString() {
    return (StringBuffer('TabelaFuncionarioCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idUsuario: $idUsuario, ')
          ..write(
            'logado: $logado, ',
          )
          ..write(
            'nivelAcesso: $nivelAcesso, ',
          )
          ..write(
            'palavraPasse: $palavraPasse, ',
          )
          ..write(
            'imagemPerfil: $imagemPerfil, ',
          )
          ..write(
            'nomeCompleto: $nomeCompelto, ',
          )
          ..write(')'))
        .toString();
  }
}
