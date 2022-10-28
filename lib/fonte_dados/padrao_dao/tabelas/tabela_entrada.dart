import 'package:drift/drift.dart';

class TabelaEntrada extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idProduto => integer()();
  IntColumn get idRececcao => integer()();
  IntColumn get quantidade => integer()();
  DateTimeColumn get data => dateTime()();
  TextColumn get motivo => text().nullable()();
}