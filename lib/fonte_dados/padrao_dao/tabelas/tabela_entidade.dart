import 'package:drift/drift.dart';

class TabelaEntidade extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  TextColumn get nome => text()();
  TextColumn get endereco => text()();
  TextColumn get nif => text()();
  TextColumn get telefone => text()();
}
