import 'package:flutter/material.dart';

import '../../../Estilos.dart';



class IconoRedSocial extends StatelessWidget {

  final String textoRed;

  const IconoRedSocial({
    Key? key,
    required this.textoRed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: ColorVerde2.withOpacity(0.5),
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      child: Text(
        textoRed,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ColorVerde2
        ),
      ),

    );
  }
}
