import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';



class BotonFlotanteMiUbicacion extends StatefulWidget {

  final MapController mapControlador;
  const BotonFlotanteMiUbicacion({Key? key,
    required this.mapControlador
  }) : super(key: key);

  @override
  _BotonFlotanteMiUbicacionState createState() => _BotonFlotanteMiUbicacionState();
}

class _BotonFlotanteMiUbicacionState extends State<BotonFlotanteMiUbicacion>  {

  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: Alignment.bottomLeft,
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async{
          Espera();
          await widget.mapControlador.currentLocation();
        },
        child: Icon(Icons.person_pin_circle),
      ),
    );
  }

  void Espera() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor : AlwaysStoppedAnimation(Colors.green),
                ),
              ),
            ),
          ],
        );
      },
    );
    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
    }
    );
  }
}