import 'package:drift/drift.dart';

class TabelaFuncionario extends Table {
  IntColumn? get id => integer().autoIncrement()();
  IntColumn? get estado => integer()();
  IntColumn? get idUsuario => integer()();
  TextColumn? get nomeCompleto => text()();
}
