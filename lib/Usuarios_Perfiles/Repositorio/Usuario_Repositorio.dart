



//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../../Usuario/Modelo/Usuario.dart';






class UsuarioRepositorio{

  final FirebaseAuth auth = FirebaseAuth.instance;
  var usuarioActual;
  var  tareaSubirData;
  final fireInstancia = FirebaseFirestore.instance
      .collection('usuarios');

  ////////////CREAR UN USUARIO
  Future<void> crearOActualizarUsuario({required Usuario usuarioNuevo}) async{
    usuarioActual=auth.currentUser;

    try{
      //Guardar los datos del usuario en firebase
      await fireInstancia.doc(usuarioActual?.uid)
          .set(usuarioNuevo.toJson())
          .then((value) => print('usuario escrito'))
          .catchError((error) => print('Failed to add user: $error'));
    } on FirebaseException catch (e){
      if(kDebugMode){
        print("Error en la creación del usuario '${e.code}': ${e.message} ");
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  ////////////////OBTENER USUARIOS
  Stream<List<Usuario>> obtenerUsuarios() async*{
    var respuesta = await fireInstancia
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());

    yield* respuesta;
  }

  ///////////SUBIR UNA FOTO
  Future<String>SubirUnaImagen({required File imagen}) async {

    String ruta1 = 'usuarios_fotos/${usuarioActual
        ?.uid}/perfil/${DateTime
        .now()
        .millisecondsSinceEpoch}p.jpg';
    final  storageReference = FirebaseStorage.instance.ref().child(ruta1);

    tareaSubirData =  storageReference.putFile(imagen);

    final taskSnapshot= await tareaSubirData.whenComplete(() => null);

    String url = await taskSnapshot.ref.getDownloadURL();
    return url;

  }

  ///////////SUBIR VARIAS FOTOS
  Future<void>SubirVariasImagenes({required List<File> imagenes}) async {
    List<String> urlFotosServicios=[];

    for (int i = 0; i < imagenes.length; i++) {
      String ruta='usuarios_fotos/${usuarioActual?.uid}/servicio/${DateTime.now().millisecondsSinceEpoch}$i.jpg';
      final  storageReference = FirebaseStorage.instance.ref().child(ruta);
      tareaSubirData =  storageReference.putFile(imagenes[i]);
      final taskSnapshot= await tareaSubirData.whenComplete(() => null);

      String urlTempServicios = await taskSnapshot.ref.getDownloadURL();
      urlFotosServicios.add( urlTempServicios);
      print('la url que esta stemporal'+urlTempServicios);
    }
  }

  Future<bool> ExisteUsuarioActual() async{

    usuarioActual=auth.currentUser;
    final  documentoUsuario = await fireInstancia. doc(usuarioActual?.uid).get();
    return documentoUsuario.exists;
  }

  Future<Usuario> ObtenerUsuarioActual() async{

    usuarioActual=auth.currentUser;
    final  documentoUsuario = await fireInstancia. doc(usuarioActual?.uid).get();
    Usuario temp;
    if(documentoUsuario.exists) {
      temp = await Usuario.fromJson2(documentoUsuario.data());
      return temp;
    }
    else
      temp=Usuario.vacio();
    return temp;
  }

  Future<String> ObtenerUidActual() async{
    usuarioActual=auth.currentUser;
    String uid= await fireInstancia.doc(usuarioActual?.uid).id;
    return uid;
  }
}
