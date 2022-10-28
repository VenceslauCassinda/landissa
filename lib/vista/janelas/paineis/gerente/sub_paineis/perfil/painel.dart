import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/modelo_item_lista.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/perfil/painel_c.dart';

import '../../../../../../recursos/constantes.dart';
import '../../../../../componentes/pesquisa.dart';
import '../../../../../componentes/tab_bar.dart';
import '../../painel_gerente_c.dart';

class PainelPerfil extends StatelessWidget {
  PainelGerenteC c;
  late PainelPerfilC _c;
  PainelPerfil(this.c) {
    iniciar();
  }
  void iniciar() {
    try {
      _c = Get.find();
    } catch (e) {
      _c = Get.put(PainelPerfilC());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 62),
            child: LayoutPesquisa(
              accaoNaInsercaoNoCampoTexto: (dado) {},
              accaoAoVoltar: () {
                c.irParaPainel(PainelActual.FUNCIONARIOS);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              children: [
                Text(
                  "PERFIL",
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
          Obx(
            () => Column(
              children: [
                Card(
                  elevation: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Nome da Entidade: ${_c.entidade.value?.nome ?? "Nenhum"}"),
                                IconeItem(
                                    metodoQuandoItemClicado: () {
                                      _c.mostrarDialogoActualizarNome(
                                          _c.entidade.value?.nome);
                                    },
                                    icone: Icons.edit,
                                    titulo: "")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    "Nif da Entidade: ${_c.entidade.value?.nif ?? "Nenhum"}"),
                                IconeItem(
                                    metodoQuandoItemClicado: () {
                                      _c.mostrarDialogoActualizarNif(
                                          _c.entidade.value?.nif);
                                    },
                                    icone: Icons.edit,
                                    titulo: "")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    "Endereço da Entidade: ${_c.entidade.value?.endereco ?? "Nenhum"}"),
                                IconeItem(
                                    metodoQuandoItemClicado: () {
                                      _c.mostrarDialogoActualizarEndereco(
                                          _c.entidade.value?.endereco);
                                    },
                                    icone: Icons.edit,
                                    titulo: "")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    "Telefone da Entidade: ${_c.entidade.value?.telefone ?? "Nenhum"}"),
                                IconeItem(
                                    metodoQuandoItemClicado: () {
                                      _c.mostrarDialogoActualizarTelefone(
                                          _c.entidade.value?.telefone);
                                    },
                                    icone: Icons.edit,
                                    titulo: "")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
