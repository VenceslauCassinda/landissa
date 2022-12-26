import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_layout_builder/responsive_layout_builder.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/solucoes_uteis/responsividade.dart';
import 'package:yetu_gestor/vista/janelas/paineis/administrador/painel_administrador_c.dart';
import 'componentes/gaveta.dart';
import 'sub_paineis/painel_direito.dart';

class PainelAdministrador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      builder: ((context, size) {
        Get.put(size);
        return Scaffold(
          drawer: size.tablet != null || Responsidade.isMobile(context) == true
              ? Container(
                  color: branca,
                  width: MediaQuery.of(context).size.width * .5,
                  child: const GavetaNavegacao(
                    linkImagem: "",
                  ),
                )
              : null,
          appBar: size.tablet != null
              ? AppBar(
                  backgroundColor: primaryColor,
                )
              : null,
          body: CorpoAdministrador(),
        );
      }),
    );
  }
}

class CorpoAdministrador extends StatelessWidget {
  late PainelAdministradorC _c;
  TextStyle headerStyle = const TextStyle();
  CorpoAdministrador({
    Key? key,
  }) : super(key: key) {
    _c = Get.put(PainelAdministradorC());
  }

  @override
  Widget build(BuildContext context) {
    var tela = Get.find<ScreenSize>();
    if (tela.tablet != null) {
      return PainelDireito(c: _c);
    }
    return Row(
      children: [
        const Expanded(
            flex: 2,
            child: GavetaNavegacao(
              linkImagem: "",
            )),
        Expanded(
          flex: 5,
          child: PainelDireito(c: _c),
        ),
      ],
    );
  }
}
