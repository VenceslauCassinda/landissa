import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'funcionario.dart';

class DinheiroSobra {
  Funcionario? funcionario;
  int? id;
  int? estado;
  int? idFuncionario;
  double? valor;
  DateTime? data;
  DinheiroSobra(
      {this.id,
      required this.estado,
      required this.idFuncionario,
      this.funcionario,
      required this.valor,
      required this.data});
  factory DinheiroSobra.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DinheiroSobra(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      valor: serializer.fromJson<double>(json['valor']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['id_funcionario'] = Variable<int>(idFuncionario!);
    map['valor'] = Variable<double>(valor!);
    map['data'] = Variable<DateTime>(data!);
    return map;
  }

  TabelaDinheiroSobraCompanion toCompanion(bool nullToAbsent) {
    return TabelaDinheiroSobraCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado!),
      idFuncionario: Value(idFuncionario!),
      valor: Value(valor!),
      data: Value(data!),
    );
  }

  factory DinheiroSobra.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DinheiroSobra(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      valor: serializer.fromJson<double>(json['valor']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idFuncionario': serializer.toJson<int>(idFuncionario!),
      'valor': serializer.toJson<double>(valor!),
      'data': serializer.toJson<DateTime>(data!),
    };
  }

  DinheiroSobra copyWith(
          {int? id,
          int? estado,
          int? idFuncionario,
          double? valor,
          DateTime? data}) =>
      DinheiroSobra(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        valor: valor ?? this.valor,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('DinheiroSobra(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('valor: $valor, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idFuncionario, valor, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DinheiroSobra &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.valor == this.valor &&
          other.data == this.data);
}
