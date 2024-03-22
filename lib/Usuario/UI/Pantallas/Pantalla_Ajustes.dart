import 'package:flutter/material.dart';

import '../Widgets/Ajustes/Item_Ajuste.dart';
import '../Widgets/Linea_Divisora.dart';
class PantallaAjustes extends StatefulWidget {

  const PantallaAjustes({Key? key,
}) : super(key: key);

  @override
  _PantallaAjustesState createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  @override
  Widget build(BuildContext context) {

   double ancho=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Ajustes'),),
      body: Container(
         child:

         ListView(
              children:<Widget> [

                //Privacidad
                ItemAjuste(
                    icono: Icon(Icons.lock),
                    titulo: 'Privacy',
                    funcion: (){},
                    contenido: 'content'),

                LineaDivisora(),

                //Seguridad
                ItemAjuste(
                    icono: Icon(Icons.security),
                    titulo: 'Security',
                    funcion: (){},
                    contenido: 'content'),

                LineaDivisora(),

                //Ayuda
                ItemAjuste(
                    icono: Icon(Icons.help),
                    titulo: 'Help',
                    funcion: (){},
                    contenido: 'content'),

                LineaDivisora(),

              ],
            ),


      ),
    );
  }
}
