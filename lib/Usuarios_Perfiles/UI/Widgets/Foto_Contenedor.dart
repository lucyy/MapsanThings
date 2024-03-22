import 'package:flutter/material.dart';

import '../../Modelo/Foto.dart';

class FotoContenedor extends StatelessWidget {
  final Foto fotoModelo;
  final GestureTapCallback onTap;

  const FotoContenedor({Key? key,
    required this.fotoModelo,
    required this.onTap

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,

        child: Image.asset(fotoModelo.resource.toString(), height: 300.0, width: 450.0,  fit: BoxFit.cover,),
        //  ),
      ),


    );
  }
}

