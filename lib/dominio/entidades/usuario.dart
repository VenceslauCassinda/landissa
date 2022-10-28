import 'package:drift/drift.dart';

class Usuario {
  int? id;
  String? nomeUsuario;
  String? imagemPerfil;
  String? palavraPasse;
  int? nivelAcesso;
  int? estado;
  bool? logado;

  Usuario.registo(this.nomeUsuario, this.palavraPasse, [this.nivelAcesso]);

  Usuario(
      {this.id,
      this.estado,
      this.logado,
      this.nomeUsuario,
      this.imagemPerfil,
      this.palavraPasse,
      this.nivelAcesso});
}
