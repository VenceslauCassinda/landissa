import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:get/get.dart';
import 'package:responsive_layout_builder/responsive_layout_builder.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_funcionario_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_fincionario.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_usuario.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedores_usuario.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';
import 'package:yetu_gestor/vista/aplicacao_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/dinheiro_sobra/painel_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/dividas_encomendas_gerais/painel_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/historico/historico_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/saida_caixa/painel_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/vendas/layouts/vendas_c.dart';
import '../../../../dominio/entidades/painel_actual.dart';
import '../gerente/sub_paineis/clientes/painel_c.dart';
import 'sub_paineis/recepcoes/painel_c.dart';

class PainelFuncionarioC extends GetxController {
  var painelActual =
      PainelActual(indicadorPainel: PainelActual.NENHUM, valor: null).obs;
  late DateTime data;
  late Funcionario funcionarioActual;
  late ManipularFuncionarioI _manipularFuncionarioI;
  PainelFuncionarioC() {
    data = DateTime.now();
    _manipularFuncionarioI = ManipularFuncionario(
        ManipularUsuario(ProvedorUsuario()), ProveedorFuncionario());
  }

  @override
  void onInit() async {
    await inicializarFuncionario();
    super.onInit();
  }

  Future<Funcionario> inicializarFuncionario() async {
    return funcionarioActual =
        await _manipularFuncionarioI.pegarFuncionarioDoUsuarioDeId(
            (pegarAplicacaoC().pegarUsuarioActual())!.id!);
  }

  void terminarSessao() {
    Get.delete<HistoricoC>();
    Get.delete<VendasC>();
    AplicacaoC.terminarSessao();
  }

  void navegar(int indice) {}

  void irParaPainel(int indice, {Object? valor}) {
    if (PainelActual.VENDAS_ANTIGA == indice) {
      Get.delete<VendasC>();
    }
    if (PainelActual.INICIO != painelActual.value.indicadorPainel &&
        PainelActual.INICIO == indice) {
      Get.delete<VendasC>();
    }
    if (PainelActual.DIVIDAS_GERAIS == painelActual.value.indicadorPainel) {
      Get.delete<PainelDividasC>();
    }
    if (PainelActual.DINHEIRO_SOBRA == painelActual.value.indicadorPainel) {
      Get.delete<PainelDinheiroSobraC>();
    }
    if (PainelActual.SAIDA_CAIXA == painelActual.value.indicadorPainel) {
      Get.delete<PainelSaidaCaixaC>();
    }
    if (PainelActual.RECEPCOES == painelActual.value.indicadorPainel) {
      Get.delete<RecepcoesC>();
    }
    if (PainelActual.CLIENTES == painelActual.value.indicadorPainel) {
      Get.delete<PainelClientesC>();
    }
    if (PainelActual.VENDAS_FUNCIONARIOS ==
        painelActual.value.indicadorPainel) {
      Get.delete<VendasC>();
    }
    painelActual.value = PainelActual(indicadorPainel: indice, valor: valor);

    ScreenSize tela = Get.find();
    if (tela.tablet != null||tela.mobile != null) {
      voltar();
    }
  }
}
