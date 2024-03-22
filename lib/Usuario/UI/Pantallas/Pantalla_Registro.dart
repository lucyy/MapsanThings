import 'package:flutter/material.dart';
import 'package:mapsandthings/Usuario/UI/Pantallas/Pantalla_Login.dart';

import '../../../Estilos.dart';

import '../Widgets/Icono_Red_Social.dart';
import '../Widgets/Login/Boton_Elevado.dart';
import '../Widgets/Login/Ingreso_Clave_Redondo.dart';
import '../Widgets/Linea_Divisora.dart';
import '../Widgets/Login/Ingreso_Texto_Redondo.dart';

class PantallaSignUp extends StatelessWidget {


  const PantallaSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size tamanoPantalla=MediaQuery.of(context).size;


    return Scaffold(

        body: Container(
        width: double.infinity,
        height: tamanoPantalla.height,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Text("SIGN UP",
          style: TextStyle(
              fontWeight: FontWeight.bold,
            color: ColorVerde2,
          ),
         ),
          SizedBox(height: tamanoPantalla.height*0.03,),
          IngresoTextoRedondo(
              textoFondo: "e-mail",
              vcSCambiado: (value){},
              icono: Icons.person
          ),
          IngresoClaveRedondo(
              vcSCambiado: (value){}
          ),
          BotonElevado(
              texto: "SIGN UP",
              funcion: ()  {},

              color: ColorVerde2,
             textoColor: Colors.white,



          ),
          SizedBox(height: tamanoPantalla.height*0.03,),
          LineaDivisora(),
          SizedBox(height: tamanoPantalla.height*0.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconoRedSocial(
                textoRed: "  f  ",
              ),
              SizedBox(width: tamanoPantalla.width*0.03,),
              IconoRedSocial(
                textoRed: "G+",
              ),
            ],
          ),

          BotonElevado(
            texto: "SIGN IN",
            color: ColorVerde2.withOpacity(0.5),
            textoColor: Colors.white,
            funcion: (){

              Navigator.pop(context);

            },

          ),

      ]
    ),
        )
    );
  }
}
