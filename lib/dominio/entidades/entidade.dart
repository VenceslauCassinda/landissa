import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class Entidade {
  int? id;
  int? estado;
  String? nome;
  String? endereco;
  String? nif;
  String? telefone;
  Entidade(
      {this.id,
      this.estado,
      this.nome,
      this.endereco,
      this.nif,
      this.telefone});
  factory Entidade.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entidade(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      endereco: serializer.fromJson<String>(json['endereco']),
      nif: serializer.fromJson<String>(json['nif']),
      telefone: serializer.fromJson<String>(json['telefone']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['nome'] = Variable<String>(nome!);
    map['endereco'] = Variable<String>(endereco!);
    map['nif'] = Variable<String>(nif!);
    map['telefone'] = Variable<String>(telefone!);
    return map;
  }

  TabelaEntidadeCompanion toCompanion(bool nullToAbsent) {
    return TabelaEntidadeCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado!),
      nome: Value(nome ?? ""),
      endereco: Value(endereco ?? ""),
      nif: Value(nif ?? ""),
      telefone: Value(telefone ?? ""),
    );
  }

  factory Entidade.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entidade(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      endereco: serializer.fromJson<String>(json['endereco']),
      nif: serializer.fromJson<String>(json['nif']),
      telefone: serializer.fromJson<String>(json['telefone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'nome': serializer.toJson<String>(nome!),
      'endereco': serializer.toJson<String>(endereco!),
      'nif': serializer.toJson<String>(nif!),
      'telefone': serializer.toJson<String>(telefone!),
    };
  }

  Entidade copyWith(
          {int? id,
          int? estado,
          String? nome,
          String? endereco,
          String? nif,
          String? telefone}) =>
      Entidade(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        nome: nome ?? this.nome,
        endereco: endereco ?? this.endereco,
        nif: nif ?? this.nif,
        telefone: telefone ?? this.telefone,
      );
  @override
  String toString() {
    return (StringBuffer('Entidade(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('endereco: $endereco, ')
          ..write('nif: $nif, ')
          ..write('telefone: $telefone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, nome, endereco, nif, telefone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entidade &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.nome == this.nome &&
          other.endereco == this.endereco &&
          other.nif == this.nif &&
          other.telefone == this.telefone);
}
