
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapControllerSingleton {
  static final MapControllerSingleton _instance = MapControllerSingleton._internal();
  late MapController _mapController;

  factory MapControllerSingleton() {
    return _instance;
  }

  MapControllerSingleton._internal();

  void setMapController(MapController mapController) {
    _mapController = mapController;
  }

  MapController getMapController() {
    return _mapController;
  }
}
