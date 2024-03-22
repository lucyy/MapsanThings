import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotoPerfilAbierta extends StatefulWidget {

  const FotoPerfilAbierta({
    Key? key,
  }) : super(key: key);

  @override
  State<FotoPerfilAbierta> createState() => _FotoPerfilAbiertaState();
}

class _FotoPerfilAbiertaState extends State<FotoPerfilAbierta> {

  File? _imageFile;
  final _firestore = FirebaseFirestore.instance;

  Future<void> GaleriaFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // File? _image;

  final picker = ImagePicker();

  Future TomarFoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /*
    Future GaleriaFoto() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
*/

  ///////////////actualizar informacion de un campo
/*
  void updateUserData(String campo, dynamic valor) async {
    try {
      await db.collection('usuarios').doc(user.uid).update({
        'datos.$campo': valor,
      });
      print('Campo $campo actualizado exitosamente.');
    } catch (error) {
      print('Error al actualizar el campo $campo: $error');
    }
  }
  */
  Future SubirYGuardarUrlImagenPerfil() async {
    final currentUser = _auth.currentUser;
    final storageRef =
    FirebaseStorage.instance.ref().child('usuarios_fotos/${currentUser?.uid}/perfil/${DateTime.now().millisecondsSinceEpoch}.jpg');
    final UploadTask uploadTask = storageRef.putFile(_imageFile!);
    final TaskSnapshot downloadUrl = (await uploadTask);
    // Guarda la URL de la imagen en la base de datos de Firebase para que pueda ser recuperada posteriormente
    final String urlGuardada = (await downloadUrl.ref.getDownloadURL());
    print("URL de la imagen: $urlGuardada");

    //actualizar el campo 'fotoperfil' en el mapa de la info del usuario
    try {
      await _firestore.collection('usuarios').doc(currentUser?.uid).update({
        'fotoperfil': urlGuardada,

      });
      print('Campo $urlGuardada actualizado exitosamente.');
    } catch (error) {
      //  print('Error al actualizar el campo $campo: $error');
    }

    if(urlGuardada.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor suba una imagen'))
      );
      return;
    }
  }

/*
//////////////////////////////////////////////////////////////////////
    Future<void> ObtenerFoto() async {
      try {
        final currentUser = _auth.currentUser;
        String? urlFoto;

        final ref = _firestore.collection("usuarios")
            .doc(currentUser?.uid)
            .withConverter(
          fromFirestore: Usuario.fromFirestore,
          toFirestore: (Usuario usuario, options) => usuario.toFirestore(),
        );
        final docSnap = await ref.get();
        final usuario = docSnap.data(); // Convert to Usuario object
        if (usuario != null) {
          urlFoto = usuario.urlFotoPerfil;
          print(usuario);
        } else {
          print("No such document.");
        }


        setState(() {
          fotoUrl = urlFoto.toString();
        });

        //var userbase=await;
        // final storageRef = FirebaseStorage.instance.ref().child('usuarios_fotos/${currentUser?.uid}/perfil');
        // final ref = FirebaseDatabase.instance.ref();
        // final snapshot = await ref.child('users/$userId').get();
        //  if (snapshot.exists) {
        //    print(snapshot.value);
        // } else {
        //   print('No data available.');
        // }

        //  final ListResult result = await storageRef.listAll();
        //  final List<Reference> allFiles = result.items;
        //  final List<String> photoUrls = [];

        //  for (final ref in allFiles) {
        //  final String urlRecuperada=
        //    final String url = await ref.getDownloadURL();
        //    photoUrls.add(url);
        //  }
        // final String url = await storageRef.getDownloadURL();
        // setState(() {
        // fotoUrl = photoUrls[0];
        //  });
      }
      catch(error)
      {
        print('el error '+error.toString());
      }
    }
*/


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto=MediaQuery.of(context).size.height;


    return  Scaffold(
      appBar: AppBar(title:Text( 'Foto de Perfil'),),
      body: Center(
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: alto,
                width: ancho,
                decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(100),
                  // color: Colors.grey,
                  image: _imageFile != null
                      ? DecorationImage(
                    image: FileImage(_imageFile!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _imageFile == null
                    ?  Image(image: AssetImage('assets/images/anonimo.png'))
                    : null,
              ),

              Container(
                margin: EdgeInsets.only(bottom: alto*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed:(){
                        TomarFoto();
                      }, //getImage,
                      tooltip: 'tomar imagen',
                      child: Icon(Icons.add_a_photo,color: Colors.white,),
                      backgroundColor:  Colors.orange,
                    ),

                    FloatingActionButton(
                      onPressed:() {
                        GaleriaFoto();
                      },// getfotoUrl,
                      tooltip: 'eliminar foto',
                      child: Icon(Icons.photo_library_outlined,color: Colors.white, ),
                      backgroundColor:  Colors.orange,
                    ),
                    FloatingActionButton(
                      onPressed:() {
                      },// getfotoUrl,
                      tooltip: 'seleccioar imagen',
                      child: Icon(Icons.phonelink_erase,color: Colors.white, ),
                      backgroundColor:  Colors.orange,
                    ),
                    //SizedBox(height: 100),
                    FloatingActionButton(
                      onPressed:() {
                        SubirYGuardarUrlImagenPerfil();
                      },// uploadImage,
                      tooltip: 'Subir imagen',
                      child: Icon(Icons.save,color: Colors.white, ),
                      backgroundColor:  Colors.orange,
                    ),

                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}
