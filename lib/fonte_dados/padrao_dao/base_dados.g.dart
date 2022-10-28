// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_dados.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class TabelaUsuarioData extends DataClass
    implements Insertable<TabelaUsuarioData> {
  final int id;
  final int nivelAcesso;
  final int? estado;
  final String nomeUsuario;
  final bool? logado;
  final String imagemPerfil;
  final String palavraPasse;
  const TabelaUsuarioData(
      {required this.id,
      required this.nivelAcesso,
      this.estado,
      required this.nomeUsuario,
      this.logado,
      required this.imagemPerfil,
      required this.palavraPasse});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nivel_acesso'] = Variable<int>(nivelAcesso);
    if (!nullToAbsent || estado != null) {
      map['estado'] = Variable<int>(estado);
    }
    map['nome_usuario'] = Variable<String>(nomeUsuario);
    if (!nullToAbsent || logado != null) {
      map['logado'] = Variable<bool>(logado);
    }
    map['imagem_perfil'] = Variable<String>(imagemPerfil);
    map['palavra_passe'] = Variable<String>(palavraPasse);
    return map;
  }

  TabelaUsuarioCompanion toCompanion(bool nullToAbsent) {
    return TabelaUsuarioCompanion(
      id: Value(id),
      nivelAcesso: Value(nivelAcesso),
      estado:
          estado == null && nullToAbsent ? const Value.absent() : Value(estado),
      nomeUsuario: Value(nomeUsuario),
      logado:
          logado == null && nullToAbsent ? const Value.absent() : Value(logado),
      imagemPerfil: Value(imagemPerfil),
      palavraPasse: Value(palavraPasse),
    );
  }

  factory TabelaUsuarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaUsuarioData(
      id: serializer.fromJson<int>(json['id']),
      nivelAcesso: serializer.fromJson<int>(json['nivelAcesso']),
      estado: serializer.fromJson<int?>(json['estado']),
      nomeUsuario: serializer.fromJson<String>(json['nomeUsuario']),
      logado: serializer.fromJson<bool?>(json['logado']),
      imagemPerfil: serializer.fromJson<String>(json['imagemPerfil']),
      palavraPasse: serializer.fromJson<String>(json['palavraPasse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nivelAcesso': serializer.toJson<int>(nivelAcesso),
      'estado': serializer.toJson<int?>(estado),
      'nomeUsuario': serializer.toJson<String>(nomeUsuario),
      'logado': serializer.toJson<bool?>(logado),
      'imagemPerfil': serializer.toJson<String>(imagemPerfil),
      'palavraPasse': serializer.toJson<String>(palavraPasse),
    };
  }

  TabelaUsuarioData copyWith(
          {int? id,
          int? nivelAcesso,
          Value<int?> estado = const Value.absent(),
          String? nomeUsuario,
          Value<bool?> logado = const Value.absent(),
          String? imagemPerfil,
          String? palavraPasse}) =>
      TabelaUsuarioData(
        id: id ?? this.id,
        nivelAcesso: nivelAcesso ?? this.nivelAcesso,
        estado: estado.present ? estado.value : this.estado,
        nomeUsuario: nomeUsuario ?? this.nomeUsuario,
        logado: logado.present ? logado.value : this.logado,
        imagemPerfil: imagemPerfil ?? this.imagemPerfil,
        palavraPasse: palavraPasse ?? this.palavraPasse,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaUsuarioData(')
          ..write('id: $id, ')
          ..write('nivelAcesso: $nivelAcesso, ')
          ..write('estado: $estado, ')
          ..write('nomeUsuario: $nomeUsuario, ')
          ..write('logado: $logado, ')
          ..write('imagemPerfil: $imagemPerfil, ')
          ..write('palavraPasse: $palavraPasse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, nivelAcesso, estado, nomeUsuario, logado, imagemPerfil, palavraPasse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaUsuarioData &&
          other.id == this.id &&
          other.nivelAcesso == this.nivelAcesso &&
          other.estado == this.estado &&
          other.nomeUsuario == this.nomeUsuario &&
          other.logado == this.logado &&
          other.imagemPerfil == this.imagemPerfil &&
          other.palavraPasse == this.palavraPasse);
}

class TabelaUsuarioCompanion extends UpdateCompanion<TabelaUsuarioData> {
  final Value<int> id;
  final Value<int> nivelAcesso;
  final Value<int?> estado;
  final Value<String> nomeUsuario;
  final Value<bool?> logado;
  final Value<String> imagemPerfil;
  final Value<String> palavraPasse;
  const TabelaUsuarioCompanion({
    this.id = const Value.absent(),
    this.nivelAcesso = const Value.absent(),
    this.estado = const Value.absent(),
    this.nomeUsuario = const Value.absent(),
    this.logado = const Value.absent(),
    this.imagemPerfil = const Value.absent(),
    this.palavraPasse = const Value.absent(),
  });
  TabelaUsuarioCompanion.insert({
    this.id = const Value.absent(),
    required int nivelAcesso,
    this.estado = const Value.absent(),
    required String nomeUsuario,
    this.logado = const Value.absent(),
    required String imagemPerfil,
    required String palavraPasse,
  })  : nivelAcesso = Value(nivelAcesso),
        nomeUsuario = Value(nomeUsuario),
        imagemPerfil = Value(imagemPerfil),
        palavraPasse = Value(palavraPasse);
  static Insertable<TabelaUsuarioData> custom({
    Expression<int>? id,
    Expression<int>? nivelAcesso,
    Expression<int>? estado,
    Expression<String>? nomeUsuario,
    Expression<bool>? logado,
    Expression<String>? imagemPerfil,
    Expression<String>? palavraPasse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nivelAcesso != null) 'nivel_acesso': nivelAcesso,
      if (estado != null) 'estado': estado,
      if (nomeUsuario != null) 'nome_usuario': nomeUsuario,
      if (logado != null) 'logado': logado,
      if (imagemPerfil != null) 'imagem_perfil': imagemPerfil,
      if (palavraPasse != null) 'palavra_passe': palavraPasse,
    });
  }

  TabelaUsuarioCompanion copyWith(
      {Value<int>? id,
      Value<int>? nivelAcesso,
      Value<int?>? estado,
      Value<String>? nomeUsuario,
      Value<bool?>? logado,
      Value<String>? imagemPerfil,
      Value<String>? palavraPasse}) {
    return TabelaUsuarioCompanion(
      id: id ?? this.id,
      nivelAcesso: nivelAcesso ?? this.nivelAcesso,
      estado: estado ?? this.estado,
      nomeUsuario: nomeUsuario ?? this.nomeUsuario,
      logado: logado ?? this.logado,
      imagemPerfil: imagemPerfil ?? this.imagemPerfil,
      palavraPasse: palavraPasse ?? this.palavraPasse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nivelAcesso.present) {
      map['nivel_acesso'] = Variable<int>(nivelAcesso.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (nomeUsuario.present) {
      map['nome_usuario'] = Variable<String>(nomeUsuario.value);
    }
    if (logado.present) {
      map['logado'] = Variable<bool>(logado.value);
    }
    if (imagemPerfil.present) {
      map['imagem_perfil'] = Variable<String>(imagemPerfil.value);
    }
    if (palavraPasse.present) {
      map['palavra_passe'] = Variable<String>(palavraPasse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaUsuarioCompanion(')
          ..write('id: $id, ')
          ..write('nivelAcesso: $nivelAcesso, ')
          ..write('estado: $estado, ')
          ..write('nomeUsuario: $nomeUsuario, ')
          ..write('logado: $logado, ')
          ..write('imagemPerfil: $imagemPerfil, ')
          ..write('palavraPasse: $palavraPasse')
          ..write(')'))
        .toString();
  }
}

class $TabelaUsuarioTable extends TabelaUsuario
    with TableInfo<$TabelaUsuarioTable, TabelaUsuarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaUsuarioTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nivelAcessoMeta =
      const VerificationMeta('nivelAcesso');
  @override
  late final GeneratedColumn<int> nivelAcesso = GeneratedColumn<int>(
      'nivel_acesso', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _nomeUsuarioMeta =
      const VerificationMeta('nomeUsuario');
  @override
  late final GeneratedColumn<String> nomeUsuario = GeneratedColumn<String>(
      'nome_usuario', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _logadoMeta = const VerificationMeta('logado');
  @override
  late final GeneratedColumn<bool> logado = GeneratedColumn<bool>(
      'logado', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("logado" IN (0, 1))');
  final VerificationMeta _imagemPerfilMeta =
      const VerificationMeta('imagemPerfil');
  @override
  late final GeneratedColumn<String> imagemPerfil = GeneratedColumn<String>(
      'imagem_perfil', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _palavraPasseMeta =
      const VerificationMeta('palavraPasse');
  @override
  late final GeneratedColumn<String> palavraPasse = GeneratedColumn<String>(
      'palavra_passe', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nivelAcesso,
        estado,
        nomeUsuario,
        logado,
        imagemPerfil,
        palavraPasse
      ];
  @override
  String get aliasedName => _alias ?? 'tabela_usuario';
  @override
  String get actualTableName => 'tabela_usuario';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaUsuarioData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nivel_acesso')) {
      context.handle(
          _nivelAcessoMeta,
          nivelAcesso.isAcceptableOrUnknown(
              data['nivel_acesso']!, _nivelAcessoMeta));
    } else if (isInserting) {
      context.missing(_nivelAcessoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('nome_usuario')) {
      context.handle(
          _nomeUsuarioMeta,
          nomeUsuario.isAcceptableOrUnknown(
              data['nome_usuario']!, _nomeUsuarioMeta));
    } else if (isInserting) {
      context.missing(_nomeUsuarioMeta);
    }
    if (data.containsKey('logado')) {
      context.handle(_logadoMeta,
          logado.isAcceptableOrUnknown(data['logado']!, _logadoMeta));
    }
    if (data.containsKey('imagem_perfil')) {
      context.handle(
          _imagemPerfilMeta,
          imagemPerfil.isAcceptableOrUnknown(
              data['imagem_perfil']!, _imagemPerfilMeta));
    } else if (isInserting) {
      context.missing(_imagemPerfilMeta);
    }
    if (data.containsKey('palavra_passe')) {
      context.handle(
          _palavraPasseMeta,
          palavraPasse.isAcceptableOrUnknown(
              data['palavra_passe']!, _palavraPasseMeta));
    } else if (isInserting) {
      context.missing(_palavraPasseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaUsuarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaUsuarioData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nivelAcesso: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}nivel_acesso'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado']),
      nomeUsuario: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}nome_usuario'])!,
      logado: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}logado']),
      imagemPerfil: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}imagem_perfil'])!,
      palavraPasse: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}palavra_passe'])!,
    );
  }

  @override
  $TabelaUsuarioTable createAlias(String alias) {
    return $TabelaUsuarioTable(attachedDatabase, alias);
  }
}

class TabelaFuncionarioData extends DataClass
    implements Insertable<TabelaFuncionarioData> {
  final int id;
  final int estado;
  final int idUsuario;
  final String nomeCompleto;
  const TabelaFuncionarioData(
      {required this.id,
      required this.estado,
      required this.idUsuario,
      required this.nomeCompleto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_usuario'] = Variable<int>(idUsuario);
    map['nome_completo'] = Variable<String>(nomeCompleto);
    return map;
  }

  TabelaFuncionarioCompanion toCompanion(bool nullToAbsent) {
    return TabelaFuncionarioCompanion(
      id: Value(id),
      estado: Value(estado),
      idUsuario: Value(idUsuario),
      nomeCompleto: Value(nomeCompleto),
    );
  }

  factory TabelaFuncionarioData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaFuncionarioData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idUsuario: serializer.fromJson<int>(json['idUsuario']),
      nomeCompleto: serializer.fromJson<String>(json['nomeCompleto']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idUsuario': serializer.toJson<int>(idUsuario),
      'nomeCompleto': serializer.toJson<String>(nomeCompleto),
    };
  }

  TabelaFuncionarioData copyWith(
          {int? id, int? estado, int? idUsuario, String? nomeCompleto}) =>
      TabelaFuncionarioData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idUsuario: idUsuario ?? this.idUsuario,
        nomeCompleto: nomeCompleto ?? this.nomeCompleto,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaFuncionarioData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idUsuario: $idUsuario, ')
          ..write('nomeCompleto: $nomeCompleto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idUsuario, nomeCompleto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaFuncionarioData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idUsuario == this.idUsuario &&
          other.nomeCompleto == this.nomeCompleto);
}

class TabelaFuncionarioCompanion
    extends UpdateCompanion<TabelaFuncionarioData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idUsuario;
  final Value<String> nomeCompleto;
  const TabelaFuncionarioCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idUsuario = const Value.absent(),
    this.nomeCompleto = const Value.absent(),
  });
  TabelaFuncionarioCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idUsuario,
    required String nomeCompleto,
  })  : estado = Value(estado),
        idUsuario = Value(idUsuario),
        nomeCompleto = Value(nomeCompleto);
  static Insertable<TabelaFuncionarioData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idUsuario,
    Expression<String>? nomeCompleto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idUsuario != null) 'id_usuario': idUsuario,
      if (nomeCompleto != null) 'nome_completo': nomeCompleto,
    });
  }

  TabelaFuncionarioCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idUsuario,
      Value<String>? nomeCompleto}) {
    return TabelaFuncionarioCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idUsuario: idUsuario ?? this.idUsuario,
      nomeCompleto: nomeCompleto ?? this.nomeCompleto,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idUsuario.present) {
      map['id_usuario'] = Variable<int>(idUsuario.value);
    }
    if (nomeCompleto.present) {
      map['nome_completo'] = Variable<String>(nomeCompleto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaFuncionarioCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idUsuario: $idUsuario, ')
          ..write('nomeCompleto: $nomeCompleto')
          ..write(')'))
        .toString();
  }
}

class $TabelaFuncionarioTable extends TabelaFuncionario
    with TableInfo<$TabelaFuncionarioTable, TabelaFuncionarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaFuncionarioTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idUsuarioMeta = const VerificationMeta('idUsuario');
  @override
  late final GeneratedColumn<int> idUsuario = GeneratedColumn<int>(
      'id_usuario', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _nomeCompletoMeta =
      const VerificationMeta('nomeCompleto');
  @override
  late final GeneratedColumn<String> nomeCompleto = GeneratedColumn<String>(
      'nome_completo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, estado, idUsuario, nomeCompleto];
  @override
  String get aliasedName => _alias ?? 'tabela_funcionario';
  @override
  String get actualTableName => 'tabela_funcionario';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaFuncionarioData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_usuario')) {
      context.handle(_idUsuarioMeta,
          idUsuario.isAcceptableOrUnknown(data['id_usuario']!, _idUsuarioMeta));
    } else if (isInserting) {
      context.missing(_idUsuarioMeta);
    }
    if (data.containsKey('nome_completo')) {
      context.handle(
          _nomeCompletoMeta,
          nomeCompleto.isAcceptableOrUnknown(
              data['nome_completo']!, _nomeCompletoMeta));
    } else if (isInserting) {
      context.missing(_nomeCompletoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaFuncionarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaFuncionarioData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idUsuario: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_usuario'])!,
      nomeCompleto: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}nome_completo'])!,
    );
  }

  @override
  $TabelaFuncionarioTable createAlias(String alias) {
    return $TabelaFuncionarioTable(attachedDatabase, alias);
  }
}

class TabelaProdutoData extends DataClass
    implements Insertable<TabelaProdutoData> {
  final int id;
  final int estado;
  final String nome;
  final double precoCompra;
  final bool recebivel;
  const TabelaProdutoData(
      {required this.id,
      required this.estado,
      required this.nome,
      required this.precoCompra,
      required this.recebivel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['nome'] = Variable<String>(nome);
    map['preco_compra'] = Variable<double>(precoCompra);
    map['recebivel'] = Variable<bool>(recebivel);
    return map;
  }

  TabelaProdutoCompanion toCompanion(bool nullToAbsent) {
    return TabelaProdutoCompanion(
      id: Value(id),
      estado: Value(estado),
      nome: Value(nome),
      precoCompra: Value(precoCompra),
      recebivel: Value(recebivel),
    );
  }

  factory TabelaProdutoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaProdutoData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      precoCompra: serializer.fromJson<double>(json['precoCompra']),
      recebivel: serializer.fromJson<bool>(json['recebivel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'nome': serializer.toJson<String>(nome),
      'precoCompra': serializer.toJson<double>(precoCompra),
      'recebivel': serializer.toJson<bool>(recebivel),
    };
  }

  TabelaProdutoData copyWith(
          {int? id,
          int? estado,
          String? nome,
          double? precoCompra,
          bool? recebivel}) =>
      TabelaProdutoData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        nome: nome ?? this.nome,
        precoCompra: precoCompra ?? this.precoCompra,
        recebivel: recebivel ?? this.recebivel,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaProdutoData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('precoCompra: $precoCompra, ')
          ..write('recebivel: $recebivel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, nome, precoCompra, recebivel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaProdutoData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.nome == this.nome &&
          other.precoCompra == this.precoCompra &&
          other.recebivel == this.recebivel);
}

class TabelaProdutoCompanion extends UpdateCompanion<TabelaProdutoData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<String> nome;
  final Value<double> precoCompra;
  final Value<bool> recebivel;
  const TabelaProdutoCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.nome = const Value.absent(),
    this.precoCompra = const Value.absent(),
    this.recebivel = const Value.absent(),
  });
  TabelaProdutoCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required String nome,
    required double precoCompra,
    required bool recebivel,
  })  : estado = Value(estado),
        nome = Value(nome),
        precoCompra = Value(precoCompra),
        recebivel = Value(recebivel);
  static Insertable<TabelaProdutoData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<String>? nome,
    Expression<double>? precoCompra,
    Expression<bool>? recebivel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (nome != null) 'nome': nome,
      if (precoCompra != null) 'preco_compra': precoCompra,
      if (recebivel != null) 'recebivel': recebivel,
    });
  }

  TabelaProdutoCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<String>? nome,
      Value<double>? precoCompra,
      Value<bool>? recebivel}) {
    return TabelaProdutoCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      nome: nome ?? this.nome,
      precoCompra: precoCompra ?? this.precoCompra,
      recebivel: recebivel ?? this.recebivel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (precoCompra.present) {
      map['preco_compra'] = Variable<double>(precoCompra.value);
    }
    if (recebivel.present) {
      map['recebivel'] = Variable<bool>(recebivel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaProdutoCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('precoCompra: $precoCompra, ')
          ..write('recebivel: $recebivel')
          ..write(')'))
        .toString();
  }
}

