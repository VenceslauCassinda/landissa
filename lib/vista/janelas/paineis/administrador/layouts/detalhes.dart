// ignore_for_file: unnecessary_string_interpolations

import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:componentes_visuais/componentes/menu_drop_down.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../dominio/entidades/estado.dart';
import '../../../../../dominio/entidades/nivel_acesso.dart';
import '../../../../../dominio/entidades/sessao.dart';
import '../../../../../dominio/entidades/usuario.dart';
import '../../../../../recursos/constantes.dart';
import '../painel_administrador_c.dart';

class LayoutDetalhes extends StatelessWidget {
  String nomeUsuario = "";
  String palavraPasse = "";
  String nivelAcesso = "";
  String estado = "";
  String logado = "";
  Usuario _usuario;
  LayoutDetalhes({
    Key? key,
    required PainelAdministradorC c,
    required Usuario usuario,
  })  : _c = c,
        _usuario = usuario,
        super(key: key) {
    nomeUsuario = _usuario.nomeUsuario!;
    palavraPasse = _usuario.palavraPasse!;
    nivelAcesso = NivelAcesso.paraTexto(_usuario.nivelAcesso!);
    estado = Estado.paraTexto(_usuario.estado!);
    logado = Sessao.paraTexto(_usuario.logado!);
  }

  final PainelAdministradorC _c;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: .1, blurStyle: BlurStyle.outer)],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
        color: branca,
      ),
      margin: const EdgeInsets.only(top: 25),
      child: LayoutBuilder(builder: (c, cr) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: cr.maxHeight),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        InkWell(
                          child: const Icon(Icons.close),
                          onTap: () {
                            _c.mudar(null);
                          },
                        ),
                        const Spacer(),
                        InkWell(
                          child: const Icon(Icons.save),
                          onTap: () async {
                            await _c.actualizarUsuario(nomeUsuario,
                                palavraPasse, nivelAcesso, estado, logado);
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(mainAxisSize: MainAxisSize.max, children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: const ImagemNoCirculo(
                          Icon(
                            Icons.person,
                            color: primaryColor,
                          ),
                          20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CampoTexto(
                        context: context,
                        textoPadrao: _c.usuario.value!.nomeUsuario,
                        dicaParaCampo: "Nome do Usuário",
                        icone: const Icon(Icons.text_fields),
                        campoBordado: false,
                        metodoChamadoNaInsersao: (dado) {
                          nomeUsuario = dado;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CampoTexto(
                        context: context,
                        textoPadrao: _c.usuario.value!.palavraPasse,
                        dicaParaCampo: "Palavra-Passe",
                        icone: const Icon(Icons.text_fields),
                        tipoCampoTexto: TipoCampoTexto.palavra_passe,
                        campoBordado: false,
                        metodoChamadoNaInsersao: (dado) {
                          palavraPasse = dado;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Estado: "),
                          Obx(
                            () {
                              _c.usuario.value;
                              var dado =
                                  "${_c.usuario.value == null ? "Seleccionar Estado" : Estado.paraTexto(_c.usuario.value!.estado!)}";
                              return MenuDropDown(
                                labelMenuDropDown: dado,
                                metodoChamadoNaInsersao: (dado) {
                                  estado = dado;
                                },
                                listaItens: [
                                  "Seleccionar Estado",
                                  "${Estado.paraTexto(Estado.ATIVADO)}",
                                  "${Estado.paraTexto(Estado.DESACTIVADO)}",
                                  "${Estado.paraTexto(Estado.ELIMINADO)}"
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Tipo: "),
                          Obx(
                            () {
                              _c.usuario.value;
                              var dado = _c.usuario.value == null
                                  ? "Seleccionar"
                                  : NivelAcesso.paraTexto(
                                      _c.usuario.value!.nivelAcesso!);
                              return MenuDropDown(
                                labelMenuDropDown: dado,
                                metodoChamadoNaInsersao: (dado) {
                                  nivelAcesso = dado;
                                },
                                listaItens: [
                                  "Seleccionar",
                                  "${NivelAcesso.paraTexto(NivelAcesso.FUNCIONARIO)}",
                                  "${NivelAcesso.paraTexto(NivelAcesso.GERENTE)}",
                                  "${NivelAcesso.paraTexto(NivelAcesso.ADMINISTRADOR)}",
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Sessão: "),
                          Obx(
                            () {
                              _c.usuario.value;
                              var dado = _c.usuario.value == null
                                  ? "Seleccionar Sessão"
                                  : Sessao.paraTexto(_c.usuario.value!.logado!);
                              return MenuDropDown(
                                labelMenuDropDown: dado,
                                metodoChamadoNaInsersao: (dado) {
                                  logado = dado;
                                },
                                listaItens: [
                                  "Seleccionar Sessão",
                                  (Sessao.paraTexto(Sessao.TERMINADA)),
                                  (Sessao.paraTexto(Sessao.INICIADA)),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ]),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
