import 'package:drift/drift.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class Preco {
  int? id;
  int? estado;
  int? quantidade;
  int? idProduto;
  double? preco;
  Preco(
      {this.id,
      required this.estado,
      required this.quantidade,
      required this.idProduto,
      required this.preco});
  factory Preco.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preco(
      id: serializer.fromJson<int>(json['id']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      preco: serializer.fromJson<double>(json['preco']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['quantidade'] = Variable<int>(quantidade!);
    map['id_produto'] = Variable<int>(idProduto!);
    map['preco'] = Variable<double>(preco!);
    return map;
  }

  TabelaPrecoCompanion toCompanion(bool nullToAbsent) {
    return TabelaPrecoCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      estado: Value(estado!),
      idProduto: Value(idProduto!),
      quantidade: Value(quantidade!),
      preco: Value(preco!),
    );
  }

  factory Preco.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preco(
      id: serializer.fromJson<int>(json['id']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      preco: serializer.fromJson<double>(json['preco']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': id,
      'estado': serializer.toJson<int>(estado!),
      'idProduto': serializer.toJson<int>(idProduto!),
      'preco': serializer.toJson<double>(preco!),
    };
  }

  Preco copyWith({int? id, int? estado, int? idProduto, double? preco}) =>
      Preco(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        quantidade: quantidade ?? this.quantidade,
        idProduto: idProduto ?? this.idProduto,
        preco: preco ?? this.preco,
      );
  @override
  String toString() {
    return (StringBuffer('Preco(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('preco: $preco, ')
          ..write('quantidade: $quantidade')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idProduto, preco);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preco &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.preco == this.preco);
}
