import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/entradas/layouts/entradas.dart';

import '../../../../../../dominio/entidades/nivel_acesso.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/responsividade.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../../../../componentes/tab_bar.dart';
import 'layouts/saidas.dart';
import 'layouts/saidas_c.dart';

class PainelSaidas extends StatelessWidget {
  late SaidasC _c;
  final bool visaoGeral;
  late PainelGerenteC _painelGerenteC;
  Function? accaoAoVoltar;
  PainelSaidas({Key? key, required this.visaoGeral, this.accaoAoVoltar})
      : super(key: key) {
    initiC();
    _painelGerenteC = Get.find();
  }

  initiC() {
    try {
      _c = Get.find();
      _c.visaoGeral = visaoGeral;
    } catch (e) {
      _c = Get.put(SaidasC(visaoGeral: visaoGeral));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LayoutPesquisa(
            accaoNaInsercaoNoCampoTexto: (dado) {
              _c.aoPesquisar(dado);
            },
            accaoAoSair: () {
              _c.terminarSessao();
            },
            accaoAoVoltar: () {
              accaoAoVoltar!();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "SAÍDAS",
                style: TextStyle(color: primaryColor, fontSize: 20),
              ),
              Spacer(),
              Container(
                width: !Responsidade.isMobile(context) ? 250 : 130,
                child: Visibility(
                  visible: _painelGerenteC.funcionarioActual.nivelAcesso ==
                      NivelAcesso.GERENTE,
                  child: ModeloButao(
                    corButao: primaryColor,
                    icone: Icons.message,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Relatório",
                    metodoChamadoNoClique: () {
                      _c.gerarRelatorio(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: !Responsidade.isMobile(context) ? 250 : 130,
                child: Visibility(
                  visible: _painelGerenteC.funcionarioActual.nivelAcesso ==
                      NivelAcesso.GERENTE,
                  child: ModeloButao(
                    corButao: primaryColor,
                    icone: Icons.delete_sweep,
                    corTitulo: Colors.white,
                    butaoHabilitado: true,
                    tituloButao: "Limpar",
                    metodoChamadoNoLongoClique: () {
                      _c.mostrarDialogoEliminar(context, false);
                    },
                    metodoChamadoNoClique: () {
                      _c.mostrarDialogoEliminar(context, true);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Visibility(
            visible: !visaoGeral,
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                  "Produto: ${(_painelGerenteC.painelActual.value.valor == null ? null : (_painelGerenteC.painelActual.value.valor as Produto))?.nome ?? "Sem nome"}"),
            )),
        LayoutSaidas(
          visaoGeral: visaoGeral,
        ),
      ],
    );
  }
}
