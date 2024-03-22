

import 'dart:io';
import '../../../Usuario/Modelo/Usuario.dart';




abstract class DataFireEvent{}

class CrearUsuarioEvent extends DataFireEvent{

  final Usuario usuario;
  CrearUsuarioEvent(this.usuario);

}

class SubirUnaImagenEvent extends DataFireEvent{

  final File imagen;
  SubirUnaImagenEvent(this.imagen);
}

class SubirVariasImagenesEvent extends DataFireEvent{

  final List<File> imagenes;
  SubirVariasImagenesEvent(this.imagenes);
}

class DescargarUsuariosEvent extends DataFireEvent{
  final List<Usuario> listaUsuarios;
  DescargarUsuariosEvent(this.listaUsuarios);
}

class DescargarUsuarioActualEvent extends DataFireEvent{
  final Usuario usuario;
  DescargarUsuarioActualEvent(this.usuario);
}

class DescargarUsuarioActual2Event extends DataFireEvent{
  final Usuario usuario;
  DescargarUsuarioActual2Event(this.usuario);
}

class InternetEvent extends DataFireEvent{
}
