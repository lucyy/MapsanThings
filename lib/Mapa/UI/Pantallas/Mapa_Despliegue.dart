
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart'  hide GeoPoint;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../../Estilos.dart';
import '../../../Usuario/Modelo/Usuario.dart';
import '../../../Usuarios_Perfiles/Bloc/DataFirebase_Bloc/Data_Fire_Bloc.dart';
import '../../../Usuarios_Perfiles/Bloc/DataFirebase_Bloc/Data_Fire_State.dart';
import '../../../Usuarios_Perfiles/UI/Pantallas/Tarjeta_Perfil_Usuario_Tocado.dart';
import '../../Modelo/OSM_Singleton.dart';
import '../Widgets/Boton_Flotante_Desplegable.dart';
import '../Widgets/Boton_Flotante_MiUbicacion.dart';


//se define un callback para poder usar una función de otro widget en este
typedef GeoPointCallback = void Function(GeoPoint point);

class MapaDespliegue extends StatefulWidget   {
  const MapaDespliegue({Key? key,
  }) : super(key: key);

  @override
  _MapaDespliegueState createState() => _MapaDespliegueState();
}
//AutomaticKeepAliveClientMixin crea la persistencia para el mapa
class _MapaDespliegueState extends State<MapaDespliegue>  with  AutomaticKeepAliveClientMixin< MapaDespliegue>  {

  @override
  bool get wantKeepAlive => true;

  MapController mapControlador= MapController(

    areaLimit: BoundingBox( east: 5.4922941, north: 20.8084648, south: 20.817995, west: 2.9559113,),
  );
  List<Usuario> listaUsuarios=[];
  File? fotoFile;
  final fotoPerfilCacheManager = DefaultCacheManager();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
  //  OSMSingleton().EstablecerMapaControlador(mapControlador);
/*
    mapControlador = MapController(

        areaLimit: BoundingBox( east: 5.4922941, north: 20.8084648, south: 20.817995, west: 2.9559113,),
      );

 */
    MapControllerSingleton().setMapController( mapControlador);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ancho=MediaQuery.of(context).size.width;
    double alto=MediaQuery.of(context).size.height;

    Future<void> SeleccionarUbicacion(GeoPoint point) async{
      Usuario usuarioTocado=Usuario.vacio();
      List<Usuario> usuariosTocados=[];

      Future<void>  cargarInfo() async{

        print(point);

        String stLat=point.latitude.toString();
        String stLon=point.longitude.toString();
        String ubicacionTocada=stLat+'+'+stLon;
        usuariosTocados=await  listaUsuarios.where((user) => user.ubicacion==ubicacionTocada) .toList();

        usuarioTocado=await usuariosTocados.first;
        //el primer usuario

        if(usuarioTocado.urlFotoPerfil!='')
        {
          final filefotoTemp =await fotoPerfilCacheManager.getSingleFile(usuarioTocado.urlFotoPerfil);
          setState(() {
            fotoFile=filefotoTemp;
          }
          );
        }
        else {
          setState(() {
            fotoFile = null;
          });
        }
      }

      await showDialog(
          context: context,
          builder: (BuildContext context) {
            double ancho = MediaQuery
                .of(context)
                .size
                .width;
            double alto = MediaQuery
                .of(context)
                .size
                .height;

            return FutureBuilder(
              future: cargarInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()
                  );
                }
                else if (snapshot.hasError) {
                  return Text('Error al cargar los datos');
                }
                else {
                  return AlertDialog(
                    backgroundColor: ColorVerde2.withAlpha(20),
                    content:
                    Container(
                      // height: alto*0.6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              // width: ancho,
                              child: Column(
                                children: [
                                  Text(
                                    usuarioTocado.nombre,
                                    style: stlLetrasBlancas,),
                                  SizedBox(height: 5,),
                                  Text(usuarioTocado.profesion,
                                      style: stlLetrasBlancas),
                                  SizedBox(height: 5,),
                                  Text(usuarioTocado.especialidad,
                                      style: stlLetrasBlancas),
                                  SizedBox(height: 5,),
                                ],
                              )
                          ),

                          Container(
                            height: alto * 0.3,
                            width: ancho * 0.4,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                              image:
                              fotoFile!=null? DecorationImage(
                                image: FileImage(fotoFile as File),

                                fit: BoxFit.cover,
                              ):
                              DecorationImage(
                                image: AssetImage('assets/images/anonimo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                            TarjetPerfilUsuarioTocado(
                                                usuario: usuarioTocado),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                              opacity: animation, child: child);
                                          // También puedes probar con otras transiciones como SlideTransition, ScaleTransition, etc.
                                        },
                                      ),
                                    );
                                  },
                                  child: Text('Open')
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Quit')
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
      );
    }

    return Scaffold(
        body:
        Stack(
            children: <Widget>[

              OSMFlutter (
                controller:mapControlador,
                onGeoPointClicked: SeleccionarUbicacion,

                initZoom: 12,
                minZoomLevel: 8,
                stepZoom: 1.0,
                userLocationMarker: UserLocationMaker(
                  personMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin,
                      color: Colors.brown,
                      size: 100,
                    ),
                  ),
                  directionArrowMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin,
                      size: 100,
                    ),
                  ),
                ),

                markerOption: MarkerOption(
                    defaultMarker: MarkerIcon(
                      icon: Icon(
                        Icons.person_pin_circle,
                        color: Colors.green,
                        size: 120,
                      ),
                    )
                ),
              ),

              Container(
                  child:
                  BlocBuilder<DataFireBloc, DataFireState>(
                      builder: ( context, state){
                        if(state is UsuariosDescargadosState){
                          listaUsuarios=state.misUsuarios;

                          return    Container(
                            // height: alto*0.5,
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                BotonFlotanteMiUbicacion(mapControlador:mapControlador),
                                SizedBox(height: 5,),
                                BotonFlotanteDesplegable(mapControlador:mapControlador,
                                  listaUsuarios: state.misUsuarios,),
                                SizedBox(height: 5,),
                            //    BotonFlotanteZoomIn(mapControlador:mapControlador,),
                                SizedBox(height: 5,),
                             //   BotonFlotanteZoomOut(mapControlador:mapControlador,),
                                //   SizedBox(height: 30,),
                              //  BotonesMovimiento(mapControlador: mapControlador),



                                SizedBox(height: 10,),
                              ],
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator(),);
                      }
                  )
              ),
            ]
        )
    );
  }
}
