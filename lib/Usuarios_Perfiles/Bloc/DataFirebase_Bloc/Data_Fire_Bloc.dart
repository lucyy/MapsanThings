

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Usuario/Modelo/Usuario.dart';
import '../../Repositorio/Usuario_Repositorio.dart';
import 'Data_Fire_Event.dart';
import 'Data_Fire_State.dart';




class DataFireBloc extends Bloc<DataFireEvent, DataFireState>{

  final fireInstancia = FirebaseFirestore.instance
      .collection('usuarios');
  DataFireBloc(
      ) : super(EstadoInicialState()) {

    UsuarioRepositorio usuarioRepositorio=UsuarioRepositorio();
    on<CrearUsuarioEvent>((event, emit) async{
      emit(UsuarioCargaNdoState());
      await Future.delayed(const Duration(seconds: 1));
      try{
        await usuarioRepositorio.crearOActualizarUsuario(
            usuarioNuevo: event.usuario);
        emit(UsuarioCargadoState()
        );
      }catch (e){
        emit(ErrorState(e.toString())
        );
      }
    }
    );

    on<SubirUnaImagenEvent>((event, emit) async{

      emit(ImagenCargaNdoState());
      await Future.delayed(const Duration(seconds: 1));
      try{
        await usuarioRepositorio.SubirUnaImagen(
            imagen: event.imagen);
        emit(ImagenCargadaState()
        );
      }catch (e){
        emit(ErrorState(e.toString())
        );
      }
    }
    );

    on<SubirVariasImagenesEvent>((event, emit) async{

      emit(ImagenesCargaNdoState());
      await Future.delayed(const Duration(seconds: 3));
      try{
        await usuarioRepositorio.SubirVariasImagenes(
            imagenes: event.imagenes);
        emit(ImagenesCargadasState());
      }catch (e){
        emit(ErrorState(e.toString()));
      }
    }
    );

    on<DescargarUsuariosEvent>((event, emit) async{

      try{
        emit (UsuariosDescargadosState(event.listaUsuarios));
      }catch(e){
        emit (ErrorState(e.toString()));
      }
    }
    );

    on<DescargarUsuarioActual2Event>((event, emit) async{

      try{
        if(event.usuario==Usuario.vacio()) {
          emit(UsuarioActualNoHayUsuario());
        }
        else
          emit(UsuarioActualDescargado(event.usuario));
      }
      catch(e){
        emit (ErrorState(e.toString()));
      }
    }
    );


  }
}

