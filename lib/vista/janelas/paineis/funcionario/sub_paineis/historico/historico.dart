import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';

import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../painel_funcionario_c.dart';
import 'historico_c.dart';

class PainelHistorico extends StatelessWidget {
  PainelHistorico({
    Key? key,
    required PainelFuncionarioC c,
    required this.funcionario,
    this.accaoAoVoltar,
  })  : _funcionarioC = c,
        super(key: key) {
    initiC();
  }

  late HistoricoC _c;
  final PainelFuncionarioC _funcionarioC;
  final Funcionario funcionario;
  Function? accaoAoVoltar;

  initiC() {
    try {
      _c = Get.find();
      _c.funcionario = funcionario;
    } catch (e) {
      _c = Get.put(HistoricoC(funcionario));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 62),
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
          padding: EdgeInsets.only(left: 25, bottom: 10),
          child: Text(
            "DATAS",
            style: TextStyle(color: primaryColor),
          ),
        ),
        Expanded(
          child: Obx((() {
            return ListView.builder(
                itemCount: _c.lista.length,
                itemBuilder: (c, i) => Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ModeloItemLista(
                        itemComentado: false,
                        metodoChamadoAoClicarItem: () {
                          _c.seleccionarData(_c.lista[i]);
                        },
                        tituloItem:
                            "${formatarMesOuDia(_c.lista[i].day)}/${formatarMesOuDia(_c.lista[i].month)}/${_c.lista[i].year}",
                      ),
                    ));
          })),
        )
      ],
    );
  }
}
