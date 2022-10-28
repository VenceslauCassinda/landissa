import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/preco.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos_c.dart';

import '../../../../../recursos/constantes.dart';

class LayoutAdicionarPreco extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorCampoTexto _observadorCampoTexto2;
  late ObservadorButoes _observadorButoes = ObservadorButoes();

  final ProdutosC produtosC;
  final Produto produto;

  late String quantidade = "", preco = "";
  late BuildContext context;

  final RxList<Preco> precos;

  LayoutAdicionarPreco(
      {required this.produtosC, required this.produto, required this.precos}) {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorCampoTexto2 = ObservadorCampoTexto();
    _observadorButoes = ObservadorButoes();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Preço de ${produto.nome}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          CampoTexto(
            textoPadrao: preco,
            context: context,
            campoBordado: false,
            icone: Icon(Icons.lock),
            tipoCampoTexto: TipoCampoTexto.numero,
            dicaParaCampo: "Preço de Venda",
            metodoChamadoNaInsersao: (String valor) {
              preco = valor;
              _observadorCampoTexto2.observarCampo(valor, TipoCampoTexto.preco);
              if (valor.isEmpty) {
                _observadorCampoTexto2.mudarValorValido(
                    true, TipoCampoTexto.preco);
              }
              _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                quantidade,
                preco,
              ], [
                _observadorCampoTexto.valorPrecoValido.value,
                _observadorCampoTexto2.valorNumeroValido.value,
              ]);
            },
          ),
          Obx(() {
            return _observadorCampoTexto2.valorPrecoValido.value == true
                ? Container()
                : LabelErros(
                    sms: "Preço inválido!",
                  );
          }),
          const SizedBox(
            height: 10,
          ),
          CampoTexto(
            textoPadrao: quantidade,
            context: context,
            campoBordado: false,
            tipoCampoTexto: TipoCampoTexto.numero,
            icone: Icon(Icons.text_fields),
            dicaParaCampo: "Quantidade a Subtrair",
            metodoChamadoNaInsersao: (String valor) {
              quantidade = valor;
              _observadorCampoTexto.observarCampo(valor, TipoCampoTexto.numero);
              if (valor.isEmpty) {
                _observadorCampoTexto.mudarValorValido(
                    true, TipoCampoTexto.numero);
              }
              _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                quantidade,
                preco,
              ], [
                _observadorCampoTexto.valorPrecoValido.value,
                _observadorCampoTexto2.valorNumeroValido.value,
              ]);
            },
          ),
          Obx(() {
            return _observadorCampoTexto2.valorNumeroValido.value == true
                ? Container()
                : LabelErros(
                    sms: "Quantidade inválida!",
                  );
          }),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * .15,
                child: ModeloButao(
                  tituloButao: "Cancelar",
                  corButao: primaryColor,
                  corTitulo: Colors.white,
                  butaoHabilitado: true,
                  metodoChamadoNoClique: () async {
                    fecharDialogoCasoAberto();
                  },
                ),
              ),
              Obx(() {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width * .15,
                  child: ModeloButao(
                    corButao: Colors.white.withOpacity(.8),
                    butaoHabilitado: _observadorButoes
                        .butaoFinalizarCadastroInstituicao.value,
                    tituloButao: "Adicionar",
                    metodoChamadoNoClique: () {
                      var novo = Preco(
                          estado: Estado.ATIVADO,
                          quantidade: int.parse(quantidade),
                          idProduto: produto.id,
                          preco: double.parse(preco));
                      precos.add(novo);
                      voltar();
                      produtosC.adicionarPrecoProduto(produto, novo);
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
