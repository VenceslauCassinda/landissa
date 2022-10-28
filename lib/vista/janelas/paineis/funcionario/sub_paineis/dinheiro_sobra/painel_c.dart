import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_dinheiro_sobra_i.dart';
import 'package:yetu_gestor/dominio/entidades/dinheiro_sobra.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_dinheiro_sobra.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/painel_funcionario_c.dart';
import '../../../../../../dominio/casos_uso/manipular_dinheiro_sobra.dart';
import '../../../../../../dominio/entidades/estado.dart';
import '../../../../../../dominio/entidades/funcionario.dart';
import '../../../../../../recursos/constantes.dart';
import 'layouts/layout_add_valor.dart';

class PainelDinheiroSobraC extends GetxController {
  RxList<DinheiroSobra> lista = RxList([]);
  List<DinheiroSobra> listaCopia = [];
  var total = 0.0.obs;

  late ManipularDinheiroSobraI _manipularDinheiroSobraI;
  late Funcionario funcionario;
  PainelDinheiroSobraC(this.funcionario) {
    _manipularDinheiroSobraI = ManipularDinheiroSobra(ProvedorDinheiroSobra());
  }

  @override
  void onInit() async {
    await pegarLista();
    super.onInit();
  }

  void terminarSessao() {
    PainelFuncionarioC c = Get.find();
    c.terminarSessao();
  }

  void aoPesquisar(String f) {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      if ((DateTime(cada.data!.year, cada.data!.month, cada.data!.day))
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase()) ||
          (cada.funcionario?.nomeCompelto ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (cada.funcionario?.nomeUsuario ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (cada.valor ?? "").toString().contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  pegarLista() async {
    var res = await _manipularDinheiroSobraI.pegarLista();
    for (var cada in res) {
      lista.add(cada);
      total.value += cada.valor ?? 0;
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  void mostrarDialogoNovaValor(BuildContext context) {
    mostrarDialogoDeLayou(LayoutAddValor(
        accaoAoFinalizar: (valor) async {
          await adincionarDinheiro(valor);
        },
        titulo: "Insira o valor a mais"));
  }

  Future<void> adincionarDinheiro(String valor) async {
    var v = double.parse(valor);
    var dinheiro = DinheiroSobra(
        estado: Estado.ATIVADO,
        funcionario: funcionario,
        idFuncionario: funcionario.id,
        valor: v,
        data: DateTime.now());
    voltar();
    var id = await _manipularDinheiroSobraI.adicionarDinheiroSobra(dinheiro);
    total.value += v;
    dinheiro.id = id;
    lista.insert(0, dinheiro);
  }

  void removerDinheiro(DinheiroSobra element) async {
    lista.removeWhere((element1) => element1.id == element.id);
    voltar();
    await _manipularDinheiroSobraI.removerDinheiroSobraDeId(element.id!);
  }

  void mostrarDialodoRemover(DinheiroSobra element) {
    mostrarDialogoDeLayou(LayoutConfirmacaoAccao(
      accaoAoCancelar: () {
        voltar();
      },
      accaoAoConfirmar: () {
        removerDinheiro(element);
      },
      corButaoSim: primaryColor,
      pergunta: "Deseja mesmo eliminar este Dinheiro",
    ));
  }

  void mostrarDialogoEliminar(BuildContext context, bool limparTudo) async {
    if (limparTudo == true) {
      mostrarDialogoDeLayou(
          LayoutConfirmacaoAccao(
              corButaoSim: primaryColor,
              pergunta: "Deseja mesmo limpar Tudo",
              accaoAoConfirmar: () async {
                voltar();
                lista.clear();
                await _manipularDinheiroSobraI.removerTudo();
              },
              accaoAoCancelar: () {}),
          layoutCru: true);
      return;
    }
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje,
        firstDate: hoje.subtract(const Duration(days: 365 * 3)),
        lastDate: hoje);
    if (dataSelecionada == null) {
      return;
    }
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            corButaoSim: primaryColor,
            pergunta:
                "Deseja mesmo limpar dados antes de ${formatarData(dataSelecionada, semHora: true)}",
            accaoAoConfirmar: () async {
              voltar();
              lista.removeWhere(
                  (element) => element.data!.isBefore(dataSelecionada));
              await _manipularDinheiroSobraI.removerAntes(dataSelecionada);
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }
}
