import 'package:flutter/material.dart';
import 'package:yetu_gestor/recursos/constantes.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: primaryColor,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            minimumSize: Size.fromHeight(40),
          ),
          child: FittedBox(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          onPressed: onClicked,
        ),
      );
}
