import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:componentes_visuais/componentes/item_gaveta.dart';
import 'package:componentes_visuais/componentes/info_gaveta.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/dominio/entidades/painel_actual.dart';
import 'package:yetu_gestor/recursos/constantes.dart';
import 'package:yetu_gestor/vista/componentes/logo.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/painel_gerente_c.dart';

class GavetaNavegacao extends StatelessWidget {
  final String linkImagem;
  final PainelGerenteC c;

  const GavetaNavegacao({Key? key, required this.linkImagem, required this.c})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Logo(
              cor: primaryColor,
              tamanhoTexto: 30.sp,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .8,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<Funcionario>(
                    future: c.inicializarFuncionario(),
                    builder: (c, s) {
                      if (s.data == null) {
                        return CircularProgressIndicator();
                      }
                      return Container(
                        child: InfoGaveta(
                          cor: branca,
                          titulo: "${s.data!.nomeCompelto}",
                        ),
                      );
                    }),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.store,
                    titulo: "Resumo",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.VENDAS);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.people,
                    titulo: "Funcionários",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.FUNCIONARIOS);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.all_inbox_outlined,
                    titulo: "Produtos",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.PRODUTOS);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.arrow_circle_down,
                    titulo: "Recepções",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.RECEPCOES);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.storefront,
                    titulo: "Dívidas",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.DIVIDAS_GERAIS);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.people,
                    titulo: "Clientes",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.CLIENTES);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.arrow_circle_down,
                    titulo: "Entradas",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.ENTRADAS_GERAL);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.arrow_circle_up,
                    titulo: "Saídas",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.SAIDAS_GERAL);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.monetization_on_outlined,
                    titulo: "Dinheiro a mais",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.DINHEIRO_SOBRA);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.monetization_on,
                    titulo: "Caixa",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.SAIDA_CAIXA);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.money,
                    titulo: "Investimento",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.INVESTIMENTO);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.list,
                    titulo: "Inventário",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.INVENTARIO);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.person_outline_outlined,
                    titulo: "Entidade",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.PERFIL);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.settings,
                    titulo: "Definições",
                    metodoQuandoItemClicado: () async {
                      c.irParaPainel(PainelActual.DEFINICOES);
                    }),
                ItemDaGaveta(
                    cor: branca,
                    icone: Icons.logout,
                    titulo: "Sair",
                    metodoQuandoItemClicado: () async {
                      c.terminarSessao();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
