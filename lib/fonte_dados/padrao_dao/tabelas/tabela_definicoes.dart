import 'package:drift/drift.dart';

class TabelaDefinicoes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get estado => integer()();
  IntColumn get tipoNegocio => integer()();
  IntColumn get tipoEntidade => integer()();
  DateTimeColumn get dataAcesso => dateTime().nullable()();
  DateTimeColumn get dataExpiracao => dateTime().nullable()();
  TextColumn get licenca => text().nullable()();
  BoolColumn get licenciado => boolean().nullable()();
  TextColumn get idLicenca => text().nullable()();
}

class TipoNegocio {
  static const int GROSSO = 1, RETALHO = 2;
}

class TipoEntidade {
  static const int INDUSTRIAL = 1, COMERCIAL = 2, PRESTACAO_SERVICO = 3;
}