class $TabelaProdutoTable extends TabelaProduto
    with TableInfo<$TabelaProdutoTable, TabelaProdutoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaProdutoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _precoCompraMeta =
      const VerificationMeta('precoCompra');
  @override
  late final GeneratedColumn<double> precoCompra = GeneratedColumn<double>(
      'preco_compra', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _recebivelMeta = const VerificationMeta('recebivel');
  @override
  late final GeneratedColumn<bool> recebivel = GeneratedColumn<bool>(
      'recebivel', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("recebivel" IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, nome, precoCompra, recebivel];
  @override
  String get aliasedName => _alias ?? 'tabela_produto';
  @override
  String get actualTableName => 'tabela_produto';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaProdutoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('preco_compra')) {
      context.handle(
          _precoCompraMeta,
          precoCompra.isAcceptableOrUnknown(
              data['preco_compra']!, _precoCompraMeta));
    } else if (isInserting) {
      context.missing(_precoCompraMeta);
    }
    if (data.containsKey('recebivel')) {
      context.handle(_recebivelMeta,
          recebivel.isAcceptableOrUnknown(data['recebivel']!, _recebivelMeta));
    } else if (isInserting) {
      context.missing(_recebivelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaProdutoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaProdutoData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      nome: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      precoCompra: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}preco_compra'])!,
      recebivel: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}recebivel'])!,
    );
  }

  @override
  $TabelaProdutoTable createAlias(String alias) {
    return $TabelaProdutoTable(attachedDatabase, alias);
  }
}

class TabelaPrecoData extends DataClass implements Insertable<TabelaPrecoData> {
  final int id;
  final int estado;
  final int idProduto;
  final int quantidade;
  final double preco;
  const TabelaPrecoData(
      {required this.id,
      required this.estado,
      required this.idProduto,
      required this.quantidade,
      required this.preco});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_produto'] = Variable<int>(idProduto);
    map['quantidade'] = Variable<int>(quantidade);
    map['preco'] = Variable<double>(preco);
    return map;
  }

  TabelaPrecoCompanion toCompanion(bool nullToAbsent) {
    return TabelaPrecoCompanion(
      id: Value(id),
      estado: Value(estado),
      idProduto: Value(idProduto),
      quantidade: Value(quantidade),
      preco: Value(preco),
    );
  }

  factory TabelaPrecoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaPrecoData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      preco: serializer.fromJson<double>(json['preco']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idProduto': serializer.toJson<int>(idProduto),
      'quantidade': serializer.toJson<int>(quantidade),
      'preco': serializer.toJson<double>(preco),
    };
  }

  TabelaPrecoData copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          int? quantidade,
          double? preco}) =>
      TabelaPrecoData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        quantidade: quantidade ?? this.quantidade,
        preco: preco ?? this.preco,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaPrecoData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('preco: $preco')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idProduto, quantidade, preco);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaPrecoData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.quantidade == this.quantidade &&
          other.preco == this.preco);
}

class TabelaPrecoCompanion extends UpdateCompanion<TabelaPrecoData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idProduto;
  final Value<int> quantidade;
  final Value<double> preco;
  const TabelaPrecoCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.preco = const Value.absent(),
  });
  TabelaPrecoCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idProduto,
    required int quantidade,
    required double preco,
  })  : estado = Value(estado),
        idProduto = Value(idProduto),
        quantidade = Value(quantidade),
        preco = Value(preco);
  static Insertable<TabelaPrecoData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idProduto,
    Expression<int>? quantidade,
    Expression<double>? preco,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idProduto != null) 'id_produto': idProduto,
      if (quantidade != null) 'quantidade': quantidade,
      if (preco != null) 'preco': preco,
    });
  }

  TabelaPrecoCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idProduto,
      Value<int>? quantidade,
      Value<double>? preco}) {
    return TabelaPrecoCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idProduto: idProduto ?? this.idProduto,
      quantidade: quantidade ?? this.quantidade,
      preco: preco ?? this.preco,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (preco.present) {
      map['preco'] = Variable<double>(preco.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaPrecoCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade, ')
          ..write('preco: $preco')
          ..write(')'))
        .toString();
  }
}

class $TabelaPrecoTable extends TabelaPreco
    with TableInfo<$TabelaPrecoTable, TabelaPrecoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaPrecoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeMeta = const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _precoMeta = const VerificationMeta('preco');
  @override
  late final GeneratedColumn<double> preco = GeneratedColumn<double>(
      'preco', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, idProduto, quantidade, preco];
  @override
  String get aliasedName => _alias ?? 'tabela_preco';
  @override
  String get actualTableName => 'tabela_preco';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaPrecoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('preco')) {
      context.handle(
          _precoMeta, preco.isAcceptableOrUnknown(data['preco']!, _precoMeta));
    } else if (isInserting) {
      context.missing(_precoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaPrecoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaPrecoData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      quantidade: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      preco: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}preco'])!,
    );
  }

  @override
  $TabelaPrecoTable createAlias(String alias) {
    return $TabelaPrecoTable(attachedDatabase, alias);
  }
}

class TabelaVendaData extends DataClass implements Insertable<TabelaVendaData> {
  final int id;
  final int estado;
  final int idFuncionario;
  final int idCliente;
  final int? quantidadeVendida;
  final int? idProduto;
  final DateTime data;
  final DateTime? dataLevantamentoCompra;
  final double total;
  final double parcela;
  const TabelaVendaData(
      {required this.id,
      required this.estado,
      required this.idFuncionario,
      required this.idCliente,
      this.quantidadeVendida,
      this.idProduto,
      required this.data,
      this.dataLevantamentoCompra,
      required this.total,
      required this.parcela});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_funcionario'] = Variable<int>(idFuncionario);
    map['id_cliente'] = Variable<int>(idCliente);
    if (!nullToAbsent || quantidadeVendida != null) {
      map['quantidade_vendida'] = Variable<int>(quantidadeVendida);
    }
    if (!nullToAbsent || idProduto != null) {
      map['id_produto'] = Variable<int>(idProduto);
    }
    map['data'] = Variable<DateTime>(data);
    if (!nullToAbsent || dataLevantamentoCompra != null) {
      map['data_levantamento_compra'] =
          Variable<DateTime>(dataLevantamentoCompra);
    }
    map['total'] = Variable<double>(total);
    map['parcela'] = Variable<double>(parcela);
    return map;
  }

  TabelaVendaCompanion toCompanion(bool nullToAbsent) {
    return TabelaVendaCompanion(
      id: Value(id),
      estado: Value(estado),
      idFuncionario: Value(idFuncionario),
      idCliente: Value(idCliente),
      quantidadeVendida: quantidadeVendida == null && nullToAbsent
          ? const Value.absent()
          : Value(quantidadeVendida),
      idProduto: idProduto == null && nullToAbsent
          ? const Value.absent()
          : Value(idProduto),
      data: Value(data),
      dataLevantamentoCompra: dataLevantamentoCompra == null && nullToAbsent
          ? const Value.absent()
          : Value(dataLevantamentoCompra),
      total: Value(total),
      parcela: Value(parcela),
    );
  }

  factory TabelaVendaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaVendaData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idCliente: serializer.fromJson<int>(json['idCliente']),
      quantidadeVendida: serializer.fromJson<int?>(json['quantidadeVendida']),
      idProduto: serializer.fromJson<int?>(json['idProduto']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataLevantamentoCompra:
          serializer.fromJson<DateTime?>(json['dataLevantamentoCompra']),
      total: serializer.fromJson<double>(json['total']),
      parcela: serializer.fromJson<double>(json['parcela']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idFuncionario': serializer.toJson<int>(idFuncionario),
      'idCliente': serializer.toJson<int>(idCliente),
      'quantidadeVendida': serializer.toJson<int?>(quantidadeVendida),
      'idProduto': serializer.toJson<int?>(idProduto),
      'data': serializer.toJson<DateTime>(data),
      'dataLevantamentoCompra':
          serializer.toJson<DateTime?>(dataLevantamentoCompra),
      'total': serializer.toJson<double>(total),
      'parcela': serializer.toJson<double>(parcela),
    };
  }

  TabelaVendaData copyWith(
          {int? id,
          int? estado,
          int? idFuncionario,
          int? idCliente,
          Value<int?> quantidadeVendida = const Value.absent(),
          Value<int?> idProduto = const Value.absent(),
          DateTime? data,
          Value<DateTime?> dataLevantamentoCompra = const Value.absent(),
          double? total,
          double? parcela}) =>
      TabelaVendaData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        idCliente: idCliente ?? this.idCliente,
        quantidadeVendida: quantidadeVendida.present
            ? quantidadeVendida.value
            : this.quantidadeVendida,
        idProduto: idProduto.present ? idProduto.value : this.idProduto,
        data: data ?? this.data,
        dataLevantamentoCompra: dataLevantamentoCompra.present
            ? dataLevantamentoCompra.value
            : this.dataLevantamentoCompra,
        total: total ?? this.total,
        parcela: parcela ?? this.parcela,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaVendaData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idCliente: $idCliente, ')
          ..write('quantidadeVendida: $quantidadeVendida, ')
          ..write('idProduto: $idProduto, ')
          ..write('data: $data, ')
          ..write('dataLevantamentoCompra: $dataLevantamentoCompra, ')
          ..write('total: $total, ')
          ..write('parcela: $parcela')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      estado,
      idFuncionario,
      idCliente,
      quantidadeVendida,
      idProduto,
      data,
      dataLevantamentoCompra,
      total,
      parcela);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaVendaData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.idCliente == this.idCliente &&
          other.quantidadeVendida == this.quantidadeVendida &&
          other.idProduto == this.idProduto &&
          other.data == this.data &&
          other.dataLevantamentoCompra == this.dataLevantamentoCompra &&
          other.total == this.total &&
          other.parcela == this.parcela);
}

