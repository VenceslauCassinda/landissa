import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'receccao.dart';

class Entrada {
  Produto? produto;
  int? id;
  int? estado;
  int? idProduto;
  int? idRececcao;
  int? quantidade;
  DateTime? data;
  String? motivo;
  Entrada(
      {this.id,
      this.produto,
      required this.estado,
      required this.idProduto,
      required this.idRececcao,
      required this.quantidade,
      required this.data,
      required this.motivo});

  static String MOTIVO_ABASTECIMENTO = "Abastecimento";
  static String MOTIVO_AJUSTE_STOCK = "Ajuste de Stock";

  factory Entrada.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entrada(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idRececcao: serializer.fromJson<int>(json['idRececcao']),
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
    map['id_receccao'] = Variable<int>(idRececcao!);
    map['quantidade'] = Variable<int>(quantidade!);
    map['data'] = Variable<DateTime>(data!);
    map['motivo'] = Variable<String>(motivo!);
    return map;
  }

  TabelaEntradaCompanion toCompanion(bool nullToAbsent) {
    return TabelaEntradaCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      estado: Value(estado!),
      idProduto: Value(idProduto!),
      idRececcao: Value(idRececcao!),
      quantidade: Value(quantidade ?? 0),
      data: Value(data!),
      motivo: Value(motivo!),
    );
  }

  Entrada.simples() {
    data = DateTime.now();
  }

  factory Entrada.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entrada(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idRececcao: serializer.fromJson<int>(json['idRececcao']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String>(json['motivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idProduto': serializer.toJson<int>(idProduto!),
      'idRececcao': serializer.toJson<int>(idRececcao!),
      'quantidade': serializer.toJson<int>(quantidade!),
      'data': serializer.toJson<DateTime>(data!),
      'motivo': serializer.toJson<String>(motivo!),
    };
  }

  Entrada copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          int? idRececcao,
          int? quantidade,
          DateTime? data,
          String? motivo}) =>
      Entrada(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        idRececcao: idRececcao ?? this.idRececcao,
        quantidade: quantidade ?? this.quantidade,
        data: data ?? this.data,
        motivo: motivo ?? this.motivo,
      );
  @override
  String toString() {
    return (StringBuffer('Entrada(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idRececcao: $idRececcao, ')
          ..write('quantidade: $quantidade, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, estado, idProduto, idRececcao, quantidade, data, motivo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entrada &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.idRececcao == this.idRececcao &&
          other.quantidade == this.quantidade &&
          other.data == this.data &&
          other.motivo == this.motivo);
}
