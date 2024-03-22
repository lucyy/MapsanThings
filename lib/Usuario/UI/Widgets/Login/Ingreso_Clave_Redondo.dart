import 'package:flutter/material.dart';
import '../../../../Estilos.dart';
import '../Contenedor_Texto.dart';

final claveControlador= TextEditingController();
class IngresoClaveRedondo extends StatelessWidget {
  bool claveEscondida=true;
  final ValueChanged<String> vcSCambiado;


   IngresoClaveRedondo({
    Key? key,
    required this.vcSCambiado,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return ContenedorTexto(
        hijo: TextField(
          controller: claveControlador,
          obscureText: claveEscondida,
          onChanged: vcSCambiado,
          decoration: InputDecoration(
            hintText: "password",
            icon: Icon(
              Icons.lock,
              color: ColorVerde2,
            ),
            suffixIcon: InkWell(
              onTap: CambioVistaClave,
              child: Icon(
                Icons.visibility,
                color: ColorVerde2,
              ),
            ),
            border: InputBorder.none,
          ),
        )
    );
  }

  void CambioVistaClave(){
       claveEscondida=!claveEscondida;

  }
}
