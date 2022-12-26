import 'package:componentes_visuais/componentes/icone_item.dart';
import 'package:componentes_visuais/componentes/imagem_circulo.dart';
import 'package:flutter/material.dart';
import '../../dominio/entidades/estado.dart';
import '../../dominio/entidades/nivel_acesso.dart';
import '../../dominio/entidades/usuario.dart';
import '../../recursos/constantes.dart';

class ItemUsuario extends StatelessWidget {
  final Usuario usuario;
  final Function aoClicar;
  final Function? aoEliminar;
  final Function? aoEditar;
  const ItemUsuario({
    Key? key,
    required this.usuario,
    required this.aoClicar,
    required this.aoEliminar,
    this.aoEditar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          aoClicar();
        },
        child: Container(
          height: 100,
          child: Row(
            children: [
              Container(
                  width: 50,
                  margin: EdgeInsets.all(20),
                  child: ImagemNoCirculo(
                      Icon(
                        Icons.person,
                        color: primaryColor,
                      ),
                      20)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nome: ${usuario.nomeUsuario}"),
                  Text("Estado: ${Estado.paraTexto(usuario.estado!)}"),
                  Text(
                      "Usuário: ${NivelAcesso.paraTexto(usuario.nivelAcesso!)}")
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconeItem(
                      metodoQuandoItemClicado: () {
                        aoEditar!();
                      },
                      icone: Icons.edit,
                      titulo: "Editar"),
                ],
              ),
              Visibility(
                visible: aoEliminar != null,
                child: IconeItem(
                    metodoQuandoItemClicado: () {
                      aoEliminar!();
                    },
                    icone: Icons.delete,
                    titulo: "Remover"),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
