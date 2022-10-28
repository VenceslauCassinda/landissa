import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_fincionario.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/fonte_dados/erros.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/vista/aplicacao_c.dart';

import '../../../contratos/casos_uso/manipular_funcionario_i.dart';

class JanelaCadastroC extends GetxController {
  late ManipularFuncionarioI _manipularFuncionarioI;
  JanelaCadastroC() {
    _manipularFuncionarioI = ManipularFuncionario(
        ManipularUsuario(ProvedorUsuario()), ProveedorFuncionario());
  }
  @override
  void onInit() async {
    await iniciarDependencias();
    super.onInit();
  }

  Future<void> iniciarDependencias() async {}

  Future<void> prepararAmbineteMediacao() async {}

  Future<void> orientarRealizacaoCadastro(
      String nome, String palavraPasse) async {
    if (ValidacaoCampos.camposVazio([nome, palavraPasse]) == true) {
      mostrarDialogoDeInformacao("Preencha todos os campos!");
      return;
    }

    try {
      var novoUsuario = await _manipularFuncionarioI.adicionarFuncionario(
          Funcionario(nomeCompelto: nome, palavraPasse: palavraPasse));
      mostrarDialogoDeInformacao("""
      Cadastro realizado!\n
      Seu nome de Usuario é: ${novoUsuario.nomeUsuario}
      """, accaoAoSair: () {
        AplicacaoC.logar(novoUsuario);
      });
    } catch (e) {
      if (e is Erro) {
        mostrarSnack(e.sms);
      } else {
        mostrarDialogoDeInformacao("Erro Desconhecido no Cadastro");
      }
    }
  }
}