class TabelaVendaCompanion extends UpdateCompanion<TabelaVendaData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idFuncionario;
  final Value<int> idCliente;
  final Value<int?> quantidadeVendida;
  final Value<int?> idProduto;
  final Value<DateTime> data;
  final Value<DateTime?> dataLevantamentoCompra;
  final Value<double> total;
  final Value<double> parcela;
  const TabelaVendaCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idFuncionario = const Value.absent(),
    this.idCliente = const Value.absent(),
    this.quantidadeVendida = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.data = const Value.absent(),
    this.dataLevantamentoCompra = const Value.absent(),
    this.total = const Value.absent(),
    this.parcela = const Value.absent(),
  });
  TabelaVendaCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idFuncionario,
    required int idCliente,
    this.quantidadeVendida = const Value.absent(),
    this.idProduto = const Value.absent(),
    required DateTime data,
    this.dataLevantamentoCompra = const Value.absent(),
    required double total,
    required double parcela,
  })  : estado = Value(estado),
        idFuncionario = Value(idFuncionario),
        idCliente = Value(idCliente),
        data = Value(data),
        total = Value(total),
        parcela = Value(parcela);
  static Insertable<TabelaVendaData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idFuncionario,
    Expression<int>? idCliente,
    Expression<int>? quantidadeVendida,
    Expression<int>? idProduto,
    Expression<DateTime>? data,
    Expression<DateTime>? dataLevantamentoCompra,
    Expression<double>? total,
    Expression<double>? parcela,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idFuncionario != null) 'id_funcionario': idFuncionario,
      if (idCliente != null) 'id_cliente': idCliente,
      if (quantidadeVendida != null) 'quantidade_vendida': quantidadeVendida,
      if (idProduto != null) 'id_produto': idProduto,
      if (data != null) 'data': data,
      if (dataLevantamentoCompra != null)
        'data_levantamento_compra': dataLevantamentoCompra,
      if (total != null) 'total': total,
      if (parcela != null) 'parcela': parcela,
    });
  }

  TabelaVendaCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idFuncionario,
      Value<int>? idCliente,
      Value<int?>? quantidadeVendida,
      Value<int?>? idProduto,
      Value<DateTime>? data,
      Value<DateTime?>? dataLevantamentoCompra,
      Value<double>? total,
      Value<double>? parcela}) {
    return TabelaVendaCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idFuncionario: idFuncionario ?? this.idFuncionario,
      idCliente: idCliente ?? this.idCliente,
      quantidadeVendida: quantidadeVendida ?? this.quantidadeVendida,
      idProduto: idProduto ?? this.idProduto,
      data: data ?? this.data,
      dataLevantamentoCompra:
          dataLevantamentoCompra ?? this.dataLevantamentoCompra,
      total: total ?? this.total,
      parcela: parcela ?? this.parcela,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idFuncionario.present) {
      map['id_funcionario'] = Variable<int>(idFuncionario.value);
    }
    if (idCliente.present) {
      map['id_cliente'] = Variable<int>(idCliente.value);
    }
    if (quantidadeVendida.present) {
      map['quantidade_vendida'] = Variable<int>(quantidadeVendida.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (dataLevantamentoCompra.present) {
      map['data_levantamento_compra'] =
          Variable<DateTime>(dataLevantamentoCompra.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (parcela.present) {
      map['parcela'] = Variable<double>(parcela.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaVendaCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idCliente: $idCliente, ')
          ..write('quantidadeVendida: $quantidadeVendida, ')
          ..write('idProduto: $idProduto, ')
          ..write('data: $data, ')
          ..write('dataLevantamentoCompra: $dataLevantamentoCompra, ')
          ..write('total: $total, ')
          ..write('parcela: $parcela')
          ..write(')'))
        .toString();
  }
}

class $TabelaVendaTable extends TabelaVenda
    with TableInfo<$TabelaVendaTable, TabelaVendaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaVendaTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idFuncionarioMeta =
      const VerificationMeta('idFuncionario');
  @override
  late final GeneratedColumn<int> idFuncionario = GeneratedColumn<int>(
      'id_funcionario', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idClienteMeta = const VerificationMeta('idCliente');
  @override
  late final GeneratedColumn<int> idCliente = GeneratedColumn<int>(
      'id_cliente', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeVendidaMeta =
      const VerificationMeta('quantidadeVendida');
  @override
  late final GeneratedColumn<int> quantidadeVendida = GeneratedColumn<int>(
      'quantidade_vendida', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _dataLevantamentoCompraMeta =
      const VerificationMeta('dataLevantamentoCompra');
  @override
  late final GeneratedColumn<DateTime> dataLevantamentoCompra =
      GeneratedColumn<DateTime>('data_levantamento_compra', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _parcelaMeta = const VerificationMeta('parcela');
  @override
  late final GeneratedColumn<double> parcela = GeneratedColumn<double>(
      'parcela', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        estado,
        idFuncionario,
        idCliente,
        quantidadeVendida,
        idProduto,
        data,
        dataLevantamentoCompra,
        total,
        parcela
      ];
  @override
  String get aliasedName => _alias ?? 'tabela_venda';
  @override
  String get actualTableName => 'tabela_venda';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaVendaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_funcionario')) {
      context.handle(
          _idFuncionarioMeta,
          idFuncionario.isAcceptableOrUnknown(
              data['id_funcionario']!, _idFuncionarioMeta));
    } else if (isInserting) {
      context.missing(_idFuncionarioMeta);
    }
    if (data.containsKey('id_cliente')) {
      context.handle(_idClienteMeta,
          idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta));
    } else if (isInserting) {
      context.missing(_idClienteMeta);
    }
    if (data.containsKey('quantidade_vendida')) {
      context.handle(
          _quantidadeVendidaMeta,
          quantidadeVendida.isAcceptableOrUnknown(
              data['quantidade_vendida']!, _quantidadeVendidaMeta));
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('data_levantamento_compra')) {
      context.handle(
          _dataLevantamentoCompraMeta,
          dataLevantamentoCompra.isAcceptableOrUnknown(
              data['data_levantamento_compra']!, _dataLevantamentoCompraMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('parcela')) {
      context.handle(_parcelaMeta,
          parcela.isAcceptableOrUnknown(data['parcela']!, _parcelaMeta));
    } else if (isInserting) {
      context.missing(_parcelaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaVendaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaVendaData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idFuncionario: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_funcionario'])!,
      idCliente: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_cliente'])!,
      quantidadeVendida: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade_vendida']),
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto']),
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      dataLevantamentoCompra: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}data_levantamento_compra']),
      total: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      parcela: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}parcela'])!,
    );
  }

  @override
  $TabelaVendaTable createAlias(String alias) {
    return $TabelaVendaTable(attachedDatabase, alias);
  }
}

class TabelaItemVendaData extends DataClass
    implements Insertable<TabelaItemVendaData> {
  final int id;
  final int estado;
  final int idProduto;
  final int idVenda;
  final int quantidade;
  final double total;
  final int desconto;
  const TabelaItemVendaData(
      {required this.id,
      required this.estado,
      required this.idProduto,
      required this.idVenda,
      required this.quantidade,
      required this.total,
      required this.desconto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_produto'] = Variable<int>(idProduto);
    map['id_venda'] = Variable<int>(idVenda);
    map['quantidade'] = Variable<int>(quantidade);
    map['total'] = Variable<double>(total);
    map['desconto'] = Variable<int>(desconto);
    return map;
  }

  TabelaItemVendaCompanion toCompanion(bool nullToAbsent) {
    return TabelaItemVendaCompanion(
      id: Value(id),
      estado: Value(estado),
      idProduto: Value(idProduto),
      idVenda: Value(idVenda),
      quantidade: Value(quantidade),
      total: Value(total),
      desconto: Value(desconto),
    );
  }

  factory TabelaItemVendaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaItemVendaData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idVenda: serializer.fromJson<int>(json['idVenda']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      total: serializer.fromJson<double>(json['total']),
      desconto: serializer.fromJson<int>(json['desconto']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idProduto': serializer.toJson<int>(idProduto),
      'idVenda': serializer.toJson<int>(idVenda),
      'quantidade': serializer.toJson<int>(quantidade),
      'total': serializer.toJson<double>(total),
      'desconto': serializer.toJson<int>(desconto),
    };
  }

  TabelaItemVendaData copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          int? idVenda,
          int? quantidade,
          double? total,
          int? desconto}) =>
      TabelaItemVendaData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        idVenda: idVenda ?? this.idVenda,
        quantidade: quantidade ?? this.quantidade,
        total: total ?? this.total,
        desconto: desconto ?? this.desconto,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaItemVendaData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idVenda: $idVenda, ')
          ..write('quantidade: $quantidade, ')
          ..write('total: $total, ')
          ..write('desconto: $desconto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, estado, idProduto, idVenda, quantidade, total, desconto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaItemVendaData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.idVenda == this.idVenda &&
          other.quantidade == this.quantidade &&
          other.total == this.total &&
          other.desconto == this.desconto);
}

class TabelaItemVendaCompanion extends UpdateCompanion<TabelaItemVendaData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idProduto;
  final Value<int> idVenda;
  final Value<int> quantidade;
  final Value<double> total;
  final Value<int> desconto;
  const TabelaItemVendaCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.idVenda = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.total = const Value.absent(),
    this.desconto = const Value.absent(),
  });
  TabelaItemVendaCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idProduto,
    required int idVenda,
    required int quantidade,
    required double total,
    required int desconto,
  })  : estado = Value(estado),
        idProduto = Value(idProduto),
        idVenda = Value(idVenda),
        quantidade = Value(quantidade),
        total = Value(total),
        desconto = Value(desconto);
  static Insertable<TabelaItemVendaData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idProduto,
    Expression<int>? idVenda,
    Expression<int>? quantidade,
    Expression<double>? total,
    Expression<int>? desconto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idProduto != null) 'id_produto': idProduto,
      if (idVenda != null) 'id_venda': idVenda,
      if (quantidade != null) 'quantidade': quantidade,
      if (total != null) 'total': total,
      if (desconto != null) 'desconto': desconto,
    });
  }

  TabelaItemVendaCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idProduto,
      Value<int>? idVenda,
      Value<int>? quantidade,
      Value<double>? total,
      Value<int>? desconto}) {
    return TabelaItemVendaCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idProduto: idProduto ?? this.idProduto,
      idVenda: idVenda ?? this.idVenda,
      quantidade: quantidade ?? this.quantidade,
      total: total ?? this.total,
      desconto: desconto ?? this.desconto,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (idVenda.present) {
      map['id_venda'] = Variable<int>(idVenda.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (desconto.present) {
      map['desconto'] = Variable<int>(desconto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaItemVendaCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idVenda: $idVenda, ')
          ..write('quantidade: $quantidade, ')
          ..write('total: $total, ')
          ..write('desconto: $desconto')
          ..write(')'))
        .toString();
  }
}

class $TabelaItemVendaTable extends TabelaItemVenda
    with TableInfo<$TabelaItemVendaTable, TabelaItemVendaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaItemVendaTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idVendaMeta = const VerificationMeta('idVenda');
  @override
  late final GeneratedColumn<int> idVenda = GeneratedColumn<int>(
      'id_venda', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeMeta = const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _descontoMeta = const VerificationMeta('desconto');
  @override
  late final GeneratedColumn<int> desconto = GeneratedColumn<int>(
      'desconto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, idProduto, idVenda, quantidade, total, desconto];
  @override
  String get aliasedName => _alias ?? 'tabela_item_venda';
  @override
  String get actualTableName => 'tabela_item_venda';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaItemVendaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('id_venda')) {
      context.handle(_idVendaMeta,
          idVenda.isAcceptableOrUnknown(data['id_venda']!, _idVendaMeta));
    } else if (isInserting) {
      context.missing(_idVendaMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('desconto')) {
      context.handle(_descontoMeta,
          desconto.isAcceptableOrUnknown(data['desconto']!, _descontoMeta));
    } else if (isInserting) {
      context.missing(_descontoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaItemVendaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaItemVendaData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      idVenda: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_venda'])!,
      quantidade: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      total: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      desconto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}desconto'])!,
    );
  }

  @override
  $TabelaItemVendaTable createAlias(String alias) {
    return $TabelaItemVendaTable(attachedDatabase, alias);
  }
}

class TabelaEntradaData extends DataClass
    implements Insertable<TabelaEntradaData> {
  final int id;
  final int estado;
  final int idProduto;
  final int idRececcao;
  final int quantidade;
  final DateTime data;
  final String? motivo;
  const TabelaEntradaData(
      {required this.id,
      required this.estado,
      required this.idProduto,
      required this.idRececcao,
      required this.quantidade,
      required this.data,
      this.motivo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_produto'] = Variable<int>(idProduto);
    map['id_receccao'] = Variable<int>(idRececcao);
    map['quantidade'] = Variable<int>(quantidade);
    map['data'] = Variable<DateTime>(data);
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = Variable<String>(motivo);
    }
    return map;
  }

  TabelaEntradaCompanion toCompanion(bool nullToAbsent) {
    return TabelaEntradaCompanion(
      id: Value(id),
      estado: Value(estado),
      idProduto: Value(idProduto),
      idRececcao: Value(idRececcao),
      quantidade: Value(quantidade),
      data: Value(data),
      motivo:
          motivo == null && nullToAbsent ? const Value.absent() : Value(motivo),
    );
  }

  factory TabelaEntradaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaEntradaData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idRececcao: serializer.fromJson<int>(json['idRececcao']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String?>(json['motivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idProduto': serializer.toJson<int>(idProduto),
      'idRececcao': serializer.toJson<int>(idRececcao),
      'quantidade': serializer.toJson<int>(quantidade),
      'data': serializer.toJson<DateTime>(data),
      'motivo': serializer.toJson<String?>(motivo),
    };
  }

  TabelaEntradaData copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          int? idRececcao,
          int? quantidade,
          DateTime? data,
          Value<String?> motivo = const Value.absent()}) =>
      TabelaEntradaData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        idRececcao: idRececcao ?? this.idRececcao,
        quantidade: quantidade ?? this.quantidade,
        data: data ?? this.data,
        motivo: motivo.present ? motivo.value : this.motivo,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaEntradaData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idRececcao: $idRececcao, ')
          ..write('quantidade: $quantidade, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, estado, idProduto, idRececcao, quantidade, data, motivo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaEntradaData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.idRececcao == this.idRececcao &&
          other.quantidade == this.quantidade &&
          other.data == this.data &&
          other.motivo == this.motivo);
}

class TabelaEntradaCompanion extends UpdateCompanion<TabelaEntradaData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idProduto;
  final Value<int> idRececcao;
  final Value<int> quantidade;
  final Value<DateTime> data;
  final Value<String?> motivo;
  const TabelaEntradaCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.idRececcao = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.data = const Value.absent(),
    this.motivo = const Value.absent(),
  });
  TabelaEntradaCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idProduto,
    required int idRececcao,
    required int quantidade,
    required DateTime data,
    this.motivo = const Value.absent(),
  })  : estado = Value(estado),
        idProduto = Value(idProduto),
        idRececcao = Value(idRececcao),
        quantidade = Value(quantidade),
        data = Value(data);
  static Insertable<TabelaEntradaData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idProduto,
    Expression<int>? idRececcao,
    Expression<int>? quantidade,
    Expression<DateTime>? data,
    Expression<String>? motivo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idProduto != null) 'id_produto': idProduto,
      if (idRececcao != null) 'id_receccao': idRececcao,
      if (quantidade != null) 'quantidade': quantidade,
      if (data != null) 'data': data,
      if (motivo != null) 'motivo': motivo,
    });
  }

  TabelaEntradaCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idProduto,
      Value<int>? idRececcao,
      Value<int>? quantidade,
      Value<DateTime>? data,
      Value<String?>? motivo}) {
    return TabelaEntradaCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idProduto: idProduto ?? this.idProduto,
      idRececcao: idRececcao ?? this.idRececcao,
      quantidade: quantidade ?? this.quantidade,
      data: data ?? this.data,
      motivo: motivo ?? this.motivo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (idRececcao.present) {
      map['id_receccao'] = Variable<int>(idRececcao.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaEntradaCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idRececcao: $idRececcao, ')
          ..write('quantidade: $quantidade, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }
}

class $TabelaEntradaTable extends TabelaEntrada
    with TableInfo<$TabelaEntradaTable, TabelaEntradaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaEntradaTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idRececcaoMeta = const VerificationMeta('idRececcao');
  @override
  late final GeneratedColumn<int> idRececcao = GeneratedColumn<int>(
      'id_receccao', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeMeta = const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
      'motivo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, idProduto, idRececcao, quantidade, data, motivo];
  @override
  String get aliasedName => _alias ?? 'tabela_entrada';
  @override
  String get actualTableName => 'tabela_entrada';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaEntradaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('id_receccao')) {
      context.handle(
          _idRececcaoMeta,
          idRececcao.isAcceptableOrUnknown(
              data['id_receccao']!, _idRececcaoMeta));
    } else if (isInserting) {
      context.missing(_idRececcaoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(_motivoMeta,
          motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaEntradaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaEntradaData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      idRececcao: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_receccao'])!,
      quantidade: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      motivo: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}motivo']),
    );
  }

  @override
  $TabelaEntradaTable createAlias(String alias) {
    return $TabelaEntradaTable(attachedDatabase, alias);
  }
}

class TabelaSaidaData extends DataClass implements Insertable<TabelaSaidaData> {
  final int id;
  final int estado;
  final int idProduto;
  final int? idVenda;
  final int? idDivida;
  final int quantidade;
  final DateTime data;
  final String? motivo;
  const TabelaSaidaData(
      {required this.id,
      required this.estado,
      required this.idProduto,
      this.idVenda,
      this.idDivida,
      required this.quantidade,
      required this.data,
      this.motivo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_produto'] = Variable<int>(idProduto);
    if (!nullToAbsent || idVenda != null) {
      map['id_venda'] = Variable<int>(idVenda);
    }
    if (!nullToAbsent || idDivida != null) {
      map['id_divida'] = Variable<int>(idDivida);
    }
    map['quantidade'] = Variable<int>(quantidade);
    map['data'] = Variable<DateTime>(data);
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = Variable<String>(motivo);
    }
    return map;
  }

  TabelaSaidaCompanion toCompanion(bool nullToAbsent) {
    return TabelaSaidaCompanion(
      id: Value(id),
      estado: Value(estado),
      idProduto: Value(idProduto),
      idVenda: idVenda == null && nullToAbsent
          ? const Value.absent()
          : Value(idVenda),
      idDivida: idDivida == null && nullToAbsent
          ? const Value.absent()
          : Value(idDivida),
      quantidade: Value(quantidade),
      data: Value(data),
      motivo:
          motivo == null && nullToAbsent ? const Value.absent() : Value(motivo),
    );
  }

  factory TabelaSaidaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaSaidaData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      idVenda: serializer.fromJson<int?>(json['idVenda']),
      idDivida: serializer.fromJson<int?>(json['idDivida']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String?>(json['motivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idProduto': serializer.toJson<int>(idProduto),
      'idVenda': serializer.toJson<int?>(idVenda),
      'idDivida': serializer.toJson<int?>(idDivida),
      'quantidade': serializer.toJson<int>(quantidade),
      'data': serializer.toJson<DateTime>(data),
      'motivo': serializer.toJson<String?>(motivo),
    };
  }

  TabelaSaidaData copyWith(
          {int? id,
          int? estado,
          int? idProduto,
          Value<int?> idVenda = const Value.absent(),
          Value<int?> idDivida = const Value.absent(),
          int? quantidade,
          DateTime? data,
          Value<String?> motivo = const Value.absent()}) =>
      TabelaSaidaData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        idVenda: idVenda.present ? idVenda.value : this.idVenda,
        idDivida: idDivida.present ? idDivida.value : this.idDivida,
        quantidade: quantidade ?? this.quantidade,
        data: data ?? this.data,
        motivo: motivo.present ? motivo.value : this.motivo,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaSaidaData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idVenda: $idVenda, ')
          ..write('idDivida: $idDivida, ')
          ..write('quantidade: $quantidade, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, estado, idProduto, idVenda, idDivida, quantidade, data, motivo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaSaidaData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.idVenda == this.idVenda &&
          other.idDivida == this.idDivida &&
          other.quantidade == this.quantidade &&
          other.data == this.data &&
          other.motivo == this.motivo);
}

class TabelaSaidaCompanion extends UpdateCompanion<TabelaSaidaData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idProduto;
  final Value<int?> idVenda;
  final Value<int?> idDivida;
  final Value<int> quantidade;
  final Value<DateTime> data;
  final Value<String?> motivo;
  const TabelaSaidaCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.idVenda = const Value.absent(),
    this.idDivida = const Value.absent(),
    this.quantidade = const Value.absent(),
    this.data = const Value.absent(),
    this.motivo = const Value.absent(),
  });
  TabelaSaidaCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idProduto,
    this.idVenda = const Value.absent(),
    this.idDivida = const Value.absent(),
    required int quantidade,
    required DateTime data,
    this.motivo = const Value.absent(),
  })  : estado = Value(estado),
        idProduto = Value(idProduto),
        quantidade = Value(quantidade),
        data = Value(data);
  static Insertable<TabelaSaidaData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idProduto,
    Expression<int>? idVenda,
    Expression<int>? idDivida,
    Expression<int>? quantidade,
    Expression<DateTime>? data,
    Expression<String>? motivo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idProduto != null) 'id_produto': idProduto,
      if (idVenda != null) 'id_venda': idVenda,
      if (idDivida != null) 'id_divida': idDivida,
      if (quantidade != null) 'quantidade': quantidade,
      if (data != null) 'data': data,
      if (motivo != null) 'motivo': motivo,
    });
  }

  TabelaSaidaCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idProduto,
      Value<int?>? idVenda,
      Value<int?>? idDivida,
      Value<int>? quantidade,
      Value<DateTime>? data,
      Value<String?>? motivo}) {
    return TabelaSaidaCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idProduto: idProduto ?? this.idProduto,
      idVenda: idVenda ?? this.idVenda,
      idDivida: idDivida ?? this.idDivida,
      quantidade: quantidade ?? this.quantidade,
      data: data ?? this.data,
      motivo: motivo ?? this.motivo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (idVenda.present) {
      map['id_venda'] = Variable<int>(idVenda.value);
    }
    if (idDivida.present) {
      map['id_divida'] = Variable<int>(idDivida.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaSaidaCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('idVenda: $idVenda, ')
          ..write('idDivida: $idDivida, ')
          ..write('quantidade: $quantidade, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }
}

class $TabelaSaidaTable extends TabelaSaida
    with TableInfo<$TabelaSaidaTable, TabelaSaidaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaSaidaTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idVendaMeta = const VerificationMeta('idVenda');
  @override
  late final GeneratedColumn<int> idVenda = GeneratedColumn<int>(
      'id_venda', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _idDividaMeta = const VerificationMeta('idDivida');
  @override
  late final GeneratedColumn<int> idDivida = GeneratedColumn<int>(
      'id_divida', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _quantidadeMeta = const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
      'motivo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, idProduto, idVenda, idDivida, quantidade, data, motivo];
  @override
  String get aliasedName => _alias ?? 'tabela_saida';
  @override
  String get actualTableName => 'tabela_saida';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaSaidaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('id_venda')) {
      context.handle(_idVendaMeta,
          idVenda.isAcceptableOrUnknown(data['id_venda']!, _idVendaMeta));
    }
    if (data.containsKey('id_divida')) {
      context.handle(_idDividaMeta,
          idDivida.isAcceptableOrUnknown(data['id_divida']!, _idDividaMeta));
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(_motivoMeta,
          motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaSaidaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaSaidaData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      idVenda: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_venda']),
      idDivida: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_divida']),
      quantidade: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      motivo: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}motivo']),
    );
  }

  @override
  $TabelaSaidaTable createAlias(String alias) {
    return $TabelaSaidaTable(attachedDatabase, alias);
  }
}

class TabelaStockData extends DataClass implements Insertable<TabelaStockData> {
  final int id;
  final int estado;
  final int idProduto;
  final int quantidade;
  const TabelaStockData(
      {required this.id,
      required this.estado,
      required this.idProduto,
      required this.quantidade});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_produto'] = Variable<int>(idProduto);
    map['quantidade'] = Variable<int>(quantidade);
    return map;
  }

  TabelaStockCompanion toCompanion(bool nullToAbsent) {
    return TabelaStockCompanion(
      id: Value(id),
      estado: Value(estado),
      idProduto: Value(idProduto),
      quantidade: Value(quantidade),
    );
  }

  factory TabelaStockData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaStockData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidade: serializer.fromJson<int>(json['quantidade']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idProduto': serializer.toJson<int>(idProduto),
      'quantidade': serializer.toJson<int>(quantidade),
    };
  }

  TabelaStockData copyWith(
          {int? id, int? estado, int? idProduto, int? quantidade}) =>
      TabelaStockData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idProduto: idProduto ?? this.idProduto,
        quantidade: quantidade ?? this.quantidade,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaStockData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idProduto, quantidade);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaStockData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idProduto == this.idProduto &&
          other.quantidade == this.quantidade);
}

