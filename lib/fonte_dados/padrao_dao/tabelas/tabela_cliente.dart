import 'package:drift/drift.dart';

class TabelaCliente extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  TextColumn get nome => text()();
  TextColumn get numero => text()();
}