


import '../../../Usuario/Modelo/Usuario.dart';





abstract class DataFireState{

}
class EstadoInicialState extends DataFireState{}

//Estados Subir a la firebase el estado actual
class UsuarioCargaNdoState extends DataFireState{}
class UsuarioCargadoState extends DataFireState{}

//Estados Subir a la firebase el una foto actual
class ImagenCargaNdoState extends DataFireState{}
class ImagenCargadaState extends DataFireState{}

//Estados Subir a la firebase el varrias fotos actual
class ImagenesCargaNdoState extends DataFireState{}
class ImagenesCargadasState extends DataFireState{}

//Estados Descarga el usuario actual
class UsuarioActualDescaraNdo extends DataFireState{}
class UsuarioActualDescargado extends DataFireState{
  final Usuario usuario;
  UsuarioActualDescargado(this.usuario);
}

//Estado Usuario No hay informacion en el snapshot del usuario
class UsuarioActualNoHayUsuario extends DataFireState{

}

//Estados Descarga de los Usuarios de la Firebase
class UsuariosDescargaNdoState extends DataFireState{}
class UsuariosDescargadosState extends DataFireState{
  //usuariosCargados desde la Firebase
  List<Usuario> misUsuarios;
  UsuariosDescargadosState(this.misUsuarios);
}

//Estado Error
class ErrorState extends DataFireState{
  final String error;
  ErrorState(this.error);
}

class InternetActivoState extends DataFireState{}
class InternetPasivoState extends DataFireState{}
