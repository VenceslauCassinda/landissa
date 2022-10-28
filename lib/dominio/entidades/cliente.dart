import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class Cliente {
  int? id;
  int? estado;
  String? nome;
  String? numero;
  Cliente(
      {this.id,
      required this.estado,
      required this.nome,
      required this.numero});
  factory Cliente.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      numero: serializer.fromJson<String>(json['numero']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['nome'] = Variable<String>(nome!);
    map['numero'] = Variable<String>(numero!);
    return map;
  }

  TabelaClienteCompanion toCompanion(bool nullToAbsent) {
    return TabelaClienteCompanion(
      estado: Value(estado!),
      nome: Value(nome!),
      numero: Value(numero!),
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      numero: serializer.fromJson<String>(json['numero']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'nome': serializer.toJson<String>(nome!),
      'numero': serializer.toJson<String>(numero!),
    };
  }

  Cliente copyWith({int? id, int? estado, String? nome, String? numero}) =>
      Cliente(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        nome: nome ?? this.nome,
        numero: numero ?? this.numero,
      );
  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('numero: $numero')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, nome, numero);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.nome == this.nome &&
          other.numero == this.numero);
}
