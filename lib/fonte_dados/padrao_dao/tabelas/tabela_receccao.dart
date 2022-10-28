import 'package:drift/drift.dart';

class TabelaRececcao extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idFuncionario => integer()();
  IntColumn get idPagante => integer().nullable()();
  IntColumn get idProduto => integer()();
  IntColumn get quantidadePorLotes => integer()();
  IntColumn get quantidadeLotes => integer()();
  RealColumn get precoLote => real()();
  RealColumn get custoAquisicao => real()();
  DateTimeColumn get data => dateTime()();
  DateTimeColumn get dataPagamento => dateTime().nullable()();
  BoolColumn get pagavel => boolean().nullable()();
  BoolColumn get paga => boolean().nullable()();
}
