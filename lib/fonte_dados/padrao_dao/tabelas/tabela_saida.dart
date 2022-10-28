import 'package:drift/drift.dart';

class TabelaSaida extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idProduto => integer()();
  IntColumn get idVenda => integer().nullable()();
  IntColumn get idDivida => integer().nullable()();
  IntColumn get quantidade => integer()();
  DateTimeColumn get data => dateTime()();
  TextColumn get motivo => text().nullable()();
}
