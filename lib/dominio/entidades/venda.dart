import 'package:drift/drift.dart';
import 'package:get/get.dart' as g;
import 'package:yetu_gestor/dominio/entidades/item_venda.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import '../../fonte_dados/padrao_dao/base_dados.dart';
import 'cliente.dart';
import 'funcionario.dart';
import 'pagamento.dart';
import 'preco.dart';

class Venda {
  Funcionario? funcionario;
  late Function accaoDestaque;
  bool vendaDestacada = false;
  Cliente? cliente;
  Produto? produto;
  List<Pagamento>? pagamentos = [];
  List<ItemVenda>? itensVenda = [];
  List<Preco>? precos = [];
  int? id;
  int? estado;
  int? quantidadeVendida;
  int? quantidade;
  int? idFuncionario;
  int? idProduto;
  int? idCliente;
  DateTime? data;
  DateTime? dataLevantamentoCompra;
  double? total;
  double? parcela;
  bool get divida => (total != parcela);
  bool get encomenda => (data != dataLevantamentoCompra);
  bool get venda => !divida;

  var linhaPintada = false.obs;
  var linhaDestacada = false.obs;
  Venda(
      {this.id,
      this.funcionario,
      this.itensVenda,
      this.pagamentos,
      this.cliente,
      this.produto,
      required this.idProduto,
      required this.quantidadeVendida,
      required this.estado,
      required this.idFuncionario,
      required this.idCliente,
      required this.data,
      this.dataLevantamentoCompra,
      required this.total,
      required this.parcela});
  factory Venda.fromData(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venda(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidadeVendida: serializer.fromJson<int>(json['quantidadeVendida']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idCliente: serializer.fromJson<int>(json['idCliente']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataLevantamentoCompra:
          serializer.fromJson<DateTime?>(json['dataLevantamentoCompra']),
      total: serializer.fromJson<double>(json['total']),
      parcela: serializer.fromJson<double>(json['parcela']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id!);
    map['estado'] = Variable<int>(estado!);
    map['quantidadeVendida'] = Variable<int>(quantidadeVendida!);
    map['id_funcionario'] = Variable<int>(idFuncionario!);
    map['id_cliente'] = Variable<int>(idCliente!);
    map['data'] = Variable<DateTime>(data!);
    if (!nullToAbsent || dataLevantamentoCompra != null) {
      map['data_levantamento_compra'] =
          dataLevantamentoCompra as Expression<DateTime>;
    }
    map['total'] = Variable<double>(total!);
    map['parcela'] = Variable<double>(parcela!);
    return map;
  }

  TabelaVendaCompanion toCompanion(bool nullToAbsent) {
    return TabelaVendaCompanion(
      id: id == null ? Value.absent() : Value(id!),
      estado: Value(estado!),
      idFuncionario: Value(idFuncionario!),
      quantidadeVendida: Value(quantidadeVendida ?? 0),
      idCliente: Value(idCliente!),
      idProduto: Value(idProduto ?? -1),
      data: Value(data!),
      dataLevantamentoCompra: dataLevantamentoCompra == null && nullToAbsent
          ? const Value.absent()
          : Value(dataLevantamentoCompra),
      total: Value(total ?? 0),
      parcela: Value(parcela ?? 0),
    );
  }

  factory Venda.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venda(
      id: json['id'],
      estado: serializer.fromJson<int>(json['estado']),
      quantidadeVendida: json['quantidadeVendida'],
      idProduto: json['idProduto'],
      produto: json['produto'],
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idCliente: serializer.fromJson<int>(json['idCliente']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataLevantamentoCompra: json['dataLevantamentoCompra'],
      total: serializer.fromJson<double>(json['total']),
      parcela: serializer.fromJson<double>(json['parcela']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': id,
      'estado': serializer.toJson<int>(estado!),
      'idFuncionario': serializer.toJson<int>(idFuncionario!),
      'idCliente': serializer.toJson<int>(idCliente!),
      'data': serializer.toJson<DateTime>(data!),
      'dataLevantamentoCompra': dataLevantamentoCompra,
      'produto': produto,
      'precos': precos,
      'idProduto': idProduto,
      'cliente': cliente,
      'quantidadeVendida': quantidadeVendida,
      'total': serializer.toJson<double>(total!),
      'parcela': serializer.toJson<double>(parcela!),
    };
  }

  @override
  String toString() {
    return (StringBuffer('Venda(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idCliente: $idCliente, ')
          ..write('data: $data, ')
          ..write('dataLevantamentoCompra: $dataLevantamentoCompra, ')
          ..write('total: $total, ')
          ..write(
            'parcela: $parcela',
          )
          ..write('\nCLIENTE: {${cliente?.toString()}}')
          ..write(
              '\nPAGAMENTOS: {${pagamentos?.map((e) => e.toString() + "\n").toList()}}\n')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idFuncionario, idCliente, data,
      dataLevantamentoCompra, total, parcela);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venda &&
          other.id == id &&
          other.estado == estado &&
          other.idFuncionario == idFuncionario &&
          other.idCliente == idCliente &&
          other.data == data &&
          other.dataLevantamentoCompra == dataLevantamentoCompra &&
          other.total == total &&
          other.parcela == parcela);
}
