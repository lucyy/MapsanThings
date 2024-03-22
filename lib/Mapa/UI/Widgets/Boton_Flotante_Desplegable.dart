import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:search_choices/search_choices.dart';
import 'package:mapsandthings/Usuario/Modelo/Lista_Categoria.dart';


import '../../../Usuario/Modelo/Usuario.dart';



class BotonFlotanteDesplegable extends StatefulWidget {
  final MapController mapControlador;
  final List<Usuario> listaUsuarios;

  const BotonFlotanteDesplegable({Key? key,
    required this.mapControlador,
    required this.listaUsuarios
  }) : super(key: key);

  @override
  _BotonFlotanteDesplegableState createState() => _BotonFlotanteDesplegableState();
}

class _BotonFlotanteDesplegableState extends State<BotonFlotanteDesplegable> {

  List<String> listaAlfabetica=[];
  String valorSeleccionado='';
  List<Usuario> usuariosFiltrados=[];
  List<GeoPoint>ubicacionesTemp=[];

  @override
  void initState() {
    listaAlfabetica=listaCategoria.sublist(1, listaCategoria.length-1);
    listaAlfabetica.sort(
            (a, b) =>
            a.toString().compareTo(b.toString()
            )
    );
    super.initState();
  }


  Future<List<Usuario>> ProfesionBuscada(String profesion) async{

    List<Usuario> usuariosFiltrados =await widget.listaUsuarios.where((user) => user.profesion == profesion).toList();
    return usuariosFiltrados;
  }

  Future <void> AgregarMargadoresGeograficos(List<Usuario> listaProfesionesFiltro)async {

    List<Usuario>usuariosFiltradosConUbicacion=await listaProfesionesFiltro.where((user) => user.ubicacion!='').toList();

    if(ubicacionesTemp.isNotEmpty) {

      for (int i = 0; i < ubicacionesTemp.length; i++) {
        await widget.mapControlador.removeMarker(
            ubicacionesTemp[i]
        );
      }
    }

    for (int i = 0; i < usuariosFiltradosConUbicacion.length; i++)
    {
      String? ubicacion=  usuariosFiltradosConUbicacion[i].ubicacion;
      List<String> listalatlon=ubicacion.split('+');
      double lat=double.parse(listalatlon[0]);
      double long=double.parse(listalatlon[1]);
      GeoPoint punto=GeoPoint(latitude: lat, longitude: long);
      ubicacionesTemp.add(punto);

      await widget.mapControlador.addMarker(

          punto,
          markerIcon:
          MarkerIcon(
            icon: Icon(Icons.location_history, color: Colors.lightBlue,size: 100,),
          ),
          angle: 0
      );
      await widget.mapControlador.addMarker(

          punto,
          markerIcon:
          MarkerIcon(
            icon:  Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),

                /*
            Container(
              color: Colors.black45,
              child: Text(
                usuariosFiltradosConUbicacion[i].nombre.toString(),
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),

                 */




          ),
          angle: 0
      );
    }
  }

  void apareceBarraBuscar(double altoPantalla) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double ancho=MediaQuery.of(context).size.width;
        double alto=MediaQuery.of(context).size.height;

        return AlertDialog(

          content: Container(
            //  height: alto*0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // height: alto*0.4,
                  child: SearchChoices.single(
                    icon: Icon(Icons.search),
                    closeButton: 'Cerrar',
                    items: listaAlfabetica.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    value: valorSeleccionado,
                    hint: "select",
                    searchHint: "select",
                    onChanged: (value) {
                      setState(() {
                        valorSeleccionado = value;
                      }
                      );
                    },
                    // isExpanded: true,
                  ),
                ),

                //   SizedBox(height: 10,),

                Container(
                  //  height: alto*0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            fixedSize: Size(ancho*0.2, alto*0.05),
                          ),
                          onPressed:()async{
                            usuariosFiltrados=await ProfesionBuscada(valorSeleccionado);
                            if(usuariosFiltrados.isNotEmpty && valorSeleccionado!='')
                            {
                              AgregarMargadoresGeograficos(usuariosFiltrados);
                              Navigator.of(context).pop();
                            }
                            else if(valorSeleccionado=='' && usuariosFiltrados.isEmpty)
                            {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    double ancho=MediaQuery.of(context).size.width;
                                    double alto=MediaQuery.of(context).size.height;

                                    return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('No search was performed'),
                                            SizedBox(height: 20,),
                                            ElevatedButton(
                                                style:  ElevatedButton.styleFrom(
                                                  fixedSize: Size(ancho*0.2, alto*0.05),
                                                ),
                                                onPressed:(){
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Quit')
                                            ),
                                          ],
                                        )
                                    );
                                  }
                              );
                            }

                            else{
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    double ancho=MediaQuery.of(context).size.width;
                                    double alto=MediaQuery.of(context).size.height;

                                    return AlertDialog(

                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('There are no registered users with this field.'),
                                            SizedBox(height: 20,),
                                            ElevatedButton(
                                                style:  ElevatedButton.styleFrom(
                                                  fixedSize: Size(ancho*0.2, alto*0.05),
                                                ),
                                                onPressed:(){
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Quit')
                                            ),
                                          ],
                                        )
                                    );
                                  }
                              );
                            }
                          },
                          child: Text('Search')
                      ),
                      ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            fixedSize: Size(ancho*0.2, alto*0.05),
                          ),
                          onPressed:(){
                            Navigator.pop(context);
                          },
                          child: Text('Quit')
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double ancho=MediaQuery.of(context).size.width;
    double alto=MediaQuery.of(context).size.height;
    return   Align(
      alignment: Alignment.bottomLeft,
      child:

      FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          apareceBarraBuscar(alto);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}