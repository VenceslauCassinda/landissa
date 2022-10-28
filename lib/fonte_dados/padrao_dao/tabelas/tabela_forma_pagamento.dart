import 'package:drift/drift.dart';

class TabelaFormaPagamento extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get tipo => integer()();
  TextColumn get descricao => text()();
}
