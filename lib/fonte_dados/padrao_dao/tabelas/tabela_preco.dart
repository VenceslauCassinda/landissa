import 'package:drift/drift.dart';

class TabelaPreco extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idProduto => integer()();
  IntColumn get quantidade => integer()();
  RealColumn get preco => real()();
}