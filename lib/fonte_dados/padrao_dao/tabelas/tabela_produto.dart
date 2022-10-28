import 'package:drift/drift.dart';

class TabelaProduto extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  TextColumn get nome => text()();
  RealColumn get precoCompra => real()();
  BoolColumn get recebivel => boolean()();
}
