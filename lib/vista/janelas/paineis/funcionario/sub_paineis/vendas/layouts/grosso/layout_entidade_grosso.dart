import 'package:componentes_visuais/componentes/formatos/formatos.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../recursos/constantes.dart';
import '../../../../../../../componentes/tab_bar.dart';
import '../vendas.dart';
import '../vendas_c.dart';

class LayoutEntidadeGrosso extends StatelessWidget {
  const LayoutEntidadeGrosso({
    Key? key,
    required this.data,
    required VendasC c,
  })  : _c = c,
        super(key: key);

  final DateTime data;
  final VendasC _c;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Text(
                "${(data.day == DateTime.now().day && data.month == DateTime.now().month && data.year == DateTime.now().year) ? "HOJE" : "DATA"} - ${formatarMesOuDia(data.day)}/${formatarMesOuDia(data.month)}/${data.year}",
                style: const TextStyle(color: primaryColor, fontSize: 20),
              ),
              const Spacer(),
              Expanded(
                  child: ModeloTabBar(
                listaItens: ["TODAS", "VENDAS", "ENCOMENDAS", "DÍVIDAS"],
                indiceTabInicial: 0,
                accao: (indice) {
                  _c.navegar(indice);
                },
              ))
            ],
          ),
        ),
        LayoutVendas(visaoGeral: true),
      ],
    );
  }
}
