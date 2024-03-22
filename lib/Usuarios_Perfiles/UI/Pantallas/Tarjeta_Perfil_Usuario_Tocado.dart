

import 'package:flutter/material.dart';
import 'dart:core';
import '../../../Estilos.dart';
import '../../../Usuario/Modelo/Usuario.dart';
import '../Widgets/Imagenes_Precargadas_Perfiles.dart';
import '../Widgets/Red_Social_Nombre_Iconos.dart';
import '../Widgets/Video_Youtube.dart';




class TarjetPerfilUsuarioTocado extends StatefulWidget {

  final Usuario usuario;
  const TarjetPerfilUsuarioTocado({Key? key,
    required this.usuario,

  }) : super(key: key);

  @override
  State<TarjetPerfilUsuarioTocado> createState() => _TarjetPerfilUsuarioTocadoState();
}

class _TarjetPerfilUsuarioTocadoState extends State<TarjetPerfilUsuarioTocado>  {

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto=MediaQuery.of(context).size.height;

    return
      Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.green,
          title: Text('Profile'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/negro.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: Container(

          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                        height: 170,
                        decoration: BoxDecoration(
                            color:Color(0xFFC1D989)
                        )
                    ),
                    Column(
                      children: [
                        SizedBox(height: kDefaultPadding*2,),
                        Row(
                          children: [
                            Container(
                              //Foto de perfil
                              margin: EdgeInsets.only(left: 20, right: 10),
                              height: alto*0.25,
                              width: ancho*0.40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),

                              child:    Container(
                                margin: EdgeInsets.all(10),
                                height: alto*0.15,
                                width: ancho*0.30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12,
                                  image: widget.usuario.urlFotoPerfil.isNotEmpty? DecorationImage(
                                    image: NetworkImage(
                                        widget.usuario.urlFotoPerfil),
                                    fit: BoxFit.cover,
                                  ):
                                  DecorationImage(
                                    image: AssetImage('assets/images/anonimo.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      height: alto*0.09,
                                      child: Text(widget.usuario.nombre, style: TextStyle(
                                          fontSize: 20
                                      ),
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding,),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      width: ancho*0.3,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 5,
                                            offset: Offset(5, 15),
                                          ),
                                        ],
                                      ),
                                      child:
                                      RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: ktextcolor),
                                            children: [
                                              TextSpan(
                                                  text: widget.usuario.profesion+"\n",
                                                  style: TextStyle(fontWeight: FontWeight.bold,
                                                      fontSize: 18)
                                              ),
                                              TextSpan(
                                                text: widget.usuario.especialidad,
                                              )
                                            ]
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: kDefaultPadding,),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),


                SizedBox(height: kDefaultPadding*2,),
                //Descripción

                Container(
                  width: ancho*0.9,
                  margin: EdgeInsets.symmetric(horizontal: ancho*0.1),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(widget.usuario.descripcion,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: kDefaultPadding,),

               ImagenesPrecargadasPerfiles(idUsuario: widget.usuario.idUsuario),
                SizedBox(height: kDefaultPadding*2,),
                VideoYoutube(idVideo: widget.usuario.idVideo),

                RedSocialNombreIconos(
                  usPagweb: widget.usuario.redSocialPagweb,
                  usFacebook: widget.usuario.redSocialFacebook,
                  usInstagram: widget.usuario.redSocialInsta,
                  usTiktok: widget.usuario.redSocialTikTok,
                  usEmail: widget.usuario.redSocialEMail,
                  usTelefono: widget.usuario.redSocialTelefono,

                ),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 0),
                          blurStyle: BlurStyle.normal
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }


}
