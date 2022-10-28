import 'package:componentes_visuais/componentes/campo_texto.dart';
import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:flutter/material.dart';

class LayoutPesquisa extends StatelessWidget {
  final Function(String dado) accaoNaInsercaoNoCampoTexto;
  Function? accaoAoSair;
  Function? accaoAoVoltar;

  LayoutPesquisa(
      {Key? key,
      required this.accaoNaInsercaoNoCampoTexto,
      this.accaoAoSair,
      this.accaoAoVoltar})
      : super(key: key) {
    // CampoTexto(context: context)
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: accaoAoVoltar != null,
          child: IconeItem(
              metodoQuandoItemClicado: () {
                accaoAoVoltar!();
              },
              icone: Icons.arrow_back,
              tamanho: 40,
              titulo: ""),
        ),
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.black.withOpacity(0.1),
            ),
            child: TextField(
              onChanged: ((value) {
                accaoNaInsercaoNoCampoTexto(value);
              }),
              decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 12),
                  icon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.search),
                  ),
                  focusColor: Colors.black,
                  hintText: "Pesquisar",
                  border: InputBorder.none),
            ),
          ),
        ),
        Visibility(
          visible: accaoAoSair != null,
          child: Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: () {
                if (accaoAoSair != null) {
                  accaoAoSair!();
                }
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
          ),
        )
      ],
    );
  }
}
