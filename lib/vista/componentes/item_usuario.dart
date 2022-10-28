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
  const ItemUsuario({
    Key? key,
    required this.usuario,
    required this.aoClicar,
    required this.aoEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          aoClicar();
        },
        leading: Container(
            width: 50,
            child: ImagemNoCirculo(
                Icon(
                  Icons.person,
                  color: primaryColor,
                ),
                20)),
        title: Text("${usuario.nomeUsuario}"),
        subtitle: Text("Estado: ${Estado.paraTexto(usuario.estado!)}"),
        trailing: Container(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Usuário: ${NivelAcesso.paraTexto(usuario.nivelAcesso!)}"),
              SizedBox(
                width: 10,
              ),
              Visibility(
                visible: aoEliminar != null,
                child: IconeItem(
                    metodoQuandoItemClicado: () {
                      aoEliminar!();
                    },
                    icone: Icons.delete,
                    titulo: "Remover"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
