
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../Estilos.dart';
import '../../Repositorio/Usuario_Sesion_Repositorio.dart';
import '../Widgets/Login/Boton_Elevado.dart';
import '../Widgets/Login/Boton_Login_Red_Social.dart';
import '../Widgets/Login/Ingreso_Clave_Redondo.dart';
import '../Widgets/Login/Ingreso_Texto_Redondo.dart';
import 'Pantalla_Registro.dart';




class PantallaLogin extends StatelessWidget {
  final UsuarioSesionRepositorio usuarioSesionRepo;

/////////////////////////////////////estaba constante
  PantallaLogin({
    Key? key,
    required this.usuarioSesionRepo,

  }) : super(key: key);

  TextEditingController controladorEmail=TextEditingController();
  TextEditingController controladorNombreUsuario= TextEditingController();
 // DatabaseMethods databaseMethods= new DatabaseMethods();



  @override
  Widget build(BuildContext context) {

      Size tamanoPantalla= MediaQuery.of(context).size;
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: tamanoPantalla.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                IngresoTextoRedondo(
                  textoFondo: "e-mail",
                  vcSCambiado: (value){},
                  icono: Icons.person,
                ),
                IngresoClaveRedondo(
                  vcSCambiado: (value){},
                ),
                BotonElevado(
                  texto: "SIGN IN",
                  funcion: (){},
                  color: ColorVerde2,
                  textoColor: Colors.white,
                ),
                SizedBox(height: tamanoPantalla.height*0.03,),

                BotonLoginRedSocial(
                    color: ColorRojoGoogle,
                    ancho: 250.0,
                    textoBoton: "Sign in with Gmail",
                    funcion: () async {

                      await usuarioSesionRepo.signInGoogleFire().then((nombreemail ){


                          print('sesion abierta');

                        });

                    }
                ),

                Text("You do not have an account?",
                  style: TextStyle(
                    color: ColorVerde2,
                  ),
                ),
                BotonElevado(
                  texto: "CREATE ACCOUNT",
                  color: ColorVerde2.withOpacity(0.5),
                  textoColor: Colors.white,
                  funcion: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return PantallaSignUp();
                        },
                      ),
                    );


                  },

                ),
              ]
          ),
        ),
      );
    }
  }


