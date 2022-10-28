import 'package:drift/drift.dart';

class TabelaDinheiroSobra extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idFuncionario => integer()();
  RealColumn get valor => real()();
  DateTimeColumn get data => dateTime()();
}
