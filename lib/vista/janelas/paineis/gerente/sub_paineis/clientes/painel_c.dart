import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/layout_confirmacao_accao.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_cliente_I.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_caixa_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_cliente.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_saida_caixa.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_cliente.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/layouts/layout_campo.dart';

import '../../../../../../dominio/entidades/estado.dart';

class PainelClientesC extends GetxController {
  late Funcionario funcionario;

  late ManipularClienteI _manipularClienteI;

  PainelClientesC(this.funcionario) {
    _manipularClienteI = ManipularCliente(ProvedorCliente());
  }

  RxList<Cliente> lista = RxList();
  List<Cliente> listaCopia = [];
  @override
  void onInit() {
    pegarDados();
    super.onInit();
  }

  void aoPesquisar(String f) {
    lista.clear();
    var res = listaCopia;
    for (var cada in res) {
      if ((cada.nome ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase()) ||
          (cada.numero ?? "")
              .toLowerCase()
              .toString()
              .contains(f.toLowerCase())) {
        lista.add(cada);
      }
    }
  }

  void mostrarDialogoNovaValor(BuildContext context) {
    mostrarDialogoDeLayou(LayoutCampo(
      accaoAoFinalizar: (valor) async {
        voltar();
        await adincionarCliente(valor);
      },
      titulo: "Insira o Nome!",
    ));
  }

  Future pegarDados() async {
    var res = await _manipularClienteI.todos();
    for (var cada in res) {
      lista.add(cada);
    }

    listaCopia.clear();
    listaCopia.addAll(lista);
  }

  Future<void> adincionarCliente(String nome) async {
    var cliente = Cliente(estado: Estado.ATIVADO, nome: nome, numero: "");
    var id = await _manipularClienteI.registarCliente(cliente);
    cliente.id = id;
    lista.insert(0, cliente);
  }

  void removerCliente(Cliente cliente) async {
    voltar();
    lista.removeWhere((element1) => element1.id == cliente.id);
    await _manipularClienteI.removerCliente(cliente);
  }

  void mostrarDialodoRemover(Cliente element) {
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
          accaoAoCancelar: () {
            voltar();
          },
          accaoAoConfirmar: () {
            removerCliente(element);
          },
          corButaoSim: primaryColor,
          pergunta: "Deseja mesmo eliminar esta Saída",
        ),
        layoutCru: true);
  }

  void mostrarDialogoLimpar(BuildContext context) async {
    mostrarDialogoDeLayou(
        LayoutConfirmacaoAccao(
            corButaoSim: primaryColor,
            pergunta: "Deseja mesmo limpar Tudo",
            accaoAoConfirmar: () async {
              voltar();
              lista.clear();
              await _manipularClienteI.removerTudo();
            },
            accaoAoCancelar: () {}),
        layoutCru: true);
  }

  Future<double> pegarDividaCliente(Cliente lista) async {
    double total = 0;

    return total;
  }
}
