import 'package:drift/drift.dart';

class TabelaPagamentoFinal extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idPagamento => integer()();
  DateTimeColumn get data => dateTime()();
}
