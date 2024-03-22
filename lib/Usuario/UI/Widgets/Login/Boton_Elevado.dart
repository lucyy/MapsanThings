import 'package:flutter/material.dart';

class BotonElevado extends StatelessWidget {
  //variables
  final String texto;
  final Function funcion;
  final Color color,textoColor;

  const BotonElevado({
    Key? key,
    required this.texto,
    required this.funcion,
   required this.color,
   required this.textoColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size tamanoPantalla= MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      width: tamanoPantalla.width*0.7,

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(

            primary: color,
            onPrimary: textoColor,
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        child: SizedBox(

          child: Center(
            child: Text(texto, textAlign: TextAlign.center,),
          ),
        ),
        onPressed: ()=> funcion(),
      ),
    );
  }
}
