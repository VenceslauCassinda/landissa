import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_caixa_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida_caixa.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_saida_caixa.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/saida_caixa/layout/layout_add_saida_caixa.dart';

import '../../../../../../dominio/entidades/estado.dart';
import '../../../../../../dominio/entidades/saida_caixa.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../../solucoes_uteis/pdf_api/geral_pdf.dart';
import '../../../../../../solucoes_uteis/pdf_api/pdf_api.dart';

class PainelSaidaCaixaC extends GetxController {
  late Funcionario funcionario;

  late ManipularSaidaCaixaI _manipularSaidaCaixaI;

  PainelSaidaCaixaC(this.funcionario) {
    _manipularSaidaCaixaI = ManipularSaidaCaixa(ProvedorSaidaCaixa());
  }

  RxList<SaidaCaixa> lista = RxList();
  List<SaidaCaixa> listaCopia = [];
  var caixaAtual = 0.0.obs;
  @override
  void onInit() {
    pegarDados();
    super.onInit();
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
          (cada.valor ?? "").toString().contains(f.toLowerCase()) ||
          (cada.motivo ?? "")
              .toString()
              .toLowerCase()
              .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  void mostrarDialogoNovaValor(BuildContext context) {
    mostrarDialogoDeLayou(LayoutAddSaidaCaixa(
        accaoAoFinalizar: (valor, motivo, entradaOuSaida) async {
          await adincionarSaida(valor, motivo, entradaOuSaida);
        },
        titulo: "Insira os Dados!"));
  }

  Future pegarDados() async {
    caixaAtual.value = 0;
    var res = await _manipularSaidaCaixaI.pegarLista();
    for (var cada in res) {
      caixaAtual.value += cada.valor ?? 0;
      lista.add(cada);
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  Future<void> adincionarSaida(
      String valor, String motivo, bool entradaOuSaida) async {
    var v = double.parse(valor);
    voltar();
    var saida = SaidaCaixa(
        estado: Estado.ATIVADO,
        funcionario: funcionario,
        idFuncionario: funcionario.id,
        valor: entradaOuSaida == true ? v : -v,
        data: DateTime.now(),
        motivo: motivo);
    caixaAtual.value += saida.valor ?? 0;
    var id = await _manipularSaidaCaixaI.adicionarSaidaCaixa(saida);
    saida.id = id;
    lista.insert(0, saida);
  }

  void removerSaida(SaidaCaixa element) async {
    voltar();
    caixaAtual.value -= element.valor ?? 0;
    lista.removeWhere((element1) => element1.id == element.id);
    await _manipularSaidaCaixaI.removerSaidaCaixaDeId(element.id!);
  }

  void mostrarDialodoRemover(SaidaCaixa element) {
    mostrarDialogoDeLayou(LayoutConfirmacaoAccao(
      accaoAoCancelar: () {
        voltar();
      },
      accaoAoConfirmar: () {
        removerSaida(element);
      },
      corButaoSim: primaryColor,
      pergunta: "Deseja mesmo eliminar esta Saída",
    ));
  }

  void mostrarDialogoRelatorio(BuildContext context) async {
    final hoje = DateTime.now();
    List<List<String>> dados = [];
    var dataInicio = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA INÍCIO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    var dataFim = await showDatePicker(
        initialDate: hoje,
        helpText: "DATA DE TÉRMINO",
        context: context,
        firstDate: DateTime(2021),
        lastDate: hoje);
    if (dataInicio == null || dataFim == null) {
      return;
    }
    if (dataInicio.isAfter(dataFim)) {
      mostrarDialogoDeInformacao(
          "O intervalo entre as data seleccionadas é invalido!");
      return;
    }

    mostrarDialogoDeLayou(const CircularProgressIndicator());
    var todos = await _manipularSaidaCaixaI.pegarLista();
    for (var cada in todos) {
      var depoisDoInicio = ((DateTime(
            cada.data!.year,
            cada.data!.month,
            cada.data!.day,
          )).isAfter(DateTime(
            dataInicio.year,
            dataInicio.month,
            dataInicio.day,
          )) ||
          DateTime(
            cada.data!.year,
            cada.data!.month,
            cada.data!.day,
          ).isAtSameMomentAs(DateTime(
            dataInicio.year,
            dataInicio.month,
            dataInicio.day,
          )));
      var antesDoFim = ((DateTime(
            cada.data!.year,
            cada.data!.month,
            cada.data!.day,
          )).isBefore(DateTime(
            dataFim.year,
            dataFim.month,
            dataFim.day,
          )) ||
          DateTime(
            cada.data!.year,
            cada.data!.month,
            cada.data!.day,
          ).isAtSameMomentAs(DateTime(
            dataFim.year,
            dataFim.month,
            dataFim.day,
          )));
      if (depoisDoInicio == true && antesDoFim == true) {
        dados.add([
          (formatar(cada.valor ?? 0).toString().contains("-") ? "-" : "+"),
          "${formatar(cada.valor ?? 0)} KZ".replaceAll("-", ""),
          (cada.motivo ?? "Nenhum"),
          (formatarData(cada.data!)),
          (formatar(cada.valor ?? 0).toString().contains("-")
              ? "Saída de Caixa"
              : "Entrada de Caixa"),
          (cada.funcionario?.nomeCompelto ?? "Ninguem"),
        ]);
      }
    }

    gerarPDF(dados, caixaAtual.value, dataInicio, dataFim);
  }

  void gerarPDF(List<List<String>> dados, double caixaActual, DateTime de,
      DateTime ate) async {
    voltar();
    try {
      var pdfFile = await GeralPdf.generate(
          "RELATÓRIO DE OPERAÇÕES DE CAIXA",
          [
            "+ / -",
            "Valor",
            "Motivo",
            "Data",
            "Tipo(Operação)",
            "Autor",
          ],
          dados,
          DateTime.now(),
          informacaoExtra:
              "Caixa Actual: ${formatar(caixaActual)}\nEntre ${formatarData(de, semHora: true)} até ${formatarData(ate, semHora: true)}");
      voltar();
      PdfApi.openFile(pdfFile);
    } catch (e) {
      mostrarDialogoDeInformacao(
          "O arquivo ainda está aberto noutro programa!\nPor favor feche!");
    }
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
                await _manipularSaidaCaixaI.removerTudo();
              },
              accaoAoCancelar: () {}),
          layoutCru: true);
      return;
    }
    var hoje = DateTime.now();
    var dataSelecionada = await showDatePicker(
        context: context,
        initialDate: hoje,
        firstDate: hoje.subtract(Duration(days: 365 * 3)),
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
              await _manipularSaidaCaixaI.removerAntesDe(dataSelecionada);
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }
}