class TabelaStockCompanion extends UpdateCompanion<TabelaStockData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idProduto;
  final Value<int> quantidade;
  const TabelaStockCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.quantidade = const Value.absent(),
  });
  TabelaStockCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idProduto,
    required int quantidade,
  })  : estado = Value(estado),
        idProduto = Value(idProduto),
        quantidade = Value(quantidade);
  static Insertable<TabelaStockData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idProduto,
    Expression<int>? quantidade,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idProduto != null) 'id_produto': idProduto,
      if (quantidade != null) 'quantidade': quantidade,
    });
  }

  TabelaStockCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idProduto,
      Value<int>? quantidade}) {
    return TabelaStockCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idProduto: idProduto ?? this.idProduto,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (quantidade.present) {
      map['quantidade'] = Variable<int>(quantidade.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaStockCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidade: $quantidade')
          ..write(')'))
        .toString();
  }
}

class $TabelaStockTable extends TabelaStock
    with TableInfo<$TabelaStockTable, TabelaStockData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaStockTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeMeta = const VerificationMeta('quantidade');
  @override
  late final GeneratedColumn<int> quantidade = GeneratedColumn<int>(
      'quantidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, estado, idProduto, quantidade];
  @override
  String get aliasedName => _alias ?? 'tabela_stock';
  @override
  String get actualTableName => 'tabela_stock';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaStockData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
          _quantidadeMeta,
          quantidade.isAcceptableOrUnknown(
              data['quantidade']!, _quantidadeMeta));
    } else if (isInserting) {
      context.missing(_quantidadeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaStockData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaStockData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      quantidade: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade'])!,
    );
  }

  @override
  $TabelaStockTable createAlias(String alias) {
    return $TabelaStockTable(attachedDatabase, alias);
  }
}

class TabelaRececcaoData extends DataClass
    implements Insertable<TabelaRececcaoData> {
  final int id;
  final int estado;
  final int idFuncionario;
  final int? idPagante;
  final int idProduto;
  final int quantidadePorLotes;
  final int quantidadeLotes;
  final double precoLote;
  final double custoAquisicao;
  final DateTime data;
  final DateTime? dataPagamento;
  final bool? pagavel;
  final bool? paga;
  const TabelaRececcaoData(
      {required this.id,
      required this.estado,
      required this.idFuncionario,
      this.idPagante,
      required this.idProduto,
      required this.quantidadePorLotes,
      required this.quantidadeLotes,
      required this.precoLote,
      required this.custoAquisicao,
      required this.data,
      this.dataPagamento,
      this.pagavel,
      this.paga});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_funcionario'] = Variable<int>(idFuncionario);
    if (!nullToAbsent || idPagante != null) {
      map['id_pagante'] = Variable<int>(idPagante);
    }
    map['id_produto'] = Variable<int>(idProduto);
    map['quantidade_por_lotes'] = Variable<int>(quantidadePorLotes);
    map['quantidade_lotes'] = Variable<int>(quantidadeLotes);
    map['preco_lote'] = Variable<double>(precoLote);
    map['custo_aquisicao'] = Variable<double>(custoAquisicao);
    map['data'] = Variable<DateTime>(data);
    if (!nullToAbsent || dataPagamento != null) {
      map['data_pagamento'] = Variable<DateTime>(dataPagamento);
    }
    if (!nullToAbsent || pagavel != null) {
      map['pagavel'] = Variable<bool>(pagavel);
    }
    if (!nullToAbsent || paga != null) {
      map['paga'] = Variable<bool>(paga);
    }
    return map;
  }

  TabelaRececcaoCompanion toCompanion(bool nullToAbsent) {
    return TabelaRececcaoCompanion(
      id: Value(id),
      estado: Value(estado),
      idFuncionario: Value(idFuncionario),
      idPagante: idPagante == null && nullToAbsent
          ? const Value.absent()
          : Value(idPagante),
      idProduto: Value(idProduto),
      quantidadePorLotes: Value(quantidadePorLotes),
      quantidadeLotes: Value(quantidadeLotes),
      precoLote: Value(precoLote),
      custoAquisicao: Value(custoAquisicao),
      data: Value(data),
      dataPagamento: dataPagamento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataPagamento),
      pagavel: pagavel == null && nullToAbsent
          ? const Value.absent()
          : Value(pagavel),
      paga: paga == null && nullToAbsent ? const Value.absent() : Value(paga),
    );
  }

  factory TabelaRececcaoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaRececcaoData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idPagante: serializer.fromJson<int?>(json['idPagante']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      quantidadePorLotes: serializer.fromJson<int>(json['quantidadePorLotes']),
      quantidadeLotes: serializer.fromJson<int>(json['quantidadeLotes']),
      precoLote: serializer.fromJson<double>(json['precoLote']),
      custoAquisicao: serializer.fromJson<double>(json['custoAquisicao']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataPagamento: serializer.fromJson<DateTime?>(json['dataPagamento']),
      pagavel: serializer.fromJson<bool?>(json['pagavel']),
      paga: serializer.fromJson<bool?>(json['paga']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idFuncionario': serializer.toJson<int>(idFuncionario),
      'idPagante': serializer.toJson<int?>(idPagante),
      'idProduto': serializer.toJson<int>(idProduto),
      'quantidadePorLotes': serializer.toJson<int>(quantidadePorLotes),
      'quantidadeLotes': serializer.toJson<int>(quantidadeLotes),
      'precoLote': serializer.toJson<double>(precoLote),
      'custoAquisicao': serializer.toJson<double>(custoAquisicao),
      'data': serializer.toJson<DateTime>(data),
      'dataPagamento': serializer.toJson<DateTime?>(dataPagamento),
      'pagavel': serializer.toJson<bool?>(pagavel),
      'paga': serializer.toJson<bool?>(paga),
    };
  }

  TabelaRececcaoData copyWith(
          {int? id,
          int? estado,
          int? idFuncionario,
          Value<int?> idPagante = const Value.absent(),
          int? idProduto,
          int? quantidadePorLotes,
          int? quantidadeLotes,
          double? precoLote,
          double? custoAquisicao,
          DateTime? data,
          Value<DateTime?> dataPagamento = const Value.absent(),
          Value<bool?> pagavel = const Value.absent(),
          Value<bool?> paga = const Value.absent()}) =>
      TabelaRececcaoData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        idPagante: idPagante.present ? idPagante.value : this.idPagante,
        idProduto: idProduto ?? this.idProduto,
        quantidadePorLotes: quantidadePorLotes ?? this.quantidadePorLotes,
        quantidadeLotes: quantidadeLotes ?? this.quantidadeLotes,
        precoLote: precoLote ?? this.precoLote,
        custoAquisicao: custoAquisicao ?? this.custoAquisicao,
        data: data ?? this.data,
        dataPagamento:
            dataPagamento.present ? dataPagamento.value : this.dataPagamento,
        pagavel: pagavel.present ? pagavel.value : this.pagavel,
        paga: paga.present ? paga.value : this.paga,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaRececcaoData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idPagante: $idPagante, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidadePorLotes: $quantidadePorLotes, ')
          ..write('quantidadeLotes: $quantidadeLotes, ')
          ..write('precoLote: $precoLote, ')
          ..write('custoAquisicao: $custoAquisicao, ')
          ..write('data: $data, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('pagavel: $pagavel, ')
          ..write('paga: $paga')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      estado,
      idFuncionario,
      idPagante,
      idProduto,
      quantidadePorLotes,
      quantidadeLotes,
      precoLote,
      custoAquisicao,
      data,
      dataPagamento,
      pagavel,
      paga);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaRececcaoData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.idPagante == this.idPagante &&
          other.idProduto == this.idProduto &&
          other.quantidadePorLotes == this.quantidadePorLotes &&
          other.quantidadeLotes == this.quantidadeLotes &&
          other.precoLote == this.precoLote &&
          other.custoAquisicao == this.custoAquisicao &&
          other.data == this.data &&
          other.dataPagamento == this.dataPagamento &&
          other.pagavel == this.pagavel &&
          other.paga == this.paga);
}

class TabelaRececcaoCompanion extends UpdateCompanion<TabelaRececcaoData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idFuncionario;
  final Value<int?> idPagante;
  final Value<int> idProduto;
  final Value<int> quantidadePorLotes;
  final Value<int> quantidadeLotes;
  final Value<double> precoLote;
  final Value<double> custoAquisicao;
  final Value<DateTime> data;
  final Value<DateTime?> dataPagamento;
  final Value<bool?> pagavel;
  final Value<bool?> paga;
  const TabelaRececcaoCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idFuncionario = const Value.absent(),
    this.idPagante = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.quantidadePorLotes = const Value.absent(),
    this.quantidadeLotes = const Value.absent(),
    this.precoLote = const Value.absent(),
    this.custoAquisicao = const Value.absent(),
    this.data = const Value.absent(),
    this.dataPagamento = const Value.absent(),
    this.pagavel = const Value.absent(),
    this.paga = const Value.absent(),
  });
  TabelaRececcaoCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idFuncionario,
    this.idPagante = const Value.absent(),
    required int idProduto,
    required int quantidadePorLotes,
    required int quantidadeLotes,
    required double precoLote,
    required double custoAquisicao,
    required DateTime data,
    this.dataPagamento = const Value.absent(),
    this.pagavel = const Value.absent(),
    this.paga = const Value.absent(),
  })  : estado = Value(estado),
        idFuncionario = Value(idFuncionario),
        idProduto = Value(idProduto),
        quantidadePorLotes = Value(quantidadePorLotes),
        quantidadeLotes = Value(quantidadeLotes),
        precoLote = Value(precoLote),
        custoAquisicao = Value(custoAquisicao),
        data = Value(data);
  static Insertable<TabelaRececcaoData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idFuncionario,
    Expression<int>? idPagante,
    Expression<int>? idProduto,
    Expression<int>? quantidadePorLotes,
    Expression<int>? quantidadeLotes,
    Expression<double>? precoLote,
    Expression<double>? custoAquisicao,
    Expression<DateTime>? data,
    Expression<DateTime>? dataPagamento,
    Expression<bool>? pagavel,
    Expression<bool>? paga,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idFuncionario != null) 'id_funcionario': idFuncionario,
      if (idPagante != null) 'id_pagante': idPagante,
      if (idProduto != null) 'id_produto': idProduto,
      if (quantidadePorLotes != null)
        'quantidade_por_lotes': quantidadePorLotes,
      if (quantidadeLotes != null) 'quantidade_lotes': quantidadeLotes,
      if (precoLote != null) 'preco_lote': precoLote,
      if (custoAquisicao != null) 'custo_aquisicao': custoAquisicao,
      if (data != null) 'data': data,
      if (dataPagamento != null) 'data_pagamento': dataPagamento,
      if (pagavel != null) 'pagavel': pagavel,
      if (paga != null) 'paga': paga,
    });
  }

  TabelaRececcaoCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idFuncionario,
      Value<int?>? idPagante,
      Value<int>? idProduto,
      Value<int>? quantidadePorLotes,
      Value<int>? quantidadeLotes,
      Value<double>? precoLote,
      Value<double>? custoAquisicao,
      Value<DateTime>? data,
      Value<DateTime?>? dataPagamento,
      Value<bool?>? pagavel,
      Value<bool?>? paga}) {
    return TabelaRececcaoCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idFuncionario: idFuncionario ?? this.idFuncionario,
      idPagante: idPagante ?? this.idPagante,
      idProduto: idProduto ?? this.idProduto,
      quantidadePorLotes: quantidadePorLotes ?? this.quantidadePorLotes,
      quantidadeLotes: quantidadeLotes ?? this.quantidadeLotes,
      precoLote: precoLote ?? this.precoLote,
      custoAquisicao: custoAquisicao ?? this.custoAquisicao,
      data: data ?? this.data,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      pagavel: pagavel ?? this.pagavel,
      paga: paga ?? this.paga,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idFuncionario.present) {
      map['id_funcionario'] = Variable<int>(idFuncionario.value);
    }
    if (idPagante.present) {
      map['id_pagante'] = Variable<int>(idPagante.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (quantidadePorLotes.present) {
      map['quantidade_por_lotes'] = Variable<int>(quantidadePorLotes.value);
    }
    if (quantidadeLotes.present) {
      map['quantidade_lotes'] = Variable<int>(quantidadeLotes.value);
    }
    if (precoLote.present) {
      map['preco_lote'] = Variable<double>(precoLote.value);
    }
    if (custoAquisicao.present) {
      map['custo_aquisicao'] = Variable<double>(custoAquisicao.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (dataPagamento.present) {
      map['data_pagamento'] = Variable<DateTime>(dataPagamento.value);
    }
    if (pagavel.present) {
      map['pagavel'] = Variable<bool>(pagavel.value);
    }
    if (paga.present) {
      map['paga'] = Variable<bool>(paga.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaRececcaoCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idPagante: $idPagante, ')
          ..write('idProduto: $idProduto, ')
          ..write('quantidadePorLotes: $quantidadePorLotes, ')
          ..write('quantidadeLotes: $quantidadeLotes, ')
          ..write('precoLote: $precoLote, ')
          ..write('custoAquisicao: $custoAquisicao, ')
          ..write('data: $data, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('pagavel: $pagavel, ')
          ..write('paga: $paga')
          ..write(')'))
        .toString();
  }
}

class $TabelaRececcaoTable extends TabelaRececcao
    with TableInfo<$TabelaRececcaoTable, TabelaRececcaoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaRececcaoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idFuncionarioMeta =
      const VerificationMeta('idFuncionario');
  @override
  late final GeneratedColumn<int> idFuncionario = GeneratedColumn<int>(
      'id_funcionario', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idPaganteMeta = const VerificationMeta('idPagante');
  @override
  late final GeneratedColumn<int> idPagante = GeneratedColumn<int>(
      'id_pagante', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadePorLotesMeta =
      const VerificationMeta('quantidadePorLotes');
  @override
  late final GeneratedColumn<int> quantidadePorLotes = GeneratedColumn<int>(
      'quantidade_por_lotes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeLotesMeta =
      const VerificationMeta('quantidadeLotes');
  @override
  late final GeneratedColumn<int> quantidadeLotes = GeneratedColumn<int>(
      'quantidade_lotes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _precoLoteMeta = const VerificationMeta('precoLote');
  @override
  late final GeneratedColumn<double> precoLote = GeneratedColumn<double>(
      'preco_lote', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _custoAquisicaoMeta =
      const VerificationMeta('custoAquisicao');
  @override
  late final GeneratedColumn<double> custoAquisicao = GeneratedColumn<double>(
      'custo_aquisicao', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _dataPagamentoMeta =
      const VerificationMeta('dataPagamento');
  @override
  late final GeneratedColumn<DateTime> dataPagamento =
      GeneratedColumn<DateTime>('data_pagamento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _pagavelMeta = const VerificationMeta('pagavel');
  @override
  late final GeneratedColumn<bool> pagavel = GeneratedColumn<bool>(
      'pagavel', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("pagavel" IN (0, 1))');
  final VerificationMeta _pagaMeta = const VerificationMeta('paga');
  @override
  late final GeneratedColumn<bool> paga = GeneratedColumn<bool>(
      'paga', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("paga" IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        estado,
        idFuncionario,
        idPagante,
        idProduto,
        quantidadePorLotes,
        quantidadeLotes,
        precoLote,
        custoAquisicao,
        data,
        dataPagamento,
        pagavel,
        paga
      ];
  @override
  String get aliasedName => _alias ?? 'tabela_receccao';
  @override
  String get actualTableName => 'tabela_receccao';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaRececcaoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_funcionario')) {
      context.handle(
          _idFuncionarioMeta,
          idFuncionario.isAcceptableOrUnknown(
              data['id_funcionario']!, _idFuncionarioMeta));
    } else if (isInserting) {
      context.missing(_idFuncionarioMeta);
    }
    if (data.containsKey('id_pagante')) {
      context.handle(_idPaganteMeta,
          idPagante.isAcceptableOrUnknown(data['id_pagante']!, _idPaganteMeta));
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('quantidade_por_lotes')) {
      context.handle(
          _quantidadePorLotesMeta,
          quantidadePorLotes.isAcceptableOrUnknown(
              data['quantidade_por_lotes']!, _quantidadePorLotesMeta));
    } else if (isInserting) {
      context.missing(_quantidadePorLotesMeta);
    }
    if (data.containsKey('quantidade_lotes')) {
      context.handle(
          _quantidadeLotesMeta,
          quantidadeLotes.isAcceptableOrUnknown(
              data['quantidade_lotes']!, _quantidadeLotesMeta));
    } else if (isInserting) {
      context.missing(_quantidadeLotesMeta);
    }
    if (data.containsKey('preco_lote')) {
      context.handle(_precoLoteMeta,
          precoLote.isAcceptableOrUnknown(data['preco_lote']!, _precoLoteMeta));
    } else if (isInserting) {
      context.missing(_precoLoteMeta);
    }
    if (data.containsKey('custo_aquisicao')) {
      context.handle(
          _custoAquisicaoMeta,
          custoAquisicao.isAcceptableOrUnknown(
              data['custo_aquisicao']!, _custoAquisicaoMeta));
    } else if (isInserting) {
      context.missing(_custoAquisicaoMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('data_pagamento')) {
      context.handle(
          _dataPagamentoMeta,
          dataPagamento.isAcceptableOrUnknown(
              data['data_pagamento']!, _dataPagamentoMeta));
    }
    if (data.containsKey('pagavel')) {
      context.handle(_pagavelMeta,
          pagavel.isAcceptableOrUnknown(data['pagavel']!, _pagavelMeta));
    }
    if (data.containsKey('paga')) {
      context.handle(
          _pagaMeta, paga.isAcceptableOrUnknown(data['paga']!, _pagaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaRececcaoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaRececcaoData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idFuncionario: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_funcionario'])!,
      idPagante: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_pagante']),
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      quantidadePorLotes: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}quantidade_por_lotes'])!,
      quantidadeLotes: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade_lotes'])!,
      precoLote: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}preco_lote'])!,
      custoAquisicao: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}custo_aquisicao'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      dataPagamento: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_pagamento']),
      pagavel: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}pagavel']),
      paga: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}paga']),
    );
  }

  @override
  $TabelaRececcaoTable createAlias(String alias) {
    return $TabelaRececcaoTable(attachedDatabase, alias);
  }
}

class TabelaClienteData extends DataClass
    implements Insertable<TabelaClienteData> {
  final int id;
  final int estado;
  final String nome;
  final String numero;
  const TabelaClienteData(
      {required this.id,
      required this.estado,
      required this.nome,
      required this.numero});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['nome'] = Variable<String>(nome);
    map['numero'] = Variable<String>(numero);
    return map;
  }

  TabelaClienteCompanion toCompanion(bool nullToAbsent) {
    return TabelaClienteCompanion(
      id: Value(id),
      estado: Value(estado),
      nome: Value(nome),
      numero: Value(numero),
    );
  }

  factory TabelaClienteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaClienteData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      numero: serializer.fromJson<String>(json['numero']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'nome': serializer.toJson<String>(nome),
      'numero': serializer.toJson<String>(numero),
    };
  }

  TabelaClienteData copyWith(
          {int? id, int? estado, String? nome, String? numero}) =>
      TabelaClienteData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        nome: nome ?? this.nome,
        numero: numero ?? this.numero,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaClienteData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('numero: $numero')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, nome, numero);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaClienteData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.nome == this.nome &&
          other.numero == this.numero);
}

class TabelaClienteCompanion extends UpdateCompanion<TabelaClienteData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<String> nome;
  final Value<String> numero;
  const TabelaClienteCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.nome = const Value.absent(),
    this.numero = const Value.absent(),
  });
  TabelaClienteCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required String nome,
    required String numero,
  })  : estado = Value(estado),
        nome = Value(nome),
        numero = Value(numero);
  static Insertable<TabelaClienteData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<String>? nome,
    Expression<String>? numero,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (nome != null) 'nome': nome,
      if (numero != null) 'numero': numero,
    });
  }

  TabelaClienteCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<String>? nome,
      Value<String>? numero}) {
    return TabelaClienteCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      nome: nome ?? this.nome,
      numero: numero ?? this.numero,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaClienteCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('numero: $numero')
          ..write(')'))
        .toString();
  }
}

