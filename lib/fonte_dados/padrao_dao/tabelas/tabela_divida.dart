import 'package:drift/drift.dart';

class TabelaDivida extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idFuncionario => integer()();
  IntColumn get idFuncionarioPagante => integer().nullable()();
  IntColumn get idCliente => integer()();
  IntColumn get idProduto => integer()();
  IntColumn get estado => integer()();
  IntColumn get quantidadeDevida => integer()();
  DateTimeColumn get data => dateTime()();
  DateTimeColumn get dataPagamento => dateTime().nullable()();
  RealColumn get total => real()();
  BoolColumn get paga => boolean()();
}