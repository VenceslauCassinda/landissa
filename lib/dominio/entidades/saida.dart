import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'produto.dart';

class Saida {
  Produto? produto;
  int? id;
  int? estado;
  int? idProduto;
  int? idVenda;
  int? idDivida;
  int? quantidade;
  DateTime? data;
  String? motivo;
  Saida(
      {this.id,
      this.produto,
      required this.estado,
      required this.idProduto,
      this.idVenda,
      this.idDivida,
      required this.quantidade,
      required this.data,
      this.motivo});
  static String MOTIVO_VENDA = "Venda";
  static String MOTIVO_DIVIDA = "Dívida";
  static String MOTIVO_DESPERDICIO = "Desperdício";
  static String MOTIVO_AJUSTE_STOCK = "Ajuste de Stock";
  static String MOTIVO_INVENTARIO = "Inventário";
  factory Saida.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Saida(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idVenda: serializer.fromJson<int?>(json['idVenda']),
      idDivida: serializer.fromJson<int?>(json['idDivida']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String?>(json['motivo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['id_produto'] = Variable<int>(idProduto!);
    if (!nullToAbsent || idVenda != null) {
      map['id_venda'] = idVenda as Expression<int>;
    }
    if (!nullToAbsent || idDivida != null) {
      map['id_divida'] = idDivida as Expression<int>;
    }
    map['quantidade'] = Variable<int>(quantidade!);
    map['data'] = Variable<DateTime>(data!);
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = motivo as Expression<String>;
    }
    return map;
  }

  TabelaSaidaCompanion toCompanion(bool nullToAbsent) {
    return TabelaSaidaCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado!),
      idProduto: Value(idProduto!),
      idVenda: idVenda == null && nullToAbsent
          ? const Value.absent()
          : Value(idVenda),
      idDivida: idDivida == null && nullToAbsent
          ? const Value.absent()
          : Value(idDivida),
      quantidade: Value(quantidade ?? 0),
      data: Value(data!),
      motivo:
          motivo == null && nullToAbsent ? const Value.absent() : Value(motivo),
    );
  }

  factory Saida.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Saida(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idVenda: serializer.fromJson<int?>(json['idVenda']),
      idDivida: serializer.fromJson<int?>(json['idDivida']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String?>(json['motivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idProduto': serializer.toJson<int>(idProduto!),
      'idVenda': serializer.toJson<int?>(idVenda),
      'idDivida': serializer.toJson<int?>(idDivida),
      'quantidade': serializer.toJson<int>(quantidade!),
      'data': serializer.toJson<DateTime>(data!),
      'motivo': serializer.toJson<String?>(motivo),
    };
  }

  Saida copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          int? idVenda,
          int? idDivida,
          int? quantidade,
          DateTime? data,
          String? motivo}) =>
      Saida(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        idVenda: idVenda ?? this.idVenda,
        idDivida: idDivida ?? this.idDivida,
        quantidade: quantidade ?? this.quantidade,
        data: data ?? this.data,
        motivo: motivo ?? this.motivo,
      );
  @override
  String toString() {
    return (StringBuffer('Saida(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idVenda: $idVenda, ')
          ..write('idDivida: $idDivida, ')
          ..write('quantidade: $quantidade, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, estado, idProduto, idVenda, idDivida, quantidade, data, motivo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Saida &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.idVenda == this.idVenda &&
          other.idDivida == this.idDivida &&
          other.quantidade == this.quantidade &&
          other.data == this.data &&
          other.motivo == this.motivo);
}