class $TabelaClienteTable extends TabelaCliente
    with TableInfo<$TabelaClienteTable, TabelaClienteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaClienteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
      'numero', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, estado, nome, numero];
  @override
  String get aliasedName => _alias ?? 'tabela_cliente';
  @override
  String get actualTableName => 'tabela_cliente';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaClienteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(_numeroMeta,
          numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta));
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaClienteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaClienteData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      nome: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      numero: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}numero'])!,
    );
  }

  @override
  $TabelaClienteTable createAlias(String alias) {
    return $TabelaClienteTable(attachedDatabase, alias);
  }
}

class TabelaFormaPagamentoData extends DataClass
    implements Insertable<TabelaFormaPagamentoData> {
  final int id;
  final int estado;
  final int tipo;
  final String descricao;
  const TabelaFormaPagamentoData(
      {required this.id,
      required this.estado,
      required this.tipo,
      required this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['tipo'] = Variable<int>(tipo);
    map['descricao'] = Variable<String>(descricao);
    return map;
  }

  TabelaFormaPagamentoCompanion toCompanion(bool nullToAbsent) {
    return TabelaFormaPagamentoCompanion(
      id: Value(id),
      estado: Value(estado),
      tipo: Value(tipo),
      descricao: Value(descricao),
    );
  }

  factory TabelaFormaPagamentoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaFormaPagamentoData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      tipo: serializer.fromJson<int>(json['tipo']),
      descricao: serializer.fromJson<String>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'tipo': serializer.toJson<int>(tipo),
      'descricao': serializer.toJson<String>(descricao),
    };
  }

  TabelaFormaPagamentoData copyWith(
          {int? id, int? estado, int? tipo, String? descricao}) =>
      TabelaFormaPagamentoData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        tipo: tipo ?? this.tipo,
        descricao: descricao ?? this.descricao,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaFormaPagamentoData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('tipo: $tipo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, tipo, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaFormaPagamentoData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.tipo == this.tipo &&
          other.descricao == this.descricao);
}

class TabelaFormaPagamentoCompanion
    extends UpdateCompanion<TabelaFormaPagamentoData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> tipo;
  final Value<String> descricao;
  const TabelaFormaPagamentoCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.tipo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  TabelaFormaPagamentoCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int tipo,
    required String descricao,
  })  : estado = Value(estado),
        tipo = Value(tipo),
        descricao = Value(descricao);
  static Insertable<TabelaFormaPagamentoData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? tipo,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (tipo != null) 'tipo': tipo,
      if (descricao != null) 'descricao': descricao,
    });
  }

  TabelaFormaPagamentoCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? tipo,
      Value<String>? descricao}) {
    return TabelaFormaPagamentoCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      tipo: tipo ?? this.tipo,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<int>(tipo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaFormaPagamentoCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('tipo: $tipo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $TabelaFormaPagamentoTable extends TabelaFormaPagamento
    with TableInfo<$TabelaFormaPagamentoTable, TabelaFormaPagamentoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaFormaPagamentoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<int> tipo = GeneratedColumn<int>(
      'tipo', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _descricaoMeta = const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, estado, tipo, descricao];
  @override
  String get aliasedName => _alias ?? 'tabela_forma_pagamento';
  @override
  String get actualTableName => 'tabela_forma_pagamento';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaFormaPagamentoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    } else if (isInserting) {
      context.missing(_descricaoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaFormaPagamentoData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaFormaPagamentoData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      tipo: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}tipo'])!,
      descricao: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
    );
  }

  @override
  $TabelaFormaPagamentoTable createAlias(String alias) {
    return $TabelaFormaPagamentoTable(attachedDatabase, alias);
  }
}

class TabelaPagamentoData extends DataClass
    implements Insertable<TabelaPagamentoData> {
  final int id;
  final int idFormaPagamento;
  final int estado;
  final int idVenda;
  final double valor;
  const TabelaPagamentoData(
      {required this.id,
      required this.idFormaPagamento,
      required this.estado,
      required this.idVenda,
      required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_forma_pagamento'] = Variable<int>(idFormaPagamento);
    map['estado'] = Variable<int>(estado);
    map['id_venda'] = Variable<int>(idVenda);
    map['valor'] = Variable<double>(valor);
    return map;
  }

  TabelaPagamentoCompanion toCompanion(bool nullToAbsent) {
    return TabelaPagamentoCompanion(
      id: Value(id),
      idFormaPagamento: Value(idFormaPagamento),
      estado: Value(estado),
      idVenda: Value(idVenda),
      valor: Value(valor),
    );
  }

  factory TabelaPagamentoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaPagamentoData(
      id: serializer.fromJson<int>(json['id']),
      idFormaPagamento: serializer.fromJson<int>(json['idFormaPagamento']),
      estado: serializer.fromJson<int>(json['estado']),
      idVenda: serializer.fromJson<int>(json['idVenda']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idFormaPagamento': serializer.toJson<int>(idFormaPagamento),
      'estado': serializer.toJson<int>(estado),
      'idVenda': serializer.toJson<int>(idVenda),
      'valor': serializer.toJson<double>(valor),
    };
  }

  TabelaPagamentoData copyWith(
          {int? id,
          int? idFormaPagamento,
          int? estado,
          int? idVenda,
          double? valor}) =>
      TabelaPagamentoData(
        id: id ?? this.id,
        idFormaPagamento: idFormaPagamento ?? this.idFormaPagamento,
        estado: estado ?? this.estado,
        idVenda: idVenda ?? this.idVenda,
        valor: valor ?? this.valor,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaPagamentoData(')
          ..write('id: $id, ')
          ..write('idFormaPagamento: $idFormaPagamento, ')
          ..write('estado: $estado, ')
          ..write('idVenda: $idVenda, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idFormaPagamento, estado, idVenda, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaPagamentoData &&
          other.id == this.id &&
          other.idFormaPagamento == this.idFormaPagamento &&
          other.estado == this.estado &&
          other.idVenda == this.idVenda &&
          other.valor == this.valor);
}

class TabelaPagamentoCompanion extends UpdateCompanion<TabelaPagamentoData> {
  final Value<int> id;
  final Value<int> idFormaPagamento;
  final Value<int> estado;
  final Value<int> idVenda;
  final Value<double> valor;
  const TabelaPagamentoCompanion({
    this.id = const Value.absent(),
    this.idFormaPagamento = const Value.absent(),
    this.estado = const Value.absent(),
    this.idVenda = const Value.absent(),
    this.valor = const Value.absent(),
  });
  TabelaPagamentoCompanion.insert({
    this.id = const Value.absent(),
    required int idFormaPagamento,
    required int estado,
    required int idVenda,
    required double valor,
  })  : idFormaPagamento = Value(idFormaPagamento),
        estado = Value(estado),
        idVenda = Value(idVenda),
        valor = Value(valor);
  static Insertable<TabelaPagamentoData> custom({
    Expression<int>? id,
    Expression<int>? idFormaPagamento,
    Expression<int>? estado,
    Expression<int>? idVenda,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idFormaPagamento != null) 'id_forma_pagamento': idFormaPagamento,
      if (estado != null) 'estado': estado,
      if (idVenda != null) 'id_venda': idVenda,
      if (valor != null) 'valor': valor,
    });
  }

  TabelaPagamentoCompanion copyWith(
      {Value<int>? id,
      Value<int>? idFormaPagamento,
      Value<int>? estado,
      Value<int>? idVenda,
      Value<double>? valor}) {
    return TabelaPagamentoCompanion(
      id: id ?? this.id,
      idFormaPagamento: idFormaPagamento ?? this.idFormaPagamento,
      estado: estado ?? this.estado,
      idVenda: idVenda ?? this.idVenda,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idFormaPagamento.present) {
      map['id_forma_pagamento'] = Variable<int>(idFormaPagamento.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idVenda.present) {
      map['id_venda'] = Variable<int>(idVenda.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaPagamentoCompanion(')
          ..write('id: $id, ')
          ..write('idFormaPagamento: $idFormaPagamento, ')
          ..write('estado: $estado, ')
          ..write('idVenda: $idVenda, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }
}

class $TabelaPagamentoTable extends TabelaPagamento
    with TableInfo<$TabelaPagamentoTable, TabelaPagamentoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaPagamentoTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _idFormaPagamentoMeta =
      const VerificationMeta('idFormaPagamento');
  @override
  late final GeneratedColumn<int> idFormaPagamento = GeneratedColumn<int>(
      'id_forma_pagamento', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idVendaMeta = const VerificationMeta('idVenda');
  @override
  late final GeneratedColumn<int> idVenda = GeneratedColumn<int>(
      'id_venda', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, idFormaPagamento, estado, idVenda, valor];
  @override
  String get aliasedName => _alias ?? 'tabela_pagamento';
  @override
  String get actualTableName => 'tabela_pagamento';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaPagamentoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_forma_pagamento')) {
      context.handle(
          _idFormaPagamentoMeta,
          idFormaPagamento.isAcceptableOrUnknown(
              data['id_forma_pagamento']!, _idFormaPagamentoMeta));
    } else if (isInserting) {
      context.missing(_idFormaPagamentoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_venda')) {
      context.handle(_idVendaMeta,
          idVenda.isAcceptableOrUnknown(data['id_venda']!, _idVendaMeta));
    } else if (isInserting) {
      context.missing(_idVendaMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaPagamentoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaPagamentoData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idFormaPagamento: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}id_forma_pagamento'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idVenda: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_venda'])!,
      valor: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}valor'])!,
    );
  }

  @override
  $TabelaPagamentoTable createAlias(String alias) {
    return $TabelaPagamentoTable(attachedDatabase, alias);
  }
}

class TabelaDinheiroSobraData extends DataClass
    implements Insertable<TabelaDinheiroSobraData> {
  final int id;
  final int estado;
  final int idFuncionario;
  final double valor;
  final DateTime data;
  const TabelaDinheiroSobraData(
      {required this.id,
      required this.estado,
      required this.idFuncionario,
      required this.valor,
      required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_funcionario'] = Variable<int>(idFuncionario);
    map['valor'] = Variable<double>(valor);
    map['data'] = Variable<DateTime>(data);
    return map;
  }

  TabelaDinheiroSobraCompanion toCompanion(bool nullToAbsent) {
    return TabelaDinheiroSobraCompanion(
      id: Value(id),
      estado: Value(estado),
      idFuncionario: Value(idFuncionario),
      valor: Value(valor),
      data: Value(data),
    );
  }

  factory TabelaDinheiroSobraData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaDinheiroSobraData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      valor: serializer.fromJson<double>(json['valor']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idFuncionario': serializer.toJson<int>(idFuncionario),
      'valor': serializer.toJson<double>(valor),
      'data': serializer.toJson<DateTime>(data),
    };
  }

  TabelaDinheiroSobraData copyWith(
          {int? id,
          int? estado,
          int? idFuncionario,
          double? valor,
          DateTime? data}) =>
      TabelaDinheiroSobraData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        valor: valor ?? this.valor,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaDinheiroSobraData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('valor: $valor, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idFuncionario, valor, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaDinheiroSobraData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.valor == this.valor &&
          other.data == this.data);
}

class TabelaDinheiroSobraCompanion
    extends UpdateCompanion<TabelaDinheiroSobraData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idFuncionario;
  final Value<double> valor;
  final Value<DateTime> data;
  const TabelaDinheiroSobraCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idFuncionario = const Value.absent(),
    this.valor = const Value.absent(),
    this.data = const Value.absent(),
  });
  TabelaDinheiroSobraCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idFuncionario,
    required double valor,
    required DateTime data,
  })  : estado = Value(estado),
        idFuncionario = Value(idFuncionario),
        valor = Value(valor),
        data = Value(data);
  static Insertable<TabelaDinheiroSobraData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idFuncionario,
    Expression<double>? valor,
    Expression<DateTime>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idFuncionario != null) 'id_funcionario': idFuncionario,
      if (valor != null) 'valor': valor,
      if (data != null) 'data': data,
    });
  }

  TabelaDinheiroSobraCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idFuncionario,
      Value<double>? valor,
      Value<DateTime>? data}) {
    return TabelaDinheiroSobraCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idFuncionario: idFuncionario ?? this.idFuncionario,
      valor: valor ?? this.valor,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idFuncionario.present) {
      map['id_funcionario'] = Variable<int>(idFuncionario.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaDinheiroSobraCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('valor: $valor, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $TabelaDinheiroSobraTable extends TabelaDinheiroSobra
    with TableInfo<$TabelaDinheiroSobraTable, TabelaDinheiroSobraData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaDinheiroSobraTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idFuncionarioMeta =
      const VerificationMeta('idFuncionario');
  @override
  late final GeneratedColumn<int> idFuncionario = GeneratedColumn<int>(
      'id_funcionario', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, idFuncionario, valor, data];
  @override
  String get aliasedName => _alias ?? 'tabela_dinheiro_sobra';
  @override
  String get actualTableName => 'tabela_dinheiro_sobra';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaDinheiroSobraData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_funcionario')) {
      context.handle(
          _idFuncionarioMeta,
          idFuncionario.isAcceptableOrUnknown(
              data['id_funcionario']!, _idFuncionarioMeta));
    } else if (isInserting) {
      context.missing(_idFuncionarioMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaDinheiroSobraData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaDinheiroSobraData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idFuncionario: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_funcionario'])!,
      valor: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}valor'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $TabelaDinheiroSobraTable createAlias(String alias) {
    return $TabelaDinheiroSobraTable(attachedDatabase, alias);
  }
}

class TabelaPagamentoFinalData extends DataClass
    implements Insertable<TabelaPagamentoFinalData> {
  final int id;
  final int estado;
  final int idPagamento;
  final DateTime data;
  const TabelaPagamentoFinalData(
      {required this.id,
      required this.estado,
      required this.idPagamento,
      required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_pagamento'] = Variable<int>(idPagamento);
    map['data'] = Variable<DateTime>(data);
    return map;
  }

  TabelaPagamentoFinalCompanion toCompanion(bool nullToAbsent) {
    return TabelaPagamentoFinalCompanion(
      id: Value(id),
      estado: Value(estado),
      idPagamento: Value(idPagamento),
      data: Value(data),
    );
  }

  factory TabelaPagamentoFinalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaPagamentoFinalData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idPagamento: serializer.fromJson<int>(json['idPagamento']),
      data: serializer.fromJson<DateTime>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idPagamento': serializer.toJson<int>(idPagamento),
      'data': serializer.toJson<DateTime>(data),
    };
  }

  TabelaPagamentoFinalData copyWith(
          {int? id, int? estado, int? idPagamento, DateTime? data}) =>
      TabelaPagamentoFinalData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idPagamento: idPagamento ?? this.idPagamento,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaPagamentoFinalData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idPagamento: $idPagamento, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, idPagamento, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaPagamentoFinalData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idPagamento == this.idPagamento &&
          other.data == this.data);
}

