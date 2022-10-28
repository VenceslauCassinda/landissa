import 'dart:io';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_definicoes.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/vista/componentes/sobre_app.dart';
import '../../../contratos/casos_uso/manipular_usuario_i.dart';
import '../../aplicacao_c.dart';

class JanelaLoginC extends GetxController {
  bool repositorioWebPreparado = false;

  late ManipularUsuarioI _manipularUsuarioI;

  @override
  void onInit() async {
    _manipularUsuarioI = ManipularUsuario(ProvedorUsuario());
    await inicializarDependencias();
    super.onInit();
  }

  Future<void> inicializarDependencias() async {}

  mostrarDialogo(BuildContext context) {
    Get.dialog(Container(
      width: MediaQuery.of(context).size.width * .7,
      height: 200,
      child: CircularProgressIndicator(),
    ));
  }

  mostrarDialogoSobreApp(BuildContext context) {
    Get.defaultDialog(title: "", content: SobreApp());
  }

  mostrarImagem(BuildContext context, File arquivo) {
    Get.dialog(Container(
      width: MediaQuery.of(context).size.width * .7,
      child: Image.file(arquivo),
    ));
  }

  Future<void> pegarListaUsuario() async {}

  Future<void> fazerLogin(String nome, String palavraPasse) async {
    if (ValidacaoCampos.camposVazio([nome, palavraPasse]) == true) {
      mostrarDialogoDeInformacao("Preencha todos os campos!");
      return;
    }

    try {
      var usuario = await _manipularUsuarioI.fazerLogin(nome, palavraPasse);
      try {
        ManipularDefinicoes def = Get.find();
        await def.autenticaSistema();
        voltar();
      } catch (e) {
        voltar();
        mostrarDialogoDeInformacao((e as Erro).sms);
        if (usuario!.nivelAcesso != NivelAcesso.ADMINISTRADOR) {
          return;
        }
      }
      AplicacaoC.logar(usuario!);
    } catch (e) {
      if (e is Erro) {
        var exception = e as Erro;
        mostrarSnack(exception.sms);
      }
    }
  }
}
