import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/stock.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class Produto {
  Stock? stock;
  int? id;
  int? idPreco;
  int? estado;
  String? nome;
  double? precoCompra;
  bool? recebivel;
  int diferenca = 0;
  int quantidade = 0;
  int quantidadeExistente = 0;
  double vendaEstimado = 0;
  double precoGeral = 0;
  double dinheiro = 0;
  Produto(
      {this.id,
      this.estado,
      this.idPreco,
      this.stock,
      this.nome,
      this.precoCompra,
      this.recebivel});
  factory Produto.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Produto(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      precoCompra: serializer.fromJson<double>(json['precoCompra']),
      recebivel: serializer.fromJson<bool>(json['recebivel']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['nome'] = Variable<String>(nome!);
    map['preco_compra'] = Variable<double>(precoCompra!);
    map['recebivel'] = Variable<bool>(recebivel!);
    return map;
  }

  TabelaProdutoCompanion toCompanion(bool nullToAbsent) {
    return TabelaProdutoCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado ?? Estado.ATIVADO),
      nome: Value(nome!),
      precoCompra: Value(precoCompra ?? 0),
      recebivel: Value(recebivel ?? false),
    );
  }

  factory Produto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Produto(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      precoCompra: serializer.fromJson<double>(json['precoCompra']),
      recebivel: serializer.fromJson<bool>(json['recebivel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'estado': serializer.toJson<int>(estado!),
      'nome': serializer.toJson<String>(nome!),
      'precoCompra': serializer.toJson<double>(precoCompra!),
      'recebivel': serializer.toJson<bool>(recebivel!),
    };
  }

  Produto copyWith(
          {int? id,
          int? estado,
          int? quantidade,
          String? nome,
          double? precoCompra,
          bool? recebivel}) =>
      Produto(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        nome: nome ?? this.nome,
        precoCompra: precoCompra ?? this.precoCompra,
        recebivel: recebivel ?? this.recebivel,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaProdutoData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('precoCompra: $precoCompra, ')
          ..write('recebivel: $recebivel, ')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, nome, precoCompra, recebivel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaProdutoData && other.id == id && other.estado == estado);
}
