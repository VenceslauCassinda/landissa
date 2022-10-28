import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class PagamentoFinal {
  int? id;
  int? estado;
  int? idPagamento;
  DateTime? data;
  PagamentoFinal(
      {this.id,
      required this.estado,
      required this.idPagamento,
      required this.data});
  factory PagamentoFinal.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PagamentoFinal(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idPagamento: serializer.fromJson<int>(json['idPagamento']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['id_pagamento'] = Variable<int>(idPagamento!);
    map['data'] = Variable<DateTime>(data!);
    return map;
  }

  TabelaPagamentoFinalCompanion toCompanion(bool nullToAbsent) {
    return TabelaPagamentoFinalCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado!),
      idPagamento: Value(idPagamento!),
      data: Value(data!),
    );
  }

  factory PagamentoFinal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PagamentoFinal(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idPagamento: serializer.fromJson<int>(json['idPagamento']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idPagamento': serializer.toJson<int>(idPagamento!),
      'data': serializer.toJson<DateTime>(data!),
    };
  }

  PagamentoFinal copyWith(
          {int? id, int? estado, int? idPagamento, DateTime? data}) =>
      PagamentoFinal(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idPagamento: idPagamento ?? this.idPagamento,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('PagamentoFinal(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idPagamento: $idPagamento, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idPagamento, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PagamentoFinal &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idPagamento == this.idPagamento &&
          other.data == this.data);
}
