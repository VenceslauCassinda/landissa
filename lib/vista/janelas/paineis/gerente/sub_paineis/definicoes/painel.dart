import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/menu_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/nivel_acesso.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/tabelas/tabela_definicoes.dart';
import 'package:yetu_gestor/vista/componentes/item_saida_caixa.dart';
import 'package:yetu_gestor/vista/janelas/paineis/funcionario/sub_paineis/saida_caixa/painel_c.dart';

import '../../../../../../dominio/entidades/definicoes.dart';
import '../../../../../../dominio/entidades/painel_actual.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/pesquisa.dart';
import 'painel_c.dart';

class PainelDefinicoes extends StatelessWidget {
  late Funcionario funcionario;
  late var c;
  late PainelDefinicoesC definicoesC;
  Function? accaoAoVoltar;

  PainelDefinicoes(this.c, this.funcionario, {this.accaoAoVoltar}) {
    iniciarDependencias();
  }

  void iniciarDependencias() {
    try {
      definicoesC = Get.find();
      definicoesC.funcionario = funcionario;
    } catch (e) {
      definicoesC = Get.put(PainelDefinicoesC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {},
            accaoAoVoltar: () {
              c.irParaPainel(PainelActual.INICIO);
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: const Text(
            "Definições",
            style: TextStyle(color: primaryColor, fontSize: 30),
          ),
        ),
        Obx(() {
          if (definicoesC.definicoesActuais.value == null) {
            return Container();
          }
          return ItemEntidade(
            definicoes: definicoesC.definicoesActuais.value!,
            definicoesC: definicoesC,
          );
        }),
        Obx(() {
          if (definicoesC.definicoesActuais.value == null) {
            return Container();
          }
          return ItemNegocio(
            definicoes: definicoesC.definicoesActuais.value!,
            definicoesC: definicoesC,
          );
        }),
      ],
    );
  }
}

class ItemEntidade extends StatelessWidget {
  const ItemEntidade({
    Key? key,
    required this.definicoes,
    required this.definicoesC,
  }) : super(key: key);

  final Definicoes definicoes;
  final PainelDefinicoesC definicoesC;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Tipo de Entidade: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MenuDropDown(
                    labelMenuDropDown: Definicoes.tipoEntidadeParaTexto(
                        definicoes.tipoEntidade!),
                    metodoChamadoNaInsersao: (dado) {
                      definicoes.tipoEntidade =
                          Definicoes.tipoEntidadeParaInteiro(dado);

                      definicoesC.actualizarDefinicoes(definicoes);
                    },
                    listaItens: [
                      Definicoes.tipoEntidadeParaTexto(TipoEntidade.INDUSTRIAL),
                      Definicoes.tipoEntidadeParaTexto(TipoEntidade.COMERCIAL),
                      Definicoes.tipoEntidadeParaTexto(
                          TipoEntidade.PRESTACAO_SERVICO),
                    ],
                  )
                ],
              ),
            )));
  }
}

class ItemNegocio extends StatelessWidget {
  const ItemNegocio({
    Key? key,
    required this.definicoes,
    required this.definicoesC,
  }) : super(key: key);

  final Definicoes definicoes;
  final PainelDefinicoesC definicoesC;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Tipo de Negócio: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MenuDropDown(
                    labelMenuDropDown: Definicoes.tipoNegocioParaTexto(
                        definicoes.tipoNegocio!),
                    metodoChamadoNaInsersao: (dado) {
                      definicoes.tipoNegocio =
                          Definicoes.tipoNegocioParaInteiro(dado);
                      definicoesC.actualizarDefinicoes(definicoes);
                    },
                    listaItens: [
                      Definicoes.tipoNegocioParaTexto(TipoNegocio.GROSSO),
                      Definicoes.tipoNegocioParaTexto(TipoNegocio.RETALHO),
                    ],
                  )
                ],
              ),
            )));
  }
}
