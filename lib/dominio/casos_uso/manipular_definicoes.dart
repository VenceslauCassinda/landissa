import 'dart:convert';

import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/widgets.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_definicoes_i.dart';
import 'package:yetu_gestor/contratos/provedores/provedor_definicoes_i.dart';
import 'package:yetu_gestor/dominio/entidades/definicoes.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/utils.dart';

class ManipularDefinicoes implements ManipularDefinicoesI {
  final ProvedorDefinicoesI _provedorDefinicoesI;

  ManipularDefinicoes(this._provedorDefinicoesI);

  @override
  Future<void> actualizarDefinicoes(Definicoes dado) async {
    await _provedorDefinicoesI.actualizarDefinicoes(dado);
  }

  @override
  Future<Definicoes> pegarDefinicoesActuais() async {
    return _provedorDefinicoesI.pegarDefinicoesActuais();
  }

  @override
  Future<Map> pegarLicencaNet() async {
    var response = await http.get(Uri.https("veninvestiment.github.io"));
    if (response.statusCode == 200) {
      String htmlToParse = response.body;
      var document = parse(htmlToParse);
      var mapaEmString = document.head!.children[0].text;
      var atuais = await pegarDefinicoesActuais();
      if (atuais.idLicenca == null) {
        throw Erro(
            "Nenhum Id de Licença foi encontrado em seu dispositivo!\nContacte o fornecedor!");
      }
      var mapa = {};
      try {
        mapa = json.decode(mapaEmString);
      } on Exception catch (e) {
        throw Erro(
            "Não foi possível ler os dados do Servidor!\nTente novamente mais tarde!");
      }
      if (mapa.isEmpty) {
        throw Erro(
            "Não foi possível ler os dados do Servidor!\nTente novamente mais tarde!");
      }
      var licencaEmMapa = mapa["${atuais.idLicenca}"];

      if (licencaEmMapa == null) {
        throw Erro(
            "Nenhuma Licença foi encontrado com o Id fornecido!\nContacte o fornecedor!");
      }
      return licencaEmMapa;
    } else {
      throw Erro("Falha na internet!");
    }
  }

  @override
  Future<void> autenticaSistema() async {
    var hoje = DateTime.now();
    var atuais = await pegarDefinicoesActuais();

    if ((atuais.licenca ?? "").isEmpty) {
      throw Erro(
          "Não foi encontrada nenhuma licença em seu dispositivo!\nPor favor contacte o administrador do sistema!");
    }
    if (atuais.dataAcesso == null) {
      atuais.dataAcesso = hoje;
      await actualizarDefinicoes(atuais);
    }
    if (hoje.isBefore(atuais.dataAcesso!) == true) {
      throw Erro(
          "Actualize a sua data!\nSe este erro prevalecer, por favor contacte o administrador do sistema!");
    }
    atuais.dataAcesso = hoje;
    await actualizarDefinicoes(atuais);

    if (atuais.dataExpiracao == null) {
      await validarLicencaDaNet(atuais, hoje);
    } else {
      if (hoje.isAfter(atuais.dataExpiracao!) == true) {
        throw ErroLicencaExpirada(
            "Licença Expirada!\nPor favor contacte o administrador do sistema para obter uma nova licença válida!");
      }
      return;
    }
    if (atuais.licenciado == true) {
      return;
    }
  }

  Future<void> validarLicencaDaNet(Definicoes atuais, DateTime hoje) async {
    var licencaNet = await pegarLicencaNet();
    var licenca = licencaNet["licenca"];

    if (atuais.licenca != licenca) {
      throw Erro(
          "Licença inválida!\nPor favor contacte o administrador do sistema para obter uma licença válida!");
    }

    var dataExpiracao;

    try {
      var arrayDataExpiracao =
          licencaNet["data_expiracao"].toString().split("-");
      dataExpiracao = DateTime(int.parse(arrayDataExpiracao[2]),
          int.parse(arrayDataExpiracao[1]), int.parse(arrayDataExpiracao[0]));
    } on Exception catch (e) {
      throw Erro("Dados Inválidos do Servidor!");
    }

    if (hoje.isAfter(dataExpiracao) == true) {
      atuais.licenciado = false;
      atuais.licenca = "";
      await actualizarDefinicoes(atuais);
      throw Erro(
          "Licença já Expirada!\nPor favor contacte o administrador do sistema para obter uma nova licença válida!");
    }
    if (licencaNet["usada"] != null) {
      atuais.licenciado = false;
      atuais.licenca = "";
      await actualizarDefinicoes(atuais);
      throw Erro(
          "Licença já Usada!\nPor favor contacte o administrador do sistema para obter uma nova licença válida!");
    }
    atuais.dataExpiracao = dataExpiracao;
    atuais.licenciado = true;
    await actualizarDefinicoes(atuais);
  }
}
