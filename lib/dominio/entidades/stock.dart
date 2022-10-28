import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class Stock {
  int? id;
  int? estado;
  int? idProduto;
  int? quantidade;
  Stock(
      {this.id,
      required this.estado,
      required this.idProduto,
      required this.quantidade});

  Stock.zerado() {
    quantidade = 0;
  }
  factory Stock.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stock(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['id_produto'] = Variable<int>(idProduto!);
    map['quantidade'] = Variable<int>(quantidade!);
    return map;
  }

  TabelaStockCompanion toCompanion(bool nullToAbsent) {
    return TabelaStockCompanion(
      id: Value(id!),
      estado: Value(estado!),
      idProduto: Value(idProduto!),
      quantidade: Value(quantidade!),
    );
  }

  factory Stock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stock(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'idProduto': serializer.toJson<int>(idProduto!),
      'quantidade': serializer.toJson<int>(quantidade!),
    };
  }

  Stock copyWith({int? id, int? estado, int? idProduto, int? quantidade}) =>
      Stock(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        quantidade: quantidade ?? this.quantidade,
      );
  @override
  String toString() {
    return (StringBuffer('Stock(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idProduto, quantidade);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaStockData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.quantidade == this.quantidade);
}
