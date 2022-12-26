import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/vista/componentes/item_dinheiro_sobra.dart';

import '../../../../../../dominio/entidades/nivel_acesso.dart';
import '../../../../../../recursos/constantes.dart';
import '../../../../../../solucoes_uteis/formato_dado.dart';
import '../../../../../../solucoes_uteis/responsividade.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_funcionario_c.dart';
import 'painel_c.dart';

class PainelDinheiroSobra extends StatelessWidget {
  PainelDinheiroSobra({
    Key? key,
    required var c,
    required this.funcionario,
    this.accaoAoVoltar,
  })  : _funcionarioC = c,
        super(key: key) {
    initiC();
  }

  late PainelDinheiroSobraC _c;
  var _funcionarioC;
  final Funcionario funcionario;
  Function? accaoAoVoltar;

  initiC() {
    try {
      _c = Get.find();
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(PainelDinheiroSobraC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
              if (accaoAoVoltar != null) {
                accaoAoVoltar!();
              }
              _funcionarioC.irParaPainel(PainelActual.INICIO);
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
              Obx(
                () => Text(
                  "DINHEIRO A MAIS (${formatar(_c.total.value)} KZ)",
                  style: TextStyle(color: primaryColor, fontSize: 20),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 20,
              ),
              Container(
                width: !Responsidade.isMobile(context) ? 250 : 130,
                child: Visibility(
                  visible: _funcionarioC.funcionarioActual.nivelAcesso ==
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Obx((() {
              return ListView.builder(
                  itemCount: _c.lista.length,
                  itemBuilder: (c, i) => ItemDinheiroSobra(
                        dinheiroSobra: _c.lista[i],
                        aoClicar: () {},
                        aoRemover: () {
                          _c.mostrarDialodoRemover(_c.lista[i]);
                        },
                        visaoGeral:
                            funcionario.nivelAcesso == NivelAcesso.GERENTE,
                      ));
            })),
          ),
        ),
        Container(
          // width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child: ModeloButao(
            corButao: primaryColor,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Adicionar Dinheiro",
            metodoChamadoNoClique: () {
              _c.mostrarDialogoNovaValor(context);
            },
          ),
        ),
      ],
    );
  }
}
