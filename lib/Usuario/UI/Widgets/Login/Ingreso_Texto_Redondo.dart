import 'package:flutter/material.dart';
import '../../../../Estilos.dart';
import '../Contenedor_Texto.dart';

final emailControlador=TextEditingController();

class IngresoTextoRedondo extends StatefulWidget {
  final String textoFondo;
  final IconData icono;
  final ValueChanged<String> vcSCambiado;

  const IngresoTextoRedondo({
    Key? key,
    required this.textoFondo, //variables requeridas cuando se llama al widget
    required this.vcSCambiado,
    required this.icono,
  }) : super(key: key);

  @override
  _IngresoTextoRedondoState createState() => _IngresoTextoRedondoState();
}

class _IngresoTextoRedondoState extends State<IngresoTextoRedondo> {
 // final emailControlador=TextEditingController();
  //final claveControlador= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ContenedorTexto(
      hijo: TextField(
        controller: emailControlador,
       // onChanged: widget.vcSCambiado,
        decoration: InputDecoration(
          icon: Icon(
            widget.icono,
            color: ColorVerde2,
          ),
          hintText: widget.textoFondo,
          border: InputBorder.none,

        ),
      ),
    );
  }
}
