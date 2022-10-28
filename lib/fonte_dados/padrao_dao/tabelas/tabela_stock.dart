import 'package:drift/drift.dart';

class TabelaStock extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get idProduto => integer()();
  IntColumn get quantidade => integer()();
}