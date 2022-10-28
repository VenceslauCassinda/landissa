import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/forma_pagamento.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'pagamento_final.dart';

class Pagamento {
  FormaPagamento? formaPagamento;
  PagamentoFinal? pagamentoFinal;
  int? id;
  String? idParaVista;
  int? idFormaPagamento;
  int? estado;
  int? idVenda;
  double? valor;

  Pagamento(
      {this.id,
      this.formaPagamento,
      this.pagamentoFinal,
      this.idParaVista,
      this.idFormaPagamento,
      required this.estado,
      this.idVenda,
      required this.valor});
  factory Pagamento.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pagamento(
      id: serializer.fromJson<int>(json['id']),
      idFormaPagamento: serializer.fromJson<int>(json['idFormaPagamento']),
      estado: serializer.fromJson<int>(json['estado']),
      idVenda: serializer.fromJson<int>(json['idVenda']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['id_forma_pagamento'] = Variable<int>(idFormaPagamento!);
    map['estado'] = Variable<int>(estado!);
    map['id_venda'] = Variable<int>(idVenda!);
    map['valor'] = Variable<double>(valor!);
    return map;
  }

  TabelaPagamentoCompanion toCompanion(bool nullToAbsent) {
    return TabelaPagamentoCompanion(
      idFormaPagamento: Value(idFormaPagamento!),
      estado: Value(estado!),
      idVenda: Value(idVenda!),
      valor: Value(valor!),
    );
  }

  factory Pagamento.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pagamento(
      id: serializer.fromJson<int>(json['id']),
      idFormaPagamento: serializer.fromJson<int>(json['idFormaPagamento']),
      estado: serializer.fromJson<int>(json['estado']),
      idVenda: serializer.fromJson<int>(json['idVenda']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'idFormaPagamento': serializer.toJson<int>(idFormaPagamento!),
      'estado': serializer.toJson<int>(estado!),
      'idVenda': serializer.toJson<int>(idVenda!),
      'valor': serializer.toJson<double>(valor!),
    };
  }

  Pagamento copyWith(
          {int? id,
          int? idFormaPagamento,
          int? estado,
          int? idVenda,
          double? valor}) =>
      Pagamento(
        id: id ?? this.id,
        idFormaPagamento: idFormaPagamento ?? this.idFormaPagamento,
        estado: estado ?? this.estado,
        idVenda: idVenda ?? this.idVenda,
        valor: valor ?? this.valor,
      );
  @override
  String toString() {
    return (StringBuffer('Pagamento(')
          ..write('id: $id, ')
          ..write('idFormaPagamento: $idFormaPagamento, ')
          ..write('estado: $estado, ')
          ..write('idVenda: $idVenda, ')
          ..write(
            'valor: $valor, ',
          )
          ..write('FORMA PAGAMENTO: {${formaPagamento?.toString()}}, ')
          ..write(')'))
        .toString();
  }
}
