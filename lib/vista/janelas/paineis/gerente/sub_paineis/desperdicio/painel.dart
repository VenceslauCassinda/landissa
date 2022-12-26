import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/formato_dado.dart';
import 'package:yetu_gestor/vista/componentes/item_desperdicio.dart';
import 'package:yetu_gestor/vista/componentes/item_investimento.dart';
import '../../../../../../dominio/entidades/nivel_acesso.dart';
import '../../../../../../dominio/entidades/painel_actual.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/responsividade.dart';
import '../../../../../componentes/tab_bar.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_gerente_c.dart';
import 'painel_c.dart';

class PainelDesperdicio extends StatelessWidget {
  late PainelDesperdicioC _c;
  Function? accaoAoVoltar;
  final PainelGerenteC gerenteC;
  PainelDesperdicio({Key? key, required this.gerenteC, this.accaoAoVoltar}) {
    initiC();
  }

  initiC() {
    try {
      _c = Get.find();
    } catch (e) {
      _c = Get.put(PainelDesperdicioC());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
              Obx(() {
                return Text(
                  "DESPERDÍCIOS (${formatar(_c.totalDesperdicio.value)} KZ)",
                  style: const TextStyle(color: primaryColor, fontSize: 20),
                );
              }),
              const Spacer(),
              Container(
                width: !Responsidade.isMobile(context) ? 250 : 130,
                child: Visibility(
                  visible: gerenteC.funcionarioActual.nivelAcesso ==
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        Expanded(
          child: Obx(() {
            if (_c.lista.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(child: Text("Sem Dados!")),
                ],
              );
            }
            return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: _c.lista.length,
                    itemBuilder: (c, i) => InkWell(
                          onTap: () {},
                          child: ItemDesperdicio(
                            produto: _c.lista[i],
                            c: _c,
                          ),
                        )));
          }),
        ),
      ],
    );
  }
}
