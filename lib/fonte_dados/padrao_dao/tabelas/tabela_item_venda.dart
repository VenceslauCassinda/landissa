import 'package:drift/drift.dart';

class TabelaItemVenda extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idProduto => integer()();
  IntColumn get idVenda => integer()();
  IntColumn get quantidade => integer()();
  RealColumn get total => real()();
  IntColumn get desconto => integer()();
}
