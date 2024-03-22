
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';


//se define un callback para poder usar una función de otro widget en este
typedef GeoPointCallback = void Function(GeoPoint point);

class MapaUbicacion extends StatefulWidget   {
  const MapaUbicacion({Key? key,
  }) : super(key: key);

  @override
  _MapaUbicacionState createState() => _MapaUbicacionState();
}
//AutomaticKeepAliveClientMixin crea la persistencia para el mapa
class _MapaUbicacionState extends State<MapaUbicacion>  with  AutomaticKeepAliveClientMixin< MapaUbicacion>  {


  @override
  bool get wantKeepAlive => true;
  bool colorbool=true;
  Color color1=Colors.transparent;
  Color color2=Colors.black.withOpacity(0.5);
  late MapController controladorMap;


  @override
  void dispose() {
    /// OSM
    super.dispose();
  }

  @override
  void initState() {
    print('el estado inicial del mapa');
    // DescargarUsuariosdeFirebase();
    controladorMap = MapController(

      //  initMapWithUserPosition: true,
      // initPosition: GeoPoint(latitude: -1.262, longitude: -78.62),
      // areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
      areaLimit: BoundingBox( east: 5.4922941, north: 20.8084648, south: 20.817995, west: 2.9559113,),
    );


    agregarMiUbicacion();
    //MapControllerSingleton().setMapController(controladorMap);
    super.initState();

  }

//longitude: -1.2607849481302396,latitude: -78.63043748326943,
  Future<void> agregarMiUbicacion() async{
    Position posicion1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
GeoPoint posicion2=GeoPoint(latitude: posicion1.latitude, longitude: posicion1.longitude);
    await controladorMap.addMarker(

        posicion2,
        markerIcon:
        MarkerIcon(
          icon: Icon(Icons.location_history, color: Colors.green,size: 150,),
        ),
        angle: 0
    );

   print('geooopoinnnnnnnnn'+posicion2.toString());
  }

  @override
  Widget build(BuildContext context) {



    double _zoom = 12.0;
    return

      Scaffold(
        appBar: AppBar(title: Text('My Location'),),
          body:

          Stack(

              children: <Widget>[

                OSMFlutter(

                  controller:controladorMap,
               //   trackMyPosition: false,
                  //el zoom máximo es 18
                  initZoom: 16,
                  minZoomLevel: 8,
                  // maxZoomLevel: 14,
                  stepZoom: 1.0,
                  userLocationMarker: UserLocationMaker(
                    personMarker: MarkerIcon(   //marker icon posicion actual
                      icon: Icon(
                        Icons.person_pin,
                        color: Colors.green,
                        size: 150,
                      ),
                    ),
                    directionArrowMarker: MarkerIcon(
                      icon: Icon(
                        Icons.person_pin,
                        size: 150,
                      ),
                    ),
                  ),
                ),

                Container(
                  color:colorbool? color1:color2,
                ),
                 Positioned(
                   left: 0,
                   right: 0,
                   bottom: 0,
                   child: Container(


                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                     // BotonElevadoActualizarUbicacion (controlador:controladorMap),
                                    SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                       ElevatedButton(
                                             onPressed: (){
                                               setState(() {
                                                 colorbool=! colorbool;
                                                 });
                                             },
                                             child:colorbool? Text('Hide'):Text('Show'))
                                          ]
                                      ),
                                     // SizedBox(height: 10,),

                                      SizedBox(height: 10,),

                                    ],
                                  ),
                                ),
                 ),





              ]
          ),

      );
  }


}



