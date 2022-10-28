import 'package:componentes_visuais/componentes/butoes.dart';
import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/label_erros.dart';
import 'package:componentes_visuais/componentes/observadores/observador_butoes.dart';
import 'package:componentes_visuais/componentes/observadores/observador_campo_texto.dart';
import 'package:componentes_visuais/componentes/validadores/validadcao_campos.dart';
import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/vista/janelas/paineis/gerente/sub_paineis/produtos/layouts/produtos_c.dart';

import '../../../../../recursos/constantes.dart';

class LayoutProduto extends StatelessWidget {
  late ObservadorCampoTexto _observadorCampoTexto;
  late ObservadorCampoTexto _observadorCampoTexto2;
  late ObservadorButoes _observadorButoes = ObservadorButoes();

  final Function(String nome, String precoCompra) accaoAoFinalizar;

  late ProdutosC _c;
  Produto? produto;

  late String nome, precoCompra;
  late BuildContext context;

  LayoutProduto({this.produto, required this.accaoAoFinalizar}) {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorCampoTexto2 = ObservadorCampoTexto();
    _observadorButoes = ObservadorButoes();

    _c = Get.find();
    if (produto != null) {
      nome = "${produto?.nome}";
      precoCompra = "${produto?.precoCompra}";
    } else {
      nome = "";
      precoCompra = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "DADOS DO PRODUCTO",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          CampoTexto(
            textoPadrao: nome,
            context: context,
            campoBordado: false,
            icone: Icon(Icons.text_fields),
            dicaParaCampo: "Nome do Produto",
            metodoChamadoNaInsersao: (String valor) {
              nome = valor;
              _observadorCampoTexto.observarCampo(valor, TipoCampoTexto.nome);
              if (valor.isEmpty) {
                _observadorCampoTexto.mudarValorValido(
                    true, TipoCampoTexto.nome);
              }
              _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                nome,
                precoCompra,
              ], [
                _observadorCampoTexto.valorNomeValido.value,
                _observadorCampoTexto.valorNumeroTelefoneValido.value,
                _observadorCampoTexto2.valorNumeroValido.value,
              ]);
            },
          ),
          Obx(() {
            return _observadorCampoTexto.valorNomeValido.value == true
                ? Container()
                : LabelErros(
                    sms: "Este Nome ainda é inválido!",
                  );
          }),
          const SizedBox(
            height: 10,
          ),
          CampoTexto(
            textoPadrao: precoCompra,
            context: context,
            campoBordado: false,
            icone: Icon(Icons.lock),
            tipoCampoTexto: TipoCampoTexto.numero,
            dicaParaCampo: "Preço de Compra",
            metodoChamadoNaInsersao: (String valor) {
              precoCompra = valor;
              _observadorCampoTexto2.observarCampo(valor, TipoCampoTexto.preco);
              if (valor.isEmpty) {
                _observadorCampoTexto2.mudarValorValido(
                    true, TipoCampoTexto.preco);
              }
              _observadorButoes.mudarValorFinalizarCadastroInstituicao([
                nome,
                precoCompra,
              ], [
                _observadorCampoTexto.valorNomeValido.value,
                _observadorCampoTexto.valorNumeroValido.value,
                _observadorCampoTexto2.valorPrecoValido.value,
              ]);
            },
          ),
          Obx(() {
            return _observadorCampoTexto2.valorPrecoValido.value == true
                ? Container()
                : LabelErros(
                    sms: "Preço de Compra inválido!",
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
                    tituloButao: produto == null ? "Finalizar" : "Actualizar",
                    metodoChamadoNoClique: () {
                      accaoAoFinalizar(nome, precoCompra);
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
