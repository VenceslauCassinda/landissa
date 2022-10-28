import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'produto.dart';

class Divida {
  int? id;
  int? idFuncionario;
  int? idFuncionarioPagante;
  int? idCliente;
  int? idProduto;
  int? estado;
  int? quantidadeDevida;
  DateTime? data;
  DateTime? dataPagamento;
  double? total;
  bool? paga;
  Funcionario? funcionario, funcionarioPagante;
  Cliente? cliente;
  Produto? produto;
  Divida(
      {this.id,
      required this.idFuncionario,
      this.idFuncionarioPagante,
      required this.idCliente,
      required this.idProduto,
      required this.estado,
      required this.quantidadeDevida,
      required this.data,
      this.dataPagamento,
      required this.total,
      required this.paga});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_funcionario'] = Variable<int>(idFuncionario);
    map['id_funcionario_pagante'] = Variable<int>(idFuncionarioPagante);
    map['id_cliente'] = Variable<int>(idCliente);
    map['id_produto'] = Variable<int>(idProduto);
    map['estado'] = Variable<int>(estado);
    map['quantidade_devida'] = Variable<int>(quantidadeDevida);
    map['data'] = Variable<DateTime>(data);
    map['data_pagamento'] = Variable<DateTime>(dataPagamento);
    map['total'] = Variable<double>(total);
    map['paga'] = Variable<bool>(paga);
    return map;
  }

  TabelaDividaCompanion toCompanion(bool nullToAbsent) {
    return TabelaDividaCompanion(
      id: id == null ? Value.absent() : Value<int>(id!),
      idFuncionario: Value(idFuncionario!),
      idFuncionarioPagante: idFuncionarioPagante == null
          ? Value.absent()
          : Value(idFuncionarioPagante!),
      idCliente: Value(idCliente!),
      idProduto: Value(idProduto!),
      estado: Value(estado!),
      quantidadeDevida: Value(quantidadeDevida!),
      data: Value(data!),
      dataPagamento:
          dataPagamento == null ? Value.absent() : Value(dataPagamento!),
      total: Value(total!),
      paga: Value(paga!),
    );
  }

  factory Divida.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Divida(
      id: json['id'],
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idFuncionarioPagante: json['idFuncionarioPagante'],
      idCliente: serializer.fromJson<int>(json['idCliente']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      estado: serializer.fromJson<int>(json['estado']),
      quantidadeDevida: serializer.fromJson<int>(json['quantidadeDevida']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataPagamento: json['dataPagamento'],
      total: serializer.fromJson<double>(json['total']),
      paga: serializer.fromJson<bool>(json['paga']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': id,
      'idFuncionario': idFuncionario,
      'idFuncionarioPagante': idFuncionarioPagante,
      'idCliente': idCliente,
      'idProduto': idProduto,
      'estado': estado,
      'quantidadeDevida': quantidadeDevida,
      'data': data,
      'dataPagamento': dataPagamento,
      'total': total,
      'paga': paga,
    };
  }

  @override
  String toString() {
    return (StringBuffer('TabelaDividaData(')
          ..write('id: $id, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idFuncionarioPagante: $idFuncionarioPagante, ')
          ..write('idCliente: $idCliente, ')
          ..write('idProduto: $idProduto, ')
          ..write('estado: $estado, ')
          ..write('quantidadeDevida: $quantidadeDevida, ')
          ..write('data: $data, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('total: $total, ')
          ..write('paga: $paga')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      idFuncionario,
      idFuncionarioPagante,
      idCliente,
      idProduto,
      estado,
      quantidadeDevida,
      data,
      dataPagamento,
      total,
      paga);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaDividaData &&
          other.id == this.id &&
          other.idFuncionario == this.idFuncionario &&
          other.idFuncionarioPagante == this.idFuncionarioPagante &&
          other.idCliente == this.idCliente &&
          other.idProduto == this.idProduto &&
          other.estado == this.estado &&
          other.quantidadeDevida == this.quantidadeDevida &&
          other.data == this.data &&
          other.dataPagamento == this.dataPagamento &&
          other.total == this.total &&
          other.paga == this.paga);
}
