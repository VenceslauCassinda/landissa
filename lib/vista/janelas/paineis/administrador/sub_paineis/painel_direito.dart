import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';
import '../../../../../recursos/constantes.dart';
import '../../../../componentes/tab_bar.dart';
import '../layouts/detalhes.dart';
import '../layouts/usuarios.dart';
import '../painel_administrador.dart';
import '../painel_administrador_c.dart';

class PainelDireito extends StatelessWidget {
  const PainelDireito({
    Key? key,
    required PainelAdministradorC c,
  })  : _c = c,
        super(key: key);

  final PainelAdministradorC _c;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LayoutPesquisa(c: _c),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              const Text(
                "USUÁRIOS",
                style: TextStyle(color: primaryColor),
              ),
              const Spacer(),
              Expanded(
                  child: ModeloTabBar(
                listaItens: ["Todos", "Activos", "Desactivos", "Eliminados"],
                indiceTabInicial: 0,
                accao: (indice) {
                  _c.navegar(indice);
                },
              ))
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LayoutUsuarios(c: _c),
                flex: 2,
              ),
              Obx(() {
                if (_c.usuario.value == null) {
                  return Container();
                }
                return Container();
                // return Expanded(
                //   child: LayoutDetalhes(
                //     c: _c,
                //     usuario: _c.usuario.value!,
                //   ),
                //   flex: 1,
                // );
              })
            ],
          ),
        ),
        Visibility(
            visible: !Responsidade.isMobile(context),
            child: GrupoAccoesRodape(c: _c),
            replacement: PopupMenuButton<int>(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Gerir Licença"),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onSelected: ((value) {
                if (value == 0) {
                  _c.definirId();
                  return;
                }
                if (value == 1) {
                  _c.definirLicenca();
                  return;
                }
                if (value == 2) {
                  _c.validarLicenca();
                  return;
                }
              }),
              itemBuilder: ((context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Text("Id da Licença"),
                        Spacer(),
                        Icon(Icons.key)
                      ],
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Text("Chave da Licença"),
                        Spacer(),
                        Icon(Icons.key)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Text("Validar Licença"),
                        Spacer(),
                        Icon(Icons.key)
                      ],
                    ),
                    onTap: () {
                      _c.validarLicenca();
                    },
                  ),
                ];
              }),
            )),
      ],
    );
  }
}

class GrupoAccoesRodape extends StatelessWidget {
  const GrupoAccoesRodape({
    Key? key,
    required PainelAdministradorC c,
  })  : _c = c,
        super(key: key);

  final PainelAdministradorC _c;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 250,
          padding: const EdgeInsets.all(20),
          child: ModeloButao(
            icone: Icons.key,
            corButao: primaryColor,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Id da Licença",
            metodoChamadoNoClique: () {
              _c.definirId();
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 250,
          padding: const EdgeInsets.all(20),
          child: ModeloButao(
            icone: Icons.key,
            corButao: primaryColor,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Licença",
            metodoChamadoNoClique: () {
              _c.definirLicenca();
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 250,
          padding: const EdgeInsets.all(20),
          child: ModeloButao(
            icone: Icons.key,
            corButao: primaryColor,
            corTitulo: Colors.white,
            butaoHabilitado: true,
            tituloButao: "Validar Licença",
            metodoChamadoNoClique: () {
              _c.validarLicenca();
            },
          ),
        ),
      ],
    );
  }
}
