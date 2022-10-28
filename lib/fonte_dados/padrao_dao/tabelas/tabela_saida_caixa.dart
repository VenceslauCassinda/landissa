import 'package:drift/drift.dart';

class TabelaSaidaCaixa extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idFuncionario => integer()();
  DateTimeColumn get data => dateTime()();
  TextColumn get motivo => text()();
  RealColumn get valor => real()();
}