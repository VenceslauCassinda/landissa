import 'package:drift/drift.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/tabelas/tabela_definicoes.dart';

import '../../fonte_dados/padrao_dao/base_dados.dart';

class Definicoes {
  int? id;
  String? idLicenca;
  int? estado;
  int? tipoNegocio;
  int? tipoEntidade;
  DateTime? dataAcesso, dataExpiracao;
  String? licenca;
  bool? licenciado;

  Definicoes(
      {this.id,
      this.estado,
      this.tipoNegocio,
      this.idLicenca,
      this.licenciado,
      this.tipoEntidade,
      this.dataAcesso,
      this.dataExpiracao,
      this.licenca});

  static String tipoEntidadeParaTexto(int tipo) {
    if (tipo == TipoEntidade.COMERCIAL) {
      return "Comercial";
    }
    if (tipo == TipoEntidade.PRESTACAO_SERVICO) {
      return "Prestação de Serviço";
    }
    return "Industrial";
  }

  static int tipoEntidadeParaInteiro(String tipo) {
    if (tipo == "Comercial") {
      return TipoEntidade.COMERCIAL;
    }
    if (tipo == "Prestação de Serviço") {
      return TipoEntidade.PRESTACAO_SERVICO;
    }
    return TipoEntidade.INDUSTRIAL;
  }

  static String tipoNegocioParaTexto(int tipo) {
    if (tipo == TipoNegocio.GROSSO) {
      return "Venda à Grosso";
    }
    return "Venda à Retalho";
  }

  static int tipoNegocioParaInteiro(String tipo) {
    if (tipo == "Venda à Grosso") {
      return TipoNegocio.GROSSO;
    }
    return TipoNegocio.RETALHO;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['tipo_negocio'] = Variable<int>(tipoNegocio);
    map['tipo_entidade'] = Variable<int>(tipoEntidade);
    return map;
  }

  TabelaDefinicoesCompanion toCompanion(bool nullToAbsent) {
    return TabelaDefinicoesCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      estado: Value(estado!),
      dataAcesso: dataAcesso == null ? Value.absent() : Value(dataAcesso!),
      dataExpiracao:
          dataExpiracao == null ? Value.absent() : Value(dataExpiracao!),
      licenca: licenca == null ? Value.absent() : Value(licenca!),
      licenciado: licenciado == null ? Value.absent() : Value(licenciado!),
      idLicenca: idLicenca == null ? Value.absent() : Value(idLicenca!),
      tipoNegocio: Value(tipoNegocio!),
      tipoEntidade: Value(tipoEntidade!),
    );
  }

  factory Definicoes.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Definicoes(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      tipoNegocio: serializer.fromJson<int>(json['tipoNegocio']),
      tipoEntidade: serializer.fromJson<int>(json['tipoEntidade']),
      dataAcesso: serializer.fromJson<DateTime>(json['dataAcesso']),
      dataExpiracao: serializer.fromJson<DateTime>(json['dataExpiracao']),
      idLicenca: serializer.fromJson<String>(json['idLicenca']),
      licenciado: serializer.fromJson<bool>(json['licenciado']),
      licenca: serializer.fromJson<String>(json['licenca']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': id,
      'estado': estado,
      'licenciado': licenciado,
      'idLicenca': idLicenca,
      'licenca': licenca,
      'dataAcesso': dataAcesso,
      'dataExpiracao': dataExpiracao,
      'tipoNegocio': tipoNegocio,
      'tipoEntidade': tipoEntidade,
    };
  }
}
