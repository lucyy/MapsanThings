import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../Estilos.dart';
import '../../../Usuario/Modelo/Usuario.dart';



class BotonesMovimiento extends StatefulWidget {
  final MapController mapControlador;

  const BotonesMovimiento({Key? key,
    required this.mapControlador,

  }) : super(key: key);

  @override
  _BotonesMovimientoState createState() => _BotonesMovimientoState();
}

class _BotonesMovimientoState extends State<BotonesMovimiento> {

  List<GeoPoint>ubicacionesTemp=[];

  GeoPoint p4=GeoPoint(latitude: -1.304943, longitude: -78.521093);
  double gapLatitud=0.0;
  double gapLongitud=0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ancho=MediaQuery.of(context).size.width;
    double alto=MediaQuery.of(context).size.height;
    return   Align(
      alignment: Alignment.bottomLeft,
      child:

      Container(
        child: Column(
          children: [

            //Arriba
            ElevatedButton(
              style: stlBotonesMovimiento,
              onPressed: () async{

                gapLatitud=await valorMovimiento();
                gapLongitud=0.0;
                await MoverMapa(gapLatitud, gapLongitud);

              }, child:Icon(Icons.arrow_upward),),

            //Izquierda
            ElevatedButton(
                style: stlBotonesMovimiento,
                onPressed: () async{

                  gapLongitud=- await valorMovimiento();
                  gapLatitud=0.0;
                  await MoverMapa(gapLatitud, gapLongitud);

                }, child: Icon(Icons.arrow_back)
            ),

            //Derecha
            ElevatedButton(
                style: stlBotonesMovimiento,
                onPressed: () async{

                  gapLongitud=await valorMovimiento();
                  gapLatitud=0.0;
                  await MoverMapa(gapLatitud, gapLongitud);

                }, child: Icon(Icons.arrow_forward)
            ),

            //Abajo
            ElevatedButton(
                style: stlBotonesMovimiento,
                onPressed: () async{

                  gapLatitud=-await valorMovimiento();
                  gapLongitud=0.0;
                  await MoverMapa(gapLatitud, gapLongitud);

                }, child: Icon(Icons.arrow_downward)
            ),
          ],
        ),
      ),
    );
  }

  Future<void> MoverMapa( double lat, double lon) async {
    GeoPoint miPosicion= await widget.mapControlador.myLocation();
    GeoPoint miNuevaPosicion=GeoPoint(latitude:miPosicion.latitude+ lat, longitude: miPosicion.longitude+lon);
    widget.mapControlador.goToLocation(miNuevaPosicion);
  }

  Future <double> valorMovimiento() async{
    double valor=0.0;
    double zoomActual= await widget.mapControlador.getZoom();
    int zoomActualInt =zoomActual.toInt();
    switch (zoomActualInt)
    {
      case (8):
        {
          valor=1;
          break;
        }
      case (9):
        {
          valor=0.5;
          break;
        }
      case (10):
        {
          valor=0.25;
          break;
        }
      case (11):
        {
          valor=0.13;
          break;
        }
      case (12):
        {
          valor=0.07;
          break;
        }
      case (13):
        {
          valor=0.04;
          break;
        }
      case (14):
        {
          valor=0.02;
          break;
        }
      case (15):
        {
          valor=0.01;
          break;
        }
      case (16):
        {
          valor=0.005;
          break;
        }
      case (17):
        {
          valor=0.0025;
          break;
        }
      case (18):
        {
          valor=0.0013;
          break;
        }
    }
    return valor;
  }
}




/*
class BotonesMovimiento extends StatefulWidget {
  final MapController controladorMapa;


  const BotonesMovimiento({Key? key,
    required this.controladorMapa,

  }) : super(key: key);

  @override
  _BotonesMovimientoState createState() => _BotonesMovimientoState();
}

class _BotonesMovimientoState extends State<BotonesMovimiento> {
  //Agregar_Profesion apAgregar= new Agregar_Profesion(controlador: controlador)

  List<GeoPoint>ubicacionesTemp=[];

  GeoPoint p4=GeoPoint(latitude: -1.304943, longitude: -78.521093);
 double gapLatitud=0.0;
 double gapLongitud=0.0;

  @override
  void initState() {
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    double ancho=MediaQuery.of(context).size.width;
    double alto=MediaQuery.of(context).size.height;
    return   Align(
      alignment: Alignment.bottomLeft,
      child:

      Container(
       // width: ancho*0.2,
      //  height: ancho*0.2,


     child: Column(
       children: [

        //Arriba
         ElevatedButton(
           style: stlBotonesMovimiento,

           onPressed: () async{

             gapLatitud=await valorMovimiento();
                 gapLongitud=0.0;
                 await MoverMapa(gapLatitud, gapLongitud);

           }, child:Icon(Icons.arrow_upward),),

         //Izquierda
             ElevatedButton(
                 style: stlBotonesMovimiento,
                 onPressed: () async{

                   gapLongitud=- await valorMovimiento();
                   gapLatitud=0.0;
                   await MoverMapa(gapLatitud, gapLongitud);

                 }, child: Icon(Icons.arrow_back)
             ),

         //Derecha
             ElevatedButton(
                 style: stlBotonesMovimiento,
                 onPressed: () async{

                   gapLongitud=await valorMovimiento();
                   gapLatitud=0.0;
                   await MoverMapa(gapLatitud, gapLongitud);

                 }, child: Icon(Icons.arrow_forward)
             ),

         //Abajo
         ElevatedButton(
             style: stlBotonesMovimiento,
             onPressed: () async{

               gapLatitud=-await valorMovimiento();
               gapLongitud=0.0;
               await MoverMapa(gapLatitud, gapLongitud);

             }, child: Icon(Icons.arrow_downward)
         ),
       ],
     ),
    ),

    );

  }

  Future<void> MoverMapa( double lat, double lon) async {
    GeoPoint miPosicion= await widget.controladorMapa.centerMap;
    GeoPoint miNuevaPosicion=GeoPoint(latitude:miPosicion.latitude+ lat, longitude: miPosicion.longitude+lon);
    widget.controladorMapa.goToLocation(miNuevaPosicion);
  }

  Future <double> valorMovimiento() async{
    double valor=0.0;
   double zoomActual= await widget.controladorMapa.getZoom();
   int zoomActualInt =zoomActual.toInt();
   switch (zoomActualInt)
   {
     case (8):
       {
         valor=1;
          break;
       }
     case (9):
       {
         valor=0.5;
         break;
       }
     case (10):
       {
         valor=0.25;
         break;
       }
     case (11):
       {
         valor=0.13;
         break;
       }
     case (12):
       {
         valor=0.07;
         break;
       }
     case (13):
       {
         valor=0.04;
         break;
       }
     case (14):
       {
         valor=0.02;
         break;
       }
     case (15):
       {
         valor=0.01;
         break;
       }
     case (16):
       {
         valor=0.005;
         break;
       }
     case (17):
       {
         valor=0.0025;
         break;
       }
     case (18):
       {
         valor=0.0013;
         break;
       }
   }

   return valor;
  }



}


*/