class TabelaPagamentoFinalCompanion
    extends UpdateCompanion<TabelaPagamentoFinalData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idPagamento;
  final Value<DateTime> data;
  const TabelaPagamentoFinalCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idPagamento = const Value.absent(),
    this.data = const Value.absent(),
  });
  TabelaPagamentoFinalCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idPagamento,
    required DateTime data,
  })  : estado = Value(estado),
        idPagamento = Value(idPagamento),
        data = Value(data);
  static Insertable<TabelaPagamentoFinalData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idPagamento,
    Expression<DateTime>? data,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idPagamento != null) 'id_pagamento': idPagamento,
      if (data != null) 'data': data,
    });
  }

  TabelaPagamentoFinalCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idPagamento,
      Value<DateTime>? data}) {
    return TabelaPagamentoFinalCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idPagamento: idPagamento ?? this.idPagamento,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idPagamento.present) {
      map['id_pagamento'] = Variable<int>(idPagamento.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaPagamentoFinalCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idPagamento: $idPagamento, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}

class $TabelaPagamentoFinalTable extends TabelaPagamentoFinal
    with TableInfo<$TabelaPagamentoFinalTable, TabelaPagamentoFinalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaPagamentoFinalTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idPagamentoMeta =
      const VerificationMeta('idPagamento');
  @override
  late final GeneratedColumn<int> idPagamento = GeneratedColumn<int>(
      'id_pagamento', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, estado, idPagamento, data];
  @override
  String get aliasedName => _alias ?? 'tabela_pagamento_final';
  @override
  String get actualTableName => 'tabela_pagamento_final';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaPagamentoFinalData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_pagamento')) {
      context.handle(
          _idPagamentoMeta,
          idPagamento.isAcceptableOrUnknown(
              data['id_pagamento']!, _idPagamentoMeta));
    } else if (isInserting) {
      context.missing(_idPagamentoMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaPagamentoFinalData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaPagamentoFinalData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idPagamento: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_pagamento'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $TabelaPagamentoFinalTable createAlias(String alias) {
    return $TabelaPagamentoFinalTable(attachedDatabase, alias);
  }
}

class TabelaSaidaCaixaData extends DataClass
    implements Insertable<TabelaSaidaCaixaData> {
  final int id;
  final int estado;
  final int idFuncionario;
  final DateTime data;
  final String motivo;
  final double valor;
  const TabelaSaidaCaixaData(
      {required this.id,
      required this.estado,
      required this.idFuncionario,
      required this.data,
      required this.motivo,
      required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['id_funcionario'] = Variable<int>(idFuncionario);
    map['data'] = Variable<DateTime>(data);
    map['motivo'] = Variable<String>(motivo);
    map['valor'] = Variable<double>(valor);
    return map;
  }

  TabelaSaidaCaixaCompanion toCompanion(bool nullToAbsent) {
    return TabelaSaidaCaixaCompanion(
      id: Value(id),
      estado: Value(estado),
      idFuncionario: Value(idFuncionario),
      data: Value(data),
      motivo: Value(motivo),
      valor: Value(valor),
    );
  }

  factory TabelaSaidaCaixaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaSaidaCaixaData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      data: serializer.fromJson<DateTime>(json['data']),
      motivo: serializer.fromJson<String>(json['motivo']),
      valor: serializer.fromJson<double>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'idFuncionario': serializer.toJson<int>(idFuncionario),
      'data': serializer.toJson<DateTime>(data),
      'motivo': serializer.toJson<String>(motivo),
      'valor': serializer.toJson<double>(valor),
    };
  }

  TabelaSaidaCaixaData copyWith(
          {int? id,
          int? estado,
          int? idFuncionario,
          DateTime? data,
          String? motivo,
          double? valor}) =>
      TabelaSaidaCaixaData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        data: data ?? this.data,
        motivo: motivo ?? this.motivo,
        valor: valor ?? this.valor,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaSaidaCaixaData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, estado, idFuncionario, data, motivo, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaSaidaCaixaData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.idFuncionario == this.idFuncionario &&
          other.data == this.data &&
          other.motivo == this.motivo &&
          other.valor == this.valor);
}

class TabelaSaidaCaixaCompanion extends UpdateCompanion<TabelaSaidaCaixaData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> idFuncionario;
  final Value<DateTime> data;
  final Value<String> motivo;
  final Value<double> valor;
  const TabelaSaidaCaixaCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.idFuncionario = const Value.absent(),
    this.data = const Value.absent(),
    this.motivo = const Value.absent(),
    this.valor = const Value.absent(),
  });
  TabelaSaidaCaixaCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int idFuncionario,
    required DateTime data,
    required String motivo,
    required double valor,
  })  : estado = Value(estado),
        idFuncionario = Value(idFuncionario),
        data = Value(data),
        motivo = Value(motivo),
        valor = Value(valor);
  static Insertable<TabelaSaidaCaixaData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? idFuncionario,
    Expression<DateTime>? data,
    Expression<String>? motivo,
    Expression<double>? valor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (idFuncionario != null) 'id_funcionario': idFuncionario,
      if (data != null) 'data': data,
      if (motivo != null) 'motivo': motivo,
      if (valor != null) 'valor': valor,
    });
  }

  TabelaSaidaCaixaCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? idFuncionario,
      Value<DateTime>? data,
      Value<String>? motivo,
      Value<double>? valor}) {
    return TabelaSaidaCaixaCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      idFuncionario: idFuncionario ?? this.idFuncionario,
      data: data ?? this.data,
      motivo: motivo ?? this.motivo,
      valor: valor ?? this.valor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (idFuncionario.present) {
      map['id_funcionario'] = Variable<int>(idFuncionario.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaSaidaCaixaCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('data: $data, ')
          ..write('motivo: $motivo, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }
}

class $TabelaSaidaCaixaTable extends TabelaSaidaCaixa
    with TableInfo<$TabelaSaidaCaixaTable, TabelaSaidaCaixaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaSaidaCaixaTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idFuncionarioMeta =
      const VerificationMeta('idFuncionario');
  @override
  late final GeneratedColumn<int> idFuncionario = GeneratedColumn<int>(
      'id_funcionario', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
      'motivo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, idFuncionario, data, motivo, valor];
  @override
  String get aliasedName => _alias ?? 'tabela_saida_caixa';
  @override
  String get actualTableName => 'tabela_saida_caixa';
  @override
  VerificationContext validateIntegrity(
      Insertable<TabelaSaidaCaixaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('id_funcionario')) {
      context.handle(
          _idFuncionarioMeta,
          idFuncionario.isAcceptableOrUnknown(
              data['id_funcionario']!, _idFuncionarioMeta));
    } else if (isInserting) {
      context.missing(_idFuncionarioMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(_motivoMeta,
          motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta));
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaSaidaCaixaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaSaidaCaixaData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      idFuncionario: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_funcionario'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      motivo: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}motivo'])!,
      valor: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}valor'])!,
    );
  }

  @override
  $TabelaSaidaCaixaTable createAlias(String alias) {
    return $TabelaSaidaCaixaTable(attachedDatabase, alias);
  }
}

class TabelaEntidadeData extends DataClass
    implements Insertable<TabelaEntidadeData> {
  final int id;
  final int estado;
  final String nome;
  final String endereco;
  final String nif;
  final String telefone;
  const TabelaEntidadeData(
      {required this.id,
      required this.estado,
      required this.nome,
      required this.endereco,
      required this.nif,
      required this.telefone});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['nome'] = Variable<String>(nome);
    map['endereco'] = Variable<String>(endereco);
    map['nif'] = Variable<String>(nif);
    map['telefone'] = Variable<String>(telefone);
    return map;
  }

  TabelaEntidadeCompanion toCompanion(bool nullToAbsent) {
    return TabelaEntidadeCompanion(
      id: Value(id),
      estado: Value(estado),
      nome: Value(nome),
      endereco: Value(endereco),
      nif: Value(nif),
      telefone: Value(telefone),
    );
  }

  factory TabelaEntidadeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaEntidadeData(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      nome: serializer.fromJson<String>(json['nome']),
      endereco: serializer.fromJson<String>(json['endereco']),
      nif: serializer.fromJson<String>(json['nif']),
      telefone: serializer.fromJson<String>(json['telefone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'nome': serializer.toJson<String>(nome),
      'endereco': serializer.toJson<String>(endereco),
      'nif': serializer.toJson<String>(nif),
      'telefone': serializer.toJson<String>(telefone),
    };
  }

  TabelaEntidadeData copyWith(
          {int? id,
          int? estado,
          String? nome,
          String? endereco,
          String? nif,
          String? telefone}) =>
      TabelaEntidadeData(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        nome: nome ?? this.nome,
        endereco: endereco ?? this.endereco,
        nif: nif ?? this.nif,
        telefone: telefone ?? this.telefone,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaEntidadeData(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('endereco: $endereco, ')
          ..write('nif: $nif, ')
          ..write('telefone: $telefone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, nome, endereco, nif, telefone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaEntidadeData &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.nome == this.nome &&
          other.endereco == this.endereco &&
          other.nif == this.nif &&
          other.telefone == this.telefone);
}

class TabelaEntidadeCompanion extends UpdateCompanion<TabelaEntidadeData> {
  final Value<int> id;
  final Value<int> estado;
  final Value<String> nome;
  final Value<String> endereco;
  final Value<String> nif;
  final Value<String> telefone;
  const TabelaEntidadeCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.nome = const Value.absent(),
    this.endereco = const Value.absent(),
    this.nif = const Value.absent(),
    this.telefone = const Value.absent(),
  });
  TabelaEntidadeCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required String nome,
    required String endereco,
    required String nif,
    required String telefone,
  })  : estado = Value(estado),
        nome = Value(nome),
        endereco = Value(endereco),
        nif = Value(nif),
        telefone = Value(telefone);
  static Insertable<TabelaEntidadeData> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<String>? nome,
    Expression<String>? endereco,
    Expression<String>? nif,
    Expression<String>? telefone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (nome != null) 'nome': nome,
      if (endereco != null) 'endereco': endereco,
      if (nif != null) 'nif': nif,
      if (telefone != null) 'telefone': telefone,
    });
  }

  TabelaEntidadeCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<String>? nome,
      Value<String>? endereco,
      Value<String>? nif,
      Value<String>? telefone}) {
    return TabelaEntidadeCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      nome: nome ?? this.nome,
      endereco: endereco ?? this.endereco,
      nif: nif ?? this.nif,
      telefone: telefone ?? this.telefone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (endereco.present) {
      map['endereco'] = Variable<String>(endereco.value);
    }
    if (nif.present) {
      map['nif'] = Variable<String>(nif.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaEntidadeCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('nome: $nome, ')
          ..write('endereco: $endereco, ')
          ..write('nif: $nif, ')
          ..write('telefone: $telefone')
          ..write(')'))
        .toString();
  }
}

class $TabelaEntidadeTable extends TabelaEntidade
    with TableInfo<$TabelaEntidadeTable, TabelaEntidadeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaEntidadeTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _enderecoMeta = const VerificationMeta('endereco');
  @override
  late final GeneratedColumn<String> endereco = GeneratedColumn<String>(
      'endereco', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nifMeta = const VerificationMeta('nif');
  @override
  late final GeneratedColumn<String> nif = GeneratedColumn<String>(
      'nif', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _telefoneMeta = const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, estado, nome, endereco, nif, telefone];
  @override
  String get aliasedName => _alias ?? 'tabela_entidade';
  @override
  String get actualTableName => 'tabela_entidade';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaEntidadeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('endereco')) {
      context.handle(_enderecoMeta,
          endereco.isAcceptableOrUnknown(data['endereco']!, _enderecoMeta));
    } else if (isInserting) {
      context.missing(_enderecoMeta);
    }
    if (data.containsKey('nif')) {
      context.handle(
          _nifMeta, nif.isAcceptableOrUnknown(data['nif']!, _nifMeta));
    } else if (isInserting) {
      context.missing(_nifMeta);
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    } else if (isInserting) {
      context.missing(_telefoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaEntidadeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaEntidadeData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      nome: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      endereco: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}endereco'])!,
      nif: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}nif'])!,
      telefone: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}telefone'])!,
    );
  }

  @override
  $TabelaEntidadeTable createAlias(String alias) {
    return $TabelaEntidadeTable(attachedDatabase, alias);
  }
}

