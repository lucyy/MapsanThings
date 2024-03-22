import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';



class BotonFlotanteZoomOut extends StatefulWidget {

  final MapController mapControlador;
  const BotonFlotanteZoomOut({Key? key,
    required this.mapControlador
  }) : super(key: key);

  @override
  _BotonFlotanteZoomOutState createState() => _BotonFlotanteZoomOutState();
}

class _BotonFlotanteZoomOutState extends State<BotonFlotanteZoomOut>  {


  @override
  Widget build(BuildContext context) {
    return   Align(
      alignment: Alignment.bottomLeft,
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async{
          await widget.mapControlador.zoomOut();
        },
        child: Icon(Icons.zoom_out),
      ),
    );
  }
}
