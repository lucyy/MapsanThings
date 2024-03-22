
import 'dart:async';
import 'dart:ui';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../../Menu/Pantallas/TabManu.dart';
import '../../../Usuario/Modelo/Usuario.dart';
import '../../../Usuarios_Perfiles/Repositorio/Usuario_Repositorio.dart';
import '../../Repositorio/Usuario_Sesion_Repositorio.dart';
import 'Pantalla_Login.dart';
import 'Pantalla_Perfil_Usuario_Inicial.dart';
//import '../Widgets/Ingreso_Clave_Redondo.dart';





class PantallaComprobacionInicial extends StatefulWidget {
  @override
  _PantallaComprobacionInicialState createState() => _PantallaComprobacionInicialState();
}

class _PantallaComprobacionInicialState extends State<PantallaComprobacionInicial> {

  UsuarioSesionRepositorio usuarioSesionRepositorio=UsuarioSesionRepositorio();
  UsuarioRepositorio usuarioRepositorio=UsuarioRepositorio();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  //context contiene el estado de la vida de la apl/ciación
  @override
  Widget build(BuildContext context) {

    double ancho=MediaQuery.of(context).size.width;
    double alto=MediaQuery.of(context).size.height;

    return StreamBuilder<User?>(

        stream: usuarioSesionRepositorio.EstadoSesion,
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if (!snapshot.hasData || snapshot.hasError) {
            return PantallaLogin(
              usuarioSesionRepo: usuarioSesionRepositorio,
            );
          }
          else if (snapshot.hasData) {
          }
          return FutureBuilder(
              future: usuarioRepositorio.ExisteUsuarioActual(),
              builder:(BuildContext context, AsyncSnapshot<bool> snapshot2) {

                if (snapshot2.data==false) {
                  return PantallaPerfilUsuarioInicial();
                }
                else if ( snapshot2.data==true) {
                  return TabMenu();
                }
                return Container(
                    height: alto,
                    width: ancho,
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator())
                );
              }
          );
        }
    );
  }
}
