import 'package:flutter/material.dart';
class FotoContenedorPrecargada extends StatelessWidget {
 // final Foto fotoModelo;
  final ImageProvider imageProvider;
  final GestureTapCallback onTap;

  const FotoContenedorPrecargada({Key? key,
   // required this.fotoModelo,
    required this.onTap,
    required this.imageProvider

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
     child:Image(image: imageProvider,)
      ),

    );
  }
}
