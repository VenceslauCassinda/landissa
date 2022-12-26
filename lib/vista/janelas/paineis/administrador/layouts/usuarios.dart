import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../dominio/entidades/estado.dart';
import '../../../../../dominio/entidades/nivel_acesso.dart';
import '../../../../../dominio/entidades/usuario.dart';
import '../../../../../recursos/constantes.dart';
import '../../../../componentes/item_usuario.dart';
import '../painel_administrador_c.dart';

class LayoutUsuarios extends StatelessWidget {
  const LayoutUsuarios({
    Key? key,
    required PainelAdministradorC c,
  })  : _c = c,
        super(key: key);

  final PainelAdministradorC _c;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _c.usuarios
                .map((Usuario element) => ItemUsuario(
                      usuario: element,
                      aoClicar: () {
                        _c.mudar(element);
                      },
                      aoEditar: () {
                        _c.mudar(element);
                      },
                      aoEliminar: _c.indiceTabActual == 3
                          ? () {
                              _c.mostrarDialogoEliminar(element);
                            }
                          : null,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class LayoutPesquisa extends StatelessWidget {
  const LayoutPesquisa({
    Key? key,
    required PainelAdministradorC c,
  })  : _c = c,
        super(key: key);

  final PainelAdministradorC _c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: CampoTexto(
              context: context,
              campoBordado: false,
              icone: const Icon(Icons.search),
              metodoChamadoNaInsersao: (dado) {
                _c.dadoPesquisado.value = dado;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: () {
                _c.terminarSessao();
              },
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Sair")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
