import 'package:drift/drift.dart';

class TabelaParcelaPaga extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idVenda => integer()();
  RealColumn get parcela => real()();
}
