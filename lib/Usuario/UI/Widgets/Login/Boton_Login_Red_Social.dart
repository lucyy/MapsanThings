import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BotonLoginRedSocial extends StatefulWidget {
 final String textoBoton;
 final Color color;
 final double ancho;
 final Function funcion; //variable que puede recibir una función como parámetro

  const BotonLoginRedSocial({Key? key,
    required this.color,
    required this.ancho,
    required this.textoBoton,
    required this.funcion
  }) : super(key: key);

  @override
  _BotonLoginRedSocialState createState() => _BotonLoginRedSocialState();
}

class _BotonLoginRedSocialState extends State<BotonLoginRedSocial> {
  @override
  Widget build(BuildContext context) {
    Size tamanoPantalla = MediaQuery
        .of(context)
        .size;
    return Container(

        margin: EdgeInsets.symmetric(vertical: 10),
        width: tamanoPantalla.width * 0.6,

        child: ElevatedButton(

          style: ElevatedButton.styleFrom(

              primary: widget.color,
              onPrimary: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              )
          ),
          child: SizedBox(

            child: Center(
              child: Text(widget.textoBoton, textAlign: TextAlign.center,),
            ),
          ),
          onPressed: () => widget.funcion(),
        )
    );

  }
}