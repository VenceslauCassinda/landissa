import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class FormaPagamento{
  int? id;
  int? estado;
  int? tipo;
  String? descricao;
  FormaPagamento(
      {this.id,
      this.estado,
      this.tipo,
      this.descricao});
  factory FormaPagamento.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormaPagamento(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      tipo: serializer.fromJson<int>(json['tipo']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['tipo'] = Variable<int>(tipo!);
    map['descricao'] = Variable<String>(descricao!);
    return map;
  }

  TabelaFormaPagamentoCompanion toCompanion(bool nullToAbsent) {
    return TabelaFormaPagamentoCompanion(
      estado: Value(estado!),
      tipo: Value(tipo!),
      descricao: Value(descricao!),
    );
  }

  factory FormaPagamento.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormaPagamento(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      tipo: serializer.fromJson<int>(json['tipo']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'tipo': serializer.toJson<int>(tipo!),
      'descricao': serializer.toJson<String>(descricao!),
    };
  }

  FormaPagamento copyWith(
          {int? id, int? estado, int? tipo, String? descricao}) =>
      FormaPagamento(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        tipo: tipo ?? this.tipo,
        descricao: descricao ?? this.descricao,
      );
  @override
  String toString() {
    return (StringBuffer('FormaPagamento(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('tipo: $tipo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, tipo, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormaPagamento &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.tipo == this.tipo &&
          other.descricao == this.descricao);
}