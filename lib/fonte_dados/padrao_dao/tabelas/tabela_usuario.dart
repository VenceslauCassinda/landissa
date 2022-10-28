import 'package:drift/drift.dart';

class TabelaUsuario extends Table {
  IntColumn? get id => integer().autoIncrement()();
  IntColumn? get nivelAcesso => integer()();
  IntColumn? get estado => integer().nullable()();
  TextColumn? get nomeUsuario => text()();
  BoolColumn? get logado => boolean().nullable()();
  TextColumn? get imagemPerfil => text()();
  TextColumn? get palavraPasse => text()();
}
