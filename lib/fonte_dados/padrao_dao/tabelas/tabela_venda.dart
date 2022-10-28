import 'package:drift/drift.dart';

class TabelaVenda extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idFuncionario => integer()();
  IntColumn get idCliente => integer()();
  IntColumn get quantidadeVendida => integer().nullable()();
  IntColumn get idProduto => integer().nullable()();
  DateTimeColumn get data => dateTime()();
  DateTimeColumn get dataLevantamentoCompra => dateTime().nullable()();
  RealColumn get total => real()();
  RealColumn get parcela => real()();
}
