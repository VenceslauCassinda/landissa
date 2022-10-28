import 'package:drift/drift.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'produto.dart';

class Receccao {
  int? id;
  int? estado;
  int? idFuncionario;
  int? idPagante;
  int? idProduto;
  int? quantidadePorLotes;
  int? quantidadeLotes;
  double? precoLote;
  double? custoAquisicao;
  bool? pagavel;
  bool? paga;
  DateTime? data;
  DateTime? dataPagamento;
  Funcionario? funcionario;
  Funcionario? pagante;
  Produto? produto;
  Receccao({
    this.id,
    this.funcionario,
    this.produto,
    required this.estado,
    required this.idFuncionario,
    this.idPagante,
    required this.idProduto,
    required this.pagavel,
    this.pagante,
    required this.paga,
    required this.quantidadePorLotes,
    required this.quantidadeLotes,
    required this.precoLote,
    required this.custoAquisicao,
    required this.data,
    this.dataPagamento,
  });

  int get quantidadeRecebida =>
      (quantidadeLotes ?? 0) * (quantidadePorLotes ?? 0);
  double get custoTotal =>
      (quantidadeLotes ?? 0) * (precoLote ?? 0) + (custoAquisicao ?? 0);
  int get precoCompraProduto => custoTotal ~/ quantidadeRecebida;
  TabelaRececcaoCompanion toCompanion(bool nullToAbsent) {
    return TabelaRececcaoCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      estado: Value(estado!),
      idFuncionario: Value(idFuncionario!),
      idPagante: idPagante == null ? const Value.absent() : Value(idPagante!),
      idProduto: Value(idProduto!),
      quantidadePorLotes: Value(quantidadePorLotes!),
      quantidadeLotes: Value(quantidadeLotes!),
      precoLote: Value(precoLote!),
      pagavel: Value(pagavel!),
      paga: Value(paga!),
      custoAquisicao: Value(custoAquisicao!),
      data: Value(data!),
      dataPagamento:
          dataPagamento == null ? const Value.absent() : Value(dataPagamento!),
    );
  }

  factory Receccao.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receccao(
      id: serializer.fromJson<int>(json['id']),
      pagavel: serializer.fromJson<bool>(json['pagavel']),
      paga: serializer.fromJson<bool>(json['paga']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idPagante: serializer.fromJson<int>(json['idPagante']),
      quantidadePorLotes: serializer.fromJson<int>(json['quantidadePorLotes']),
      quantidadeLotes: serializer.fromJson<int>(json['quantidadeLotes']),
      precoLote: serializer.fromJson<double>(json['precoLote']),
      custoAquisicao: serializer.fromJson<double>(json['custoAquisicao']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataPagamento: serializer.fromJson<DateTime>(json['dataPagamento']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id!),
      'pagavel': serializer.toJson<bool>(pagavel!),
      'paga': serializer.toJson<bool>(paga!),
      'estado': serializer.toJson<int>(estado!),
      'idFuncionario': serializer.toJson<int>(idFuncionario!),
      'idProduto': serializer.toJson<int>(idProduto!),
      'quantidadePorLotes': serializer.toJson<int>(quantidadePorLotes!),
      'quantidadeLotes': serializer.toJson<int>(quantidadeLotes!),
      'precoLote': serializer.toJson<double>(precoLote!),
      'custoAquisicao': serializer.toJson<double>(custoAquisicao!),
      'data': serializer.toJson<DateTime>(data!),
    };
  }

  @override
  String toString() {
    return (StringBuffer('TabelaRececcaoData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('pagavel: $pagavel, ')
          ..write('paga: $paga, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidadePorLotes: $quantidadePorLotes, ')
          ..write('quantidadeLotes: $quantidadeLotes, ')
          ..write('precoLote: $precoLote, ')
          ..write('custoAquisicao: $custoAquisicao, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idFuncionario, idProduto,
      quantidadePorLotes, quantidadeLotes, precoLote, custoAquisicao, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaRececcaoData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.idProduto == this.idProduto &&
          other.quantidadePorLotes == this.quantidadePorLotes &&
          other.quantidadeLotes == this.quantidadeLotes &&
          other.precoLote == this.precoLote &&
          other.custoAquisicao == this.custoAquisicao &&
          other.data == this.data);
}
