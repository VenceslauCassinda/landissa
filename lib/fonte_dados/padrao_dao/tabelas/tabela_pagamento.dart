import 'package:drift/drift.dart';

class TabelaPagamento extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idFormaPagamento => integer()();
  IntColumn get estado => integer()();
  IntColumn get idVenda => integer()();
  RealColumn get valor => real()();
}