class TabelaDefinicoe extends DataClass implements Insertable<TabelaDefinicoe> {
  final int id;
  final int estado;
  final int tipoNegocio;
  final int tipoEntidade;
  final DateTime? dataAcesso;
  final DateTime? dataExpiracao;
  final String? licenca;
  final bool? licenciado;
  final String? idLicenca;
  const TabelaDefinicoe(
      {required this.id,
      required this.estado,
      required this.tipoNegocio,
      required this.tipoEntidade,
      this.dataAcesso,
      this.dataExpiracao,
      this.licenca,
      this.licenciado,
      this.idLicenca});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['estado'] = Variable<int>(estado);
    map['tipo_negocio'] = Variable<int>(tipoNegocio);
    map['tipo_entidade'] = Variable<int>(tipoEntidade);
    if (!nullToAbsent || dataAcesso != null) {
      map['data_acesso'] = Variable<DateTime>(dataAcesso);
    }
    if (!nullToAbsent || dataExpiracao != null) {
      map['data_expiracao'] = Variable<DateTime>(dataExpiracao);
    }
    if (!nullToAbsent || licenca != null) {
      map['licenca'] = Variable<String>(licenca);
    }
    if (!nullToAbsent || licenciado != null) {
      map['licenciado'] = Variable<bool>(licenciado);
    }
    if (!nullToAbsent || idLicenca != null) {
      map['id_licenca'] = Variable<String>(idLicenca);
    }
    return map;
  }

  TabelaDefinicoesCompanion toCompanion(bool nullToAbsent) {
    return TabelaDefinicoesCompanion(
      id: Value(id),
      estado: Value(estado),
      tipoNegocio: Value(tipoNegocio),
      tipoEntidade: Value(tipoEntidade),
      dataAcesso: dataAcesso == null && nullToAbsent
          ? const Value.absent()
          : Value(dataAcesso),
      dataExpiracao: dataExpiracao == null && nullToAbsent
          ? const Value.absent()
          : Value(dataExpiracao),
      licenca: licenca == null && nullToAbsent
          ? const Value.absent()
          : Value(licenca),
      licenciado: licenciado == null && nullToAbsent
          ? const Value.absent()
          : Value(licenciado),
      idLicenca: idLicenca == null && nullToAbsent
          ? const Value.absent()
          : Value(idLicenca),
    );
  }

  factory TabelaDefinicoe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaDefinicoe(
      id: serializer.fromJson<int>(json['id']),
      estado: serializer.fromJson<int>(json['estado']),
      tipoNegocio: serializer.fromJson<int>(json['tipoNegocio']),
      tipoEntidade: serializer.fromJson<int>(json['tipoEntidade']),
      dataAcesso: serializer.fromJson<DateTime?>(json['dataAcesso']),
      dataExpiracao: serializer.fromJson<DateTime?>(json['dataExpiracao']),
      licenca: serializer.fromJson<String?>(json['licenca']),
      licenciado: serializer.fromJson<bool?>(json['licenciado']),
      idLicenca: serializer.fromJson<String?>(json['idLicenca']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'estado': serializer.toJson<int>(estado),
      'tipoNegocio': serializer.toJson<int>(tipoNegocio),
      'tipoEntidade': serializer.toJson<int>(tipoEntidade),
      'dataAcesso': serializer.toJson<DateTime?>(dataAcesso),
      'dataExpiracao': serializer.toJson<DateTime?>(dataExpiracao),
      'licenca': serializer.toJson<String?>(licenca),
      'licenciado': serializer.toJson<bool?>(licenciado),
      'idLicenca': serializer.toJson<String?>(idLicenca),
    };
  }

  TabelaDefinicoe copyWith(
          {int? id,
          int? estado,
          int? tipoNegocio,
          int? tipoEntidade,
          Value<DateTime?> dataAcesso = const Value.absent(),
          Value<DateTime?> dataExpiracao = const Value.absent(),
          Value<String?> licenca = const Value.absent(),
          Value<bool?> licenciado = const Value.absent(),
          Value<String?> idLicenca = const Value.absent()}) =>
      TabelaDefinicoe(
        id: id ?? this.id,
        estado: estado ?? this.estado,
        tipoNegocio: tipoNegocio ?? this.tipoNegocio,
        tipoEntidade: tipoEntidade ?? this.tipoEntidade,
        dataAcesso: dataAcesso.present ? dataAcesso.value : this.dataAcesso,
        dataExpiracao:
            dataExpiracao.present ? dataExpiracao.value : this.dataExpiracao,
        licenca: licenca.present ? licenca.value : this.licenca,
        licenciado: licenciado.present ? licenciado.value : this.licenciado,
        idLicenca: idLicenca.present ? idLicenca.value : this.idLicenca,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaDefinicoe(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('tipoNegocio: $tipoNegocio, ')
          ..write('tipoEntidade: $tipoEntidade, ')
          ..write('dataAcesso: $dataAcesso, ')
          ..write('dataExpiracao: $dataExpiracao, ')
          ..write('licenca: $licenca, ')
          ..write('licenciado: $licenciado, ')
          ..write('idLicenca: $idLicenca')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, estado, tipoNegocio, tipoEntidade,
      dataAcesso, dataExpiracao, licenca, licenciado, idLicenca);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaDefinicoe &&
          other.id == this.id &&
          other.estado == this.estado &&
          other.tipoNegocio == this.tipoNegocio &&
          other.tipoEntidade == this.tipoEntidade &&
          other.dataAcesso == this.dataAcesso &&
          other.dataExpiracao == this.dataExpiracao &&
          other.licenca == this.licenca &&
          other.licenciado == this.licenciado &&
          other.idLicenca == this.idLicenca);
}

