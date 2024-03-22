import 'package:flutter/material.dart';

import '../../../Estilos.dart';

class ContenedorTexto extends StatelessWidget {
  final Widget hijo;
  const ContenedorTexto({
    Key? key,
    required this.hijo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size tamanoPantalla= MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: tamanoPantalla.width*0.7,
      decoration: BoxDecoration(
          color: ColorVerde2.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)
      ),
      child: hijo,
    );
  }
}
