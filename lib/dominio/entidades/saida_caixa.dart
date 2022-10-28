import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class SaidaCaixa {
  int? id;
  int? estado;
  int? idFuncionario;
  DateTime? data;
  String? motivo;
  double? valor;

  Funcionario? funcionario;
  SaidaCaixa({
    this.id,
    required this.estado,
    required this.idFuncionario,
    required this.data,
    required this.motivo,
    this.funcionario,
    required this.valor,
  });
  factory SaidaCaixa.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaidaCaixa(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String>(json['motivo']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['id_funcionario'] = Variable<int>(idFuncionario!);
    map['data'] = Variable<DateTime>(data!);
    map['motivo'] = Variable<String>(motivo!);
    map['valor'] = Variable<double>(valor!);
    return map;
  }

  TabelaSaidaCaixaCompanion toCompanion(bool nullToAbsent) {
    return TabelaSaidaCaixaCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      estado: Value(estado!),
      idFuncionario: Value(idFuncionario!),
      data: Value(data!),
      motivo: Value(motivo!),
      valor: Value(valor!),
    );
  }

  factory SaidaCaixa.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaidaCaixa(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String>(json['motivo']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idFuncionario': serializer.toJson<int>(idFuncionario!),
      'data': serializer.toJson<DateTime>(data!),
      'motivo': serializer.toJson<String>(motivo!),
      'valor': serializer.toJson<double>(valor!),
    };
  }

  SaidaCaixa copyWith(
          {int? id,
          int? estado,
          int? idFuncionario,
          DateTime? data,
          String? motivo,
          double? valor}) =>
      SaidaCaixa(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        data: data ?? this.data,
        motivo: motivo ?? this.motivo,
        valor: valor ?? this.valor,
      );
  @override
  String toString() {
    return (StringBuffer('SaidaCaixa(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, estado, idFuncionario, data, motivo, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaidaCaixa &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.data == this.data &&
          other.motivo == this.motivo &&
          other.valor == this.valor);
}
