import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';



class BotonFlotanteZoomIn extends StatefulWidget {

  final MapController mapControlador;

  const BotonFlotanteZoomIn({Key? key,
    required this.mapControlador
  }) : super(key: key);

  @override
  _BotonFlotanteZoomInState createState() => _BotonFlotanteZoomInState();
}

class _BotonFlotanteZoomInState extends State<BotonFlotanteZoomIn>  {

  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: Alignment.bottomLeft,
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async{
          await widget.mapControlador.zoomIn();
        },
        child: Icon(Icons.zoom_in),
      ),
    );
  }

}