class TabelaDefinicoesCompanion extends UpdateCompanion<TabelaDefinicoe> {
  final Value<int> id;
  final Value<int> estado;
  final Value<int> tipoNegocio;
  final Value<int> tipoEntidade;
  final Value<DateTime?> dataAcesso;
  final Value<DateTime?> dataExpiracao;
  final Value<String?> licenca;
  final Value<bool?> licenciado;
  final Value<String?> idLicenca;
  const TabelaDefinicoesCompanion({
    this.id = const Value.absent(),
    this.estado = const Value.absent(),
    this.tipoNegocio = const Value.absent(),
    this.tipoEntidade = const Value.absent(),
    this.dataAcesso = const Value.absent(),
    this.dataExpiracao = const Value.absent(),
    this.licenca = const Value.absent(),
    this.licenciado = const Value.absent(),
    this.idLicenca = const Value.absent(),
  });
  TabelaDefinicoesCompanion.insert({
    this.id = const Value.absent(),
    required int estado,
    required int tipoNegocio,
    required int tipoEntidade,
    this.dataAcesso = const Value.absent(),
    this.dataExpiracao = const Value.absent(),
    this.licenca = const Value.absent(),
    this.licenciado = const Value.absent(),
    this.idLicenca = const Value.absent(),
  })  : estado = Value(estado),
        tipoNegocio = Value(tipoNegocio),
        tipoEntidade = Value(tipoEntidade);
  static Insertable<TabelaDefinicoe> custom({
    Expression<int>? id,
    Expression<int>? estado,
    Expression<int>? tipoNegocio,
    Expression<int>? tipoEntidade,
    Expression<DateTime>? dataAcesso,
    Expression<DateTime>? dataExpiracao,
    Expression<String>? licenca,
    Expression<bool>? licenciado,
    Expression<String>? idLicenca,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (estado != null) 'estado': estado,
      if (tipoNegocio != null) 'tipo_negocio': tipoNegocio,
      if (tipoEntidade != null) 'tipo_entidade': tipoEntidade,
      if (dataAcesso != null) 'data_acesso': dataAcesso,
      if (dataExpiracao != null) 'data_expiracao': dataExpiracao,
      if (licenca != null) 'licenca': licenca,
      if (licenciado != null) 'licenciado': licenciado,
      if (idLicenca != null) 'id_licenca': idLicenca,
    });
  }

  TabelaDefinicoesCompanion copyWith(
      {Value<int>? id,
      Value<int>? estado,
      Value<int>? tipoNegocio,
      Value<int>? tipoEntidade,
      Value<DateTime?>? dataAcesso,
      Value<DateTime?>? dataExpiracao,
      Value<String?>? licenca,
      Value<bool?>? licenciado,
      Value<String?>? idLicenca}) {
    return TabelaDefinicoesCompanion(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      tipoNegocio: tipoNegocio ?? this.tipoNegocio,
      tipoEntidade: tipoEntidade ?? this.tipoEntidade,
      dataAcesso: dataAcesso ?? this.dataAcesso,
      dataExpiracao: dataExpiracao ?? this.dataExpiracao,
      licenca: licenca ?? this.licenca,
      licenciado: licenciado ?? this.licenciado,
      idLicenca: idLicenca ?? this.idLicenca,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (tipoNegocio.present) {
      map['tipo_negocio'] = Variable<int>(tipoNegocio.value);
    }
    if (tipoEntidade.present) {
      map['tipo_entidade'] = Variable<int>(tipoEntidade.value);
    }
    if (dataAcesso.present) {
      map['data_acesso'] = Variable<DateTime>(dataAcesso.value);
    }
    if (dataExpiracao.present) {
      map['data_expiracao'] = Variable<DateTime>(dataExpiracao.value);
    }
    if (licenca.present) {
      map['licenca'] = Variable<String>(licenca.value);
    }
    if (licenciado.present) {
      map['licenciado'] = Variable<bool>(licenciado.value);
    }
    if (idLicenca.present) {
      map['id_licenca'] = Variable<String>(idLicenca.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaDefinicoesCompanion(')
          ..write('id: $id, ')
          ..write('estado: $estado, ')
          ..write('tipoNegocio: $tipoNegocio, ')
          ..write('tipoEntidade: $tipoEntidade, ')
          ..write('dataAcesso: $dataAcesso, ')
          ..write('dataExpiracao: $dataExpiracao, ')
          ..write('licenca: $licenca, ')
          ..write('licenciado: $licenciado, ')
          ..write('idLicenca: $idLicenca')
          ..write(')'))
        .toString();
  }
}

class $TabelaDefinicoesTable extends TabelaDefinicoes
    with TableInfo<$TabelaDefinicoesTable, TabelaDefinicoe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaDefinicoesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _tipoNegocioMeta =
      const VerificationMeta('tipoNegocio');
  @override
  late final GeneratedColumn<int> tipoNegocio = GeneratedColumn<int>(
      'tipo_negocio', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _tipoEntidadeMeta =
      const VerificationMeta('tipoEntidade');
  @override
  late final GeneratedColumn<int> tipoEntidade = GeneratedColumn<int>(
      'tipo_entidade', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dataAcessoMeta = const VerificationMeta('dataAcesso');
  @override
  late final GeneratedColumn<DateTime> dataAcesso = GeneratedColumn<DateTime>(
      'data_acesso', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _dataExpiracaoMeta =
      const VerificationMeta('dataExpiracao');
  @override
  late final GeneratedColumn<DateTime> dataExpiracao =
      GeneratedColumn<DateTime>('data_expiracao', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _licencaMeta = const VerificationMeta('licenca');
  @override
  late final GeneratedColumn<String> licenca = GeneratedColumn<String>(
      'licenca', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _licenciadoMeta = const VerificationMeta('licenciado');
  @override
  late final GeneratedColumn<bool> licenciado = GeneratedColumn<bool>(
      'licenciado', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK ("licenciado" IN (0, 1))');
  final VerificationMeta _idLicencaMeta = const VerificationMeta('idLicenca');
  @override
  late final GeneratedColumn<String> idLicenca = GeneratedColumn<String>(
      'id_licenca', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        estado,
        tipoNegocio,
        tipoEntidade,
        dataAcesso,
        dataExpiracao,
        licenca,
        licenciado,
        idLicenca
      ];
  @override
  String get aliasedName => _alias ?? 'tabela_definicoes';
  @override
  String get actualTableName => 'tabela_definicoes';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaDefinicoe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('tipo_negocio')) {
      context.handle(
          _tipoNegocioMeta,
          tipoNegocio.isAcceptableOrUnknown(
              data['tipo_negocio']!, _tipoNegocioMeta));
    } else if (isInserting) {
      context.missing(_tipoNegocioMeta);
    }
    if (data.containsKey('tipo_entidade')) {
      context.handle(
          _tipoEntidadeMeta,
          tipoEntidade.isAcceptableOrUnknown(
              data['tipo_entidade']!, _tipoEntidadeMeta));
    } else if (isInserting) {
      context.missing(_tipoEntidadeMeta);
    }
    if (data.containsKey('data_acesso')) {
      context.handle(
          _dataAcessoMeta,
          dataAcesso.isAcceptableOrUnknown(
              data['data_acesso']!, _dataAcessoMeta));
    }
    if (data.containsKey('data_expiracao')) {
      context.handle(
          _dataExpiracaoMeta,
          dataExpiracao.isAcceptableOrUnknown(
              data['data_expiracao']!, _dataExpiracaoMeta));
    }
    if (data.containsKey('licenca')) {
      context.handle(_licencaMeta,
          licenca.isAcceptableOrUnknown(data['licenca']!, _licencaMeta));
    }
    if (data.containsKey('licenciado')) {
      context.handle(
          _licenciadoMeta,
          licenciado.isAcceptableOrUnknown(
              data['licenciado']!, _licenciadoMeta));
    }
    if (data.containsKey('id_licenca')) {
      context.handle(_idLicencaMeta,
          idLicenca.isAcceptableOrUnknown(data['id_licenca']!, _idLicencaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaDefinicoe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaDefinicoe(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      tipoNegocio: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}tipo_negocio'])!,
      tipoEntidade: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}tipo_entidade'])!,
      dataAcesso: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_acesso']),
      dataExpiracao: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_expiracao']),
      licenca: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}licenca']),
      licenciado: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}licenciado']),
      idLicenca: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id_licenca']),
    );
  }

  @override
  $TabelaDefinicoesTable createAlias(String alias) {
    return $TabelaDefinicoesTable(attachedDatabase, alias);
  }
}

class TabelaDividaData extends DataClass
    implements Insertable<TabelaDividaData> {
  final int id;
  final int idFuncionario;
  final int? idFuncionarioPagante;
  final int idCliente;
  final int idProduto;
  final int estado;
  final int quantidadeDevida;
  final DateTime data;
  final DateTime? dataPagamento;
  final double total;
  final bool paga;
  const TabelaDividaData(
      {required this.id,
      required this.idFuncionario,
      this.idFuncionarioPagante,
      required this.idCliente,
      required this.idProduto,
      required this.estado,
      required this.quantidadeDevida,
      required this.data,
      this.dataPagamento,
      required this.total,
      required this.paga});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_funcionario'] = Variable<int>(idFuncionario);
    if (!nullToAbsent || idFuncionarioPagante != null) {
      map['id_funcionario_pagante'] = Variable<int>(idFuncionarioPagante);
    }
    map['id_cliente'] = Variable<int>(idCliente);
    map['id_produto'] = Variable<int>(idProduto);
    map['estado'] = Variable<int>(estado);
    map['quantidade_devida'] = Variable<int>(quantidadeDevida);
    map['data'] = Variable<DateTime>(data);
    if (!nullToAbsent || dataPagamento != null) {
      map['data_pagamento'] = Variable<DateTime>(dataPagamento);
    }
    map['total'] = Variable<double>(total);
    map['paga'] = Variable<bool>(paga);
    return map;
  }

  TabelaDividaCompanion toCompanion(bool nullToAbsent) {
    return TabelaDividaCompanion(
      id: Value(id),
      idFuncionario: Value(idFuncionario),
      idFuncionarioPagante: idFuncionarioPagante == null && nullToAbsent
          ? const Value.absent()
          : Value(idFuncionarioPagante),
      idCliente: Value(idCliente),
      idProduto: Value(idProduto),
      estado: Value(estado),
      quantidadeDevida: Value(quantidadeDevida),
      data: Value(data),
      dataPagamento: dataPagamento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataPagamento),
      total: Value(total),
      paga: Value(paga),
    );
  }

  factory TabelaDividaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TabelaDividaData(
      id: serializer.fromJson<int>(json['id']),
      idFuncionario: serializer.fromJson<int>(json['idFuncionario']),
      idFuncionarioPagante:
          serializer.fromJson<int?>(json['idFuncionarioPagante']),
      idCliente: serializer.fromJson<int>(json['idCliente']),
      idProduto: serializer.fromJson<int>(json['idProduto']),
      estado: serializer.fromJson<int>(json['estado']),
      quantidadeDevida: serializer.fromJson<int>(json['quantidadeDevida']),
      data: serializer.fromJson<DateTime>(json['data']),
      dataPagamento: serializer.fromJson<DateTime?>(json['dataPagamento']),
      total: serializer.fromJson<double>(json['total']),
      paga: serializer.fromJson<bool>(json['paga']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idFuncionario': serializer.toJson<int>(idFuncionario),
      'idFuncionarioPagante': serializer.toJson<int?>(idFuncionarioPagante),
      'idCliente': serializer.toJson<int>(idCliente),
      'idProduto': serializer.toJson<int>(idProduto),
      'estado': serializer.toJson<int>(estado),
      'quantidadeDevida': serializer.toJson<int>(quantidadeDevida),
      'data': serializer.toJson<DateTime>(data),
      'dataPagamento': serializer.toJson<DateTime?>(dataPagamento),
      'total': serializer.toJson<double>(total),
      'paga': serializer.toJson<bool>(paga),
    };
  }

  TabelaDividaData copyWith(
          {int? id,
          int? idFuncionario,
          Value<int?> idFuncionarioPagante = const Value.absent(),
          int? idCliente,
          int? idProduto,
          int? estado,
          int? quantidadeDevida,
          DateTime? data,
          Value<DateTime?> dataPagamento = const Value.absent(),
          double? total,
          bool? paga}) =>
      TabelaDividaData(
        id: id ?? this.id,
        idFuncionario: idFuncionario ?? this.idFuncionario,
        idFuncionarioPagante: idFuncionarioPagante.present
            ? idFuncionarioPagante.value
            : this.idFuncionarioPagante,
        idCliente: idCliente ?? this.idCliente,
        idProduto: idProduto ?? this.idProduto,
        estado: estado ?? this.estado,
        quantidadeDevida: quantidadeDevida ?? this.quantidadeDevida,
        data: data ?? this.data,
        dataPagamento:
            dataPagamento.present ? dataPagamento.value : this.dataPagamento,
        total: total ?? this.total,
        paga: paga ?? this.paga,
      );
  @override
  String toString() {
    return (StringBuffer('TabelaDividaData(')
          ..write('id: $id, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idFuncionarioPagante: $idFuncionarioPagante, ')
          ..write('idCliente: $idCliente, ')
          ..write('idProduto: $idProduto, ')
          ..write('estado: $estado, ')
          ..write('quantidadeDevida: $quantidadeDevida, ')
          ..write('data: $data, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('total: $total, ')
          ..write('paga: $paga')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      idFuncionario,
      idFuncionarioPagante,
      idCliente,
      idProduto,
      estado,
      quantidadeDevida,
      data,
      dataPagamento,
      total,
      paga);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TabelaDividaData &&
          other.id == this.id &&
          other.idFuncionario == this.idFuncionario &&
          other.idFuncionarioPagante == this.idFuncionarioPagante &&
          other.idCliente == this.idCliente &&
          other.idProduto == this.idProduto &&
          other.estado == this.estado &&
          other.quantidadeDevida == this.quantidadeDevida &&
          other.data == this.data &&
          other.dataPagamento == this.dataPagamento &&
          other.total == this.total &&
          other.paga == this.paga);
}

class TabelaDividaCompanion extends UpdateCompanion<TabelaDividaData> {
  final Value<int> id;
  final Value<int> idFuncionario;
  final Value<int?> idFuncionarioPagante;
  final Value<int> idCliente;
  final Value<int> idProduto;
  final Value<int> estado;
  final Value<int> quantidadeDevida;
  final Value<DateTime> data;
  final Value<DateTime?> dataPagamento;
  final Value<double> total;
  final Value<bool> paga;
  const TabelaDividaCompanion({
    this.id = const Value.absent(),
    this.idFuncionario = const Value.absent(),
    this.idFuncionarioPagante = const Value.absent(),
    this.idCliente = const Value.absent(),
    this.idProduto = const Value.absent(),
    this.estado = const Value.absent(),
    this.quantidadeDevida = const Value.absent(),
    this.data = const Value.absent(),
    this.dataPagamento = const Value.absent(),
    this.total = const Value.absent(),
    this.paga = const Value.absent(),
  });
  TabelaDividaCompanion.insert({
    this.id = const Value.absent(),
    required int idFuncionario,
    this.idFuncionarioPagante = const Value.absent(),
    required int idCliente,
    required int idProduto,
    required int estado,
    required int quantidadeDevida,
    required DateTime data,
    this.dataPagamento = const Value.absent(),
    required double total,
    required bool paga,
  })  : idFuncionario = Value(idFuncionario),
        idCliente = Value(idCliente),
        idProduto = Value(idProduto),
        estado = Value(estado),
        quantidadeDevida = Value(quantidadeDevida),
        data = Value(data),
        total = Value(total),
        paga = Value(paga);
  static Insertable<TabelaDividaData> custom({
    Expression<int>? id,
    Expression<int>? idFuncionario,
    Expression<int>? idFuncionarioPagante,
    Expression<int>? idCliente,
    Expression<int>? idProduto,
    Expression<int>? estado,
    Expression<int>? quantidadeDevida,
    Expression<DateTime>? data,
    Expression<DateTime>? dataPagamento,
    Expression<double>? total,
    Expression<bool>? paga,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idFuncionario != null) 'id_funcionario': idFuncionario,
      if (idFuncionarioPagante != null)
        'id_funcionario_pagante': idFuncionarioPagante,
      if (idCliente != null) 'id_cliente': idCliente,
      if (idProduto != null) 'id_produto': idProduto,
      if (estado != null) 'estado': estado,
      if (quantidadeDevida != null) 'quantidade_devida': quantidadeDevida,
      if (data != null) 'data': data,
      if (dataPagamento != null) 'data_pagamento': dataPagamento,
      if (total != null) 'total': total,
      if (paga != null) 'paga': paga,
    });
  }

  TabelaDividaCompanion copyWith(
      {Value<int>? id,
      Value<int>? idFuncionario,
      Value<int?>? idFuncionarioPagante,
      Value<int>? idCliente,
      Value<int>? idProduto,
      Value<int>? estado,
      Value<int>? quantidadeDevida,
      Value<DateTime>? data,
      Value<DateTime?>? dataPagamento,
      Value<double>? total,
      Value<bool>? paga}) {
    return TabelaDividaCompanion(
      id: id ?? this.id,
      idFuncionario: idFuncionario ?? this.idFuncionario,
      idFuncionarioPagante: idFuncionarioPagante ?? this.idFuncionarioPagante,
      idCliente: idCliente ?? this.idCliente,
      idProduto: idProduto ?? this.idProduto,
      estado: estado ?? this.estado,
      quantidadeDevida: quantidadeDevida ?? this.quantidadeDevida,
      data: data ?? this.data,
      dataPagamento: dataPagamento ?? this.dataPagamento,
      total: total ?? this.total,
      paga: paga ?? this.paga,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idFuncionario.present) {
      map['id_funcionario'] = Variable<int>(idFuncionario.value);
    }
    if (idFuncionarioPagante.present) {
      map['id_funcionario_pagante'] = Variable<int>(idFuncionarioPagante.value);
    }
    if (idCliente.present) {
      map['id_cliente'] = Variable<int>(idCliente.value);
    }
    if (idProduto.present) {
      map['id_produto'] = Variable<int>(idProduto.value);
    }
    if (estado.present) {
      map['estado'] = Variable<int>(estado.value);
    }
    if (quantidadeDevida.present) {
      map['quantidade_devida'] = Variable<int>(quantidadeDevida.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (dataPagamento.present) {
      map['data_pagamento'] = Variable<DateTime>(dataPagamento.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (paga.present) {
      map['paga'] = Variable<bool>(paga.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TabelaDividaCompanion(')
          ..write('id: $id, ')
          ..write('idFuncionario: $idFuncionario, ')
          ..write('idFuncionarioPagante: $idFuncionarioPagante, ')
          ..write('idCliente: $idCliente, ')
          ..write('idProduto: $idProduto, ')
          ..write('estado: $estado, ')
          ..write('quantidadeDevida: $quantidadeDevida, ')
          ..write('data: $data, ')
          ..write('dataPagamento: $dataPagamento, ')
          ..write('total: $total, ')
          ..write('paga: $paga')
          ..write(')'))
        .toString();
  }
}

class $TabelaDividaTable extends TabelaDivida
    with TableInfo<$TabelaDividaTable, TabelaDividaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TabelaDividaTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _idFuncionarioMeta =
      const VerificationMeta('idFuncionario');
  @override
  late final GeneratedColumn<int> idFuncionario = GeneratedColumn<int>(
      'id_funcionario', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idFuncionarioPaganteMeta =
      const VerificationMeta('idFuncionarioPagante');
  @override
  late final GeneratedColumn<int> idFuncionarioPagante = GeneratedColumn<int>(
      'id_funcionario_pagante', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _idClienteMeta = const VerificationMeta('idCliente');
  @override
  late final GeneratedColumn<int> idCliente = GeneratedColumn<int>(
      'id_cliente', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _idProdutoMeta = const VerificationMeta('idProduto');
  @override
  late final GeneratedColumn<int> idProduto = GeneratedColumn<int>(
      'id_produto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<int> estado = GeneratedColumn<int>(
      'estado', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _quantidadeDevidaMeta =
      const VerificationMeta('quantidadeDevida');
  @override
  late final GeneratedColumn<int> quantidadeDevida = GeneratedColumn<int>(
      'quantidade_devida', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
      'data', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _dataPagamentoMeta =
      const VerificationMeta('dataPagamento');
  @override
  late final GeneratedColumn<DateTime> dataPagamento =
      GeneratedColumn<DateTime>('data_pagamento', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
      'total', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _pagaMeta = const VerificationMeta('paga');
  @override
  late final GeneratedColumn<bool> paga = GeneratedColumn<bool>(
      'paga', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK ("paga" IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idFuncionario,
        idFuncionarioPagante,
        idCliente,
        idProduto,
        estado,
        quantidadeDevida,
        data,
        dataPagamento,
        total,
        paga
      ];
  @override
  String get aliasedName => _alias ?? 'tabela_divida';
  @override
  String get actualTableName => 'tabela_divida';
  @override
  VerificationContext validateIntegrity(Insertable<TabelaDividaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_funcionario')) {
      context.handle(
          _idFuncionarioMeta,
          idFuncionario.isAcceptableOrUnknown(
              data['id_funcionario']!, _idFuncionarioMeta));
    } else if (isInserting) {
      context.missing(_idFuncionarioMeta);
    }
    if (data.containsKey('id_funcionario_pagante')) {
      context.handle(
          _idFuncionarioPaganteMeta,
          idFuncionarioPagante.isAcceptableOrUnknown(
              data['id_funcionario_pagante']!, _idFuncionarioPaganteMeta));
    }
    if (data.containsKey('id_cliente')) {
      context.handle(_idClienteMeta,
          idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta));
    } else if (isInserting) {
      context.missing(_idClienteMeta);
    }
    if (data.containsKey('id_produto')) {
      context.handle(_idProdutoMeta,
          idProduto.isAcceptableOrUnknown(data['id_produto']!, _idProdutoMeta));
    } else if (isInserting) {
      context.missing(_idProdutoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('quantidade_devida')) {
      context.handle(
          _quantidadeDevidaMeta,
          quantidadeDevida.isAcceptableOrUnknown(
              data['quantidade_devida']!, _quantidadeDevidaMeta));
    } else if (isInserting) {
      context.missing(_quantidadeDevidaMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('data_pagamento')) {
      context.handle(
          _dataPagamentoMeta,
          dataPagamento.isAcceptableOrUnknown(
              data['data_pagamento']!, _dataPagamentoMeta));
    }
    if (data.containsKey('total')) {
      context.handle(
          _totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('paga')) {
      context.handle(
          _pagaMeta, paga.isAcceptableOrUnknown(data['paga']!, _pagaMeta));
    } else if (isInserting) {
      context.missing(_pagaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TabelaDividaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TabelaDividaData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idFuncionario: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_funcionario'])!,
      idFuncionarioPagante: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}id_funcionario_pagante']),
      idCliente: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_cliente'])!,
      idProduto: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id_produto'])!,
      estado: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}estado'])!,
      quantidadeDevida: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}quantidade_devida'])!,
      data: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data'])!,
      dataPagamento: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_pagamento']),
      total: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}total'])!,
      paga: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}paga'])!,
    );
  }

  @override
  $TabelaDividaTable createAlias(String alias) {
    return $TabelaDividaTable(attachedDatabase, alias);
  }
}

abstract class _$BancoDados extends GeneratedDatabase {
  _$BancoDados(QueryExecutor e) : super(e);
  late final $TabelaUsuarioTable tabelaUsuario = $TabelaUsuarioTable(this);
  late final $TabelaFuncionarioTable tabelaFuncionario =
      $TabelaFuncionarioTable(this);
  late final $TabelaProdutoTable tabelaProduto = $TabelaProdutoTable(this);
  late final $TabelaPrecoTable tabelaPreco = $TabelaPrecoTable(this);
  late final $TabelaVendaTable tabelaVenda = $TabelaVendaTable(this);
  late final $TabelaItemVendaTable tabelaItemVenda =
      $TabelaItemVendaTable(this);
  late final $TabelaEntradaTable tabelaEntrada = $TabelaEntradaTable(this);
  late final $TabelaSaidaTable tabelaSaida = $TabelaSaidaTable(this);
  late final $TabelaStockTable tabelaStock = $TabelaStockTable(this);
  late final $TabelaRececcaoTable tabelaRececcao = $TabelaRececcaoTable(this);
  late final $TabelaClienteTable tabelaCliente = $TabelaClienteTable(this);
  late final $TabelaFormaPagamentoTable tabelaFormaPagamento =
      $TabelaFormaPagamentoTable(this);
  late final $TabelaPagamentoTable tabelaPagamento =
      $TabelaPagamentoTable(this);
  late final $TabelaDinheiroSobraTable tabelaDinheiroSobra =
      $TabelaDinheiroSobraTable(this);
  late final $TabelaPagamentoFinalTable tabelaPagamentoFinal =
      $TabelaPagamentoFinalTable(this);
  late final $TabelaSaidaCaixaTable tabelaSaidaCaixa =
      $TabelaSaidaCaixaTable(this);
  late final $TabelaEntidadeTable tabelaEntidade = $TabelaEntidadeTable(this);
  late final $TabelaDefinicoesTable tabelaDefinicoes =
      $TabelaDefinicoesTable(this);
  late final $TabelaDividaTable tabelaDivida = $TabelaDividaTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        tabelaUsuario,
        tabelaFuncionario,
        tabelaProduto,
        tabelaPreco,
        tabelaVenda,
        tabelaItemVenda,
        tabelaEntrada,
        tabelaSaida,
        tabelaStock,
        tabelaRececcao,
        tabelaCliente,
        tabelaFormaPagamento,
        tabelaPagamento,
        tabelaDinheiroSobra,
        tabelaPagamentoFinal,
        tabelaSaidaCaixa,
        tabelaEntidade,
        tabelaDefinicoes,
        tabelaDivida
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$UsuarioDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaUsuarioTable get tabelaUsuario => attachedDatabase.tabelaUsuario;
}
mixin _$StockDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaStockTable get tabelaStock => attachedDatabase.tabelaStock;
}
mixin _$RececcaoDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaRececcaoTable get tabelaRececcao => attachedDatabase.tabelaRececcao;
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
}
mixin _$EntradaDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaEntradaTable get tabelaEntrada => attachedDatabase.tabelaEntrada;
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
  $TabelaRececcaoTable get tabelaRececcao => attachedDatabase.tabelaRececcao;
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
  $TabelaStockTable get tabelaStock => attachedDatabase.tabelaStock;
}
mixin _$ClienteDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaClienteTable get tabelaCliente => attachedDatabase.tabelaCliente;
}
mixin _$PrecoDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaPrecoTable get tabelaPreco => attachedDatabase.tabelaPreco;
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
}
mixin _$SaidaDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaSaidaTable get tabelaSaida => attachedDatabase.tabelaSaida;
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
}
mixin _$ProdutoDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
  $TabelaStockTable get tabelaStock => attachedDatabase.tabelaStock;
  $TabelaPrecoTable get tabelaPreco => attachedDatabase.tabelaPreco;
}
mixin _$FuncionarioDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
  $TabelaUsuarioTable get tabelaUsuario => attachedDatabase.tabelaUsuario;
}
mixin _$ItemVendaDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaItemVendaTable get tabelaItemVenda => attachedDatabase.tabelaItemVenda;
}
mixin _$FormaPagamentoDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaFormaPagamentoTable get tabelaFormaPagamento =>
      attachedDatabase.tabelaFormaPagamento;
}
mixin _$PagamentoDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaPagamentoTable get tabelaPagamento => attachedDatabase.tabelaPagamento;
  $TabelaPagamentoFinalTable get tabelaPagamentoFinal =>
      attachedDatabase.tabelaPagamentoFinal;
}
mixin _$DinheiroSobraDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaDinheiroSobraTable get tabelaDinheiroSobra =>
      attachedDatabase.tabelaDinheiroSobra;
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
}
mixin _$VendaDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaVendaTable get tabelaVenda => attachedDatabase.tabelaVenda;
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
  $TabelaClienteTable get tabelaCliente => attachedDatabase.tabelaCliente;
  $TabelaPagamentoTable get tabelaPagamento => attachedDatabase.tabelaPagamento;
  $TabelaFormaPagamentoTable get tabelaFormaPagamento =>
      attachedDatabase.tabelaFormaPagamento;
  $TabelaItemVendaTable get tabelaItemVenda => attachedDatabase.tabelaItemVenda;
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
  $TabelaPagamentoFinalTable get tabelaPagamentoFinal =>
      attachedDatabase.tabelaPagamentoFinal;
}
mixin _$SaidaCaixaDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaSaidaCaixaTable get tabelaSaidaCaixa =>
      attachedDatabase.tabelaSaidaCaixa;
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
}
mixin _$EntidadeDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaEntidadeTable get tabelaEntidade => attachedDatabase.tabelaEntidade;
}
mixin _$DefinicoesDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaDefinicoesTable get tabelaDefinicoes =>
      attachedDatabase.tabelaDefinicoes;
}
mixin _$DividaDaoMixin on DatabaseAccessor<BancoDados> {
  $TabelaFuncionarioTable get tabelaFuncionario =>
      attachedDatabase.tabelaFuncionario;
  $TabelaClienteTable get tabelaCliente => attachedDatabase.tabelaCliente;
  $TabelaDividaTable get tabelaDivida => attachedDatabase.tabelaDivida;
  $TabelaProdutoTable get tabelaProduto => attachedDatabase.tabelaProduto;
}
