import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'produto.dart';

class ItemVenda {
  Produto? produto;
  int? id;
  int? estado;
  int? idProduto;
  int? idVenda;
  String? idVista;
  int? quantidade;
  double? total;
  int? desconto;
  ItemVenda(
      {this.id,
      required this.estado,
      required this.idProduto,
      this.idVenda,
      this.idVista,
      required this.quantidade,
      this.total,
      this.produto,
      required this.desconto});
  factory ItemVenda.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemVenda(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idVenda: serializer.fromJson<int>(json['idVenda']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      total: serializer.fromJson<double>(json['total']),
      desconto: serializer.fromJson<int>(json['desconto']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['id_produto'] = Variable<int>(idProduto!);
    map['id_venda'] = Variable<int>(idVenda!);
    map['quantidade'] = Variable<int>(quantidade!);
    map['total'] = Variable<double>(total!);
    map['desconto'] = Variable<int>(desconto!);
    return map;
  }

  TabelaItemVendaCompanion toCompanion(bool nullToAbsent) {
    return TabelaItemVendaCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado!),
      idProduto: Value(idProduto!),
      idVenda: Value(idVenda!),
      quantidade: Value(quantidade ?? 0),
      total: Value(total ?? 0),
      desconto: Value(desconto ?? 0),
    );
  }

  factory ItemVenda.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemVenda(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idVenda: serializer.fromJson<int>(json['idVenda']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      total: serializer.fromJson<double>(json['total']),
      desconto: serializer.fromJson<int>(json['desconto']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idProduto': serializer.toJson<int>(idProduto!),
      'idVenda': serializer.toJson<int>(idVenda!),
      'quantidade': serializer.toJson<int>(quantidade!),
      'total': serializer.toJson<double>(total!),
      'desconto': serializer.toJson<int>(desconto!),
    };
  }

  ItemVenda copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          int? idVenda,
          int? quantidade,
          double? total,
          int? desconto}) =>
      ItemVenda(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        idVenda: idVenda ?? this.idVenda,
        quantidade: quantidade ?? this.quantidade,
        total: total ?? this.total,
        desconto: desconto ?? this.desconto,
      );
  @override
  String toString() {
    return (StringBuffer('ItemVenda(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idVenda: $idVenda, ')
          ..write('quantidade: $quantidade, ')
          ..write('total: $total, ')
          ..write('desconto: $desconto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, estado, idProduto, idVenda, quantidade, total, desconto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemVenda &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.idVenda == this.idVenda &&
          other.quantidade == this.quantidade &&
          other.total == this.total &&
          other.desconto == this.desconto);
}
