import 'dart:io';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class RedSocialNombreIconos extends StatelessWidget {

  final String usPagweb;
  final String usFacebook;
  final String usInstagram;
  final String usTiktok;
  final String usEmail;
  final String usTelefono;



  const RedSocialNombreIconos({Key? key,
    required this.usPagweb,
    required this.usFacebook,
    required this.usInstagram,
    required this.usTiktok,
    required this.usEmail,
    required this.usTelefono,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto=MediaQuery.of(context).size.height;

    return Container(
      height: alto*0.1,
      decoration: BoxDecoration(
        color:Color(0xFFC1D989),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          IconButton(
              icon: Image.asset('assets/icons/web.png'),
              onPressed:(){
                lanzarUrlPagWeb(Uri.parse(usPagweb)
                );
              }
          ),

          IconButton(
            icon: Image.asset('assets/icons/face.png'),
            onPressed:(){
              lanzarUrlFace(Uri.parse(usFacebook)
              );
            },
          ),

          IconButton(
            icon: Image.asset('assets/icons/insta.png'),
            onPressed:(){
              lanzarUrlInsta(Uri.parse(usInstagram)
              );
            },
          ),

          IconButton(
            icon: Image.asset('assets/icons/tik.png'),
            onPressed:(){
              lanzarUrlTik(Uri.parse(usTiktok)
              );
            },
          ),

          IconButton(
            icon: Image.asset('assets/icons/mail.png'),
            onPressed:(){
              lanzarMail(usEmail);
            },
          ),

          IconButton(
            icon: Image.asset('assets/icons/tel.png'),
            onPressed:(){
              lanzarTel(usTelefono);
            },
          ),

        ],
      ),
    );
  }

  Future<void> lanzarUrlPagWeb(Uri urlPagweb) async {
    if (await canLaunchUrl(urlPagweb)) {
      await launchUrl(
          urlPagweb,
          mode: LaunchMode.externalApplication
      );
    }
    else {
      print("no se puede abrir");
    }
  }

  Future<void> lanzarUrlFace(Uri urlFace) async {
    if (await canLaunchUrl(urlFace)) {
      await launchUrl(
          urlFace,
          mode: LaunchMode.externalApplication
      );
    }
    else {
      print("no se puede abrir");
    }
  }

  Future<void> lanzarUrlInsta(Uri urlInsta) async {
    if (await canLaunchUrl(urlInsta)) {
      await launchUrl(
          urlInsta,
          mode: LaunchMode.externalApplication
      );
    }
    else {
      print("no se puede abrir");
    }
  }

  Future<void> lanzarUrlTik(Uri urlTik) async {
    if (await canLaunchUrl(urlTik)) {
      await launchUrl(
          urlTik,
          mode: LaunchMode.externalApplication
      );
    }
    else {
      print("no se puede abrir");
    }
  }

  Future<void> lanzarTel(String telefono) async {
    final Uri lauchTel = Uri(
        scheme: 'tel',
        path: telefono
    );
    if (await canLaunchUrl(lauchTel)) {
      await launchUrl(lauchTel);
    }
    else {
      print("no soportado");
    }
  }

  Future<void> lanzarMail(String email) async {
    final Uri launchMail = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(launchMail)) {
      await launchUrl(launchMail);
    }
    else {
      print("no soportado");
    }
  }

  Future<void> lanzarWhatsapp(String telefono) async {
    List<String> tels=telefono.split('0');
    String tel=tels[1];
    launchUrl(Uri.parse('https://wa.me/593$tel?text='),
        mode: LaunchMode.externalApplication);
  }
}

