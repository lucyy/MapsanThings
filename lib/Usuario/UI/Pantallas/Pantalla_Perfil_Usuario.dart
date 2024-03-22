

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../Usuarios_Perfiles/Repositorio/Usuario_Repositorio.dart';
import '../../Modelo/Lista_Genero.dart';
import '../../Modelo/Lista_Categoria.dart';
import '../../Modelo/Usuario.dart';
import '../Widgets/Perfil_Usuario_Mas_Inicial/Images_Precargadas.dart';
import '../Widgets/Perfil_Usuario_Mas_Inicial/Video_Youtube_Usuario.dart';
import 'Foto_Abierta_Perfil.dart';




class PantallaPerfilUsuario extends StatefulWidget {
  const PantallaPerfilUsuario({Key? key}) : super(key: key);

  @override
  _PantallaPerfilUsuarioState createState() => _PantallaPerfilUsuarioState();
}

class _PantallaPerfilUsuarioState extends State<PantallaPerfilUsuario> {

  UsuarioRepositorio usuarioRepositorio=UsuarioRepositorio();

  late TextEditingController nombreControlador= TextEditingController();
  TextEditingController especialidadControlador = TextEditingController();
  TextEditingController fechaControlador=TextEditingController();
  TextEditingController sloganControlador = TextEditingController();
  TextEditingController descripcionControlador = TextEditingController();
  TextEditingController youtubeControlador = TextEditingController();
  //Redes Sociales
  TextEditingController pagwebControlador = TextEditingController();
  TextEditingController facebookControlador = TextEditingController();
  TextEditingController instagramControlador = TextEditingController();
  TextEditingController tiktokControlador = TextEditingController();
  TextEditingController emailControlador = TextEditingController();
  TextEditingController telefonoControlador = TextEditingController();
  TextEditingController whatsappControlador = TextEditingController();


  final formKeyGeneral = GlobalKey<FormState>();

  YoutubePlayerController controladorVideoYoutube=YoutubePlayerController(initialVideoId: '');
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var usuarioActual;
  bool descargandoDatos=false;
  var  tareaSubirInfo;

  Usuario usuario=Usuario.vacio();
  File? fotoFile;
  final fotoPerfilCacheManager = DefaultCacheManager();
  List<File> imagenesSeleccionadas = [];
  String urlFotoPerfil='urlFotoPerfil';
  final pickerImagenes = ImagePicker();

  int resultadoAno=0;
  int resultadoMes=0;
  int resultadoDia=0;

  bool estaGuardando=false;

  Future<void>ObtenerLocalUsuario()async{
    setState(() {
      descargandoDatos=true;
    });
    usuario= await usuarioRepositorio.ObtenerUsuarioActual() ;
    setState(() {

      urlFotoPerfil=usuario.urlFotoPerfil;

      youtubeControlador.text=usuario.urlVideo;

      controladorVideoYoutube=YoutubePlayerController(initialVideoId: usuario.idVideo);

      nombreControlador.text=usuario.nombre;

      fechaControlador.text=usuario.fechaNacimiento;

      especialidadControlador.text=usuario.especialidad;

     // sloganControlador.text=usuario.slogan;

      descripcionControlador.text=usuario.descripcion;

      pagwebControlador.text=usuario.redSocialPagweb;

      facebookControlador.text=usuario.redSocialFacebook;

      instagramControlador.text=usuario.redSocialInsta;

      tiktokControlador.text=usuario.redSocialTikTok;

      emailControlador.text=usuario.redSocialEMail;

      telefonoControlador.text=usuario.redSocialTelefono;

    //  whatsappControlador.text=usuario.redSocialWhatsapp;

      descargandoDatos=false;
    }
    );

    final filefotoTemp =await fotoPerfilCacheManager.getSingleFile(urlFotoPerfil);
    setState(() {
      fotoFile=filefotoTemp;
    });
  }

  @override
  void initState() {

    actualizarDropdownValorGenero(listaGenero.first);
    actualizarDropdownValorProfesion(listaCategoria.first);
    usuarioActual=auth.currentUser;
    ObtenerLocalUsuario();
    controladorVideoYoutube= YoutubePlayerController(initialVideoId: usuario.idVideo);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }
  void actualizarUrlFotoPerfil(String value) {

    setState(() {
      usuario.urlFotoPerfil = value;
    });
  }
  void actualizarControladorNombre(String value) {

    setState(() {
      usuario.nombre = value;
    });
  }
  void actualizarControladorfechaNacimiento(String value) {

    setState(() {
      usuario.fechaNacimiento = value;
    });
  }
  void actualizarControladorEspecialidad(String value) {
    setState(() {
      usuario.especialidad = value;
    });
  }
  /*
  void actualizarControladorSlogan(String value) {
    setState(() {
      usuario.slogan= value;
    });
  }

   */
  void actualizarControladorDescripcion(String value) {
    setState(() {
      usuario.descripcion = value;
    });
  }

  void actualizarDropdownValorProfesion(String? value) {
    setState(() {
      usuario.profesion = value.toString();
    });
  }
  void actualizarDropdownValorGenero(String? value) {
    setState(() {
      usuario.genero = value.toString();
    });
  }

  void actualizarControladorYoutube(String value) {
    setState(() {
      usuario.urlVideo= value;
    });
  }
  void actualizarIdVideo(String value) {
    setState(() {
      usuario.idVideo= value;
    });
  }
  void actualizarControladorUbicacion(String value) {
    setState(() {
      usuario.ubicacion= value;
    });
  }

  //Redes Sociales

  void actualizarControladorPagWeb(String value) {

    setState(() {
      usuario.redSocialPagweb= value;
    });
  }
  void actualizarControladorFace(String value) {
    setState(() {
      usuario.redSocialFacebook= value;
    });
  }
  void actualizarControladorInsta(String value) {
    setState(() {
      usuario.redSocialInsta= value;
    });
  }
  void actualizarControladorTikTok(String value) {
    setState(() {
      usuario.redSocialTikTok= value;
    });
  }
  void actualizarControladorEmail(String value) {
    setState(() {
      usuario.redSocialEMail= value;
    });
  }
  void actualizarControladorTelefono(String value) {
    setState(() {
      usuario.redSocialTelefono= value;
    });
  }
  /*
  void actualizarControladorWhatsapp(String value) {
    setState(() {
      usuario.redSocialWhatsapp= value;
    });
  }

   */

//Función de foto de perfil, tomar foto
  Future TomarFoto() async {
    final archivoImagenSeleccionada = await pickerImagenes.pickImage(source: ImageSource.camera);

    final archivoCompreso= await FlutterImageCompress.compressAndGetFile(
      archivoImagenSeleccionada!.path,
      archivoImagenSeleccionada!.path + '_fire.jpg',
      quality: 50,

    );
    setState(()  {
      if (archivoCompreso != null)  {
//HACER COMPROBACIÓN QUE LA IMAGEN SEA DE BAJA CALIDAD PARA NO COMPRIMIR TANTO
        usuario.urlFotoPerfil='FotoTomadaNoSubida';
        fotoFile=archivoCompreso as File?;
      } else {
        print('No seleccionada');
      }
    }
    );
  }

  //Función de foto de perfil, seleccionar foto de la galería
  Future<void> GaleriaFotoPerfil() async {
    final picker = ImagePicker();
    final archivoImagenSeleccionada = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (archivoImagenSeleccionada != null) {
        fotoFile = File(archivoImagenSeleccionada.path);
      }
    }
    );
  }

  //Función de las 4 imágenes para seleccionas varias a la vez
  Future<void> GaleriaFotosVarias() async {// limitar a 4 imagenes,
    final List<XFile>? imagenes = await ImagePicker().pickMultiImage();
    if (imagenes != null) {
      setState(() {
        imagenesSeleccionadas.addAll(
            imagenes.map((image) => File(image.path)).toList());
      });
    }
  }

  Future<String>SubirImagen(File imag, String ruta) async {

    final  storageReference =
    FirebaseStorage.instance.ref().child(ruta);
    tareaSubirInfo =  storageReference.putFile(imag);
    final taskSnapshot= await tareaSubirInfo.whenComplete(() => null);
    String urlFotoServicios = await taskSnapshot.ref.getDownloadURL();
    return urlFotoServicios;

  }

  Future<void> GuardarEnFirebase() async {

    setState(() {
      estaGuardando=true;
    });

    if(fotoFile!=null) {
      //subir y almacenar la url de foto de perfil
      String ruta1 = 'usuarios_fotos/${usuarioActual
          ?.uid}/perfil/${DateTime
          .now()
          .millisecondsSinceEpoch}p.jpg';
      String urlTempPerfil = await SubirImagen(
          fotoFile!, ruta1);
      setState(() {
        urlFotoPerfil = urlTempPerfil;
        actualizarUrlFotoPerfil(urlFotoPerfil);
      });

    }

    //Mapa con el perfil de usuario para que va a ser subido a firebase
    Map<String, String> userData = {

      'nombre': usuario.nombre,
      'fechaNacimiento': usuario.fechaNacimiento,
      'genero': usuario.genero,
      'profesion': usuario.profesion,
      'especialidad':usuario.especialidad,
     // 'slogan':usuario.slogan,
      'descripcion':usuario.descripcion,
      'ubicacion':usuario.ubicacion,
      'pagweb':usuario.redSocialPagweb,
      'facebook':usuario.redSocialFacebook,
      'instagram':usuario.redSocialInsta,
      'tiktok':usuario.redSocialTikTok,
      'email':usuario.redSocialEMail,
      'telefono':usuario.redSocialTelefono,
     // 'whatsapp':usuario.redSocialWhatsapp,
      'urlFotoPerfil': usuario.urlFotoPerfil,
      'idVideo':usuario.idVideo,
      'urlVideo':usuario.urlVideo,
    };


    await firestore.collection('usuarios').doc(usuarioActual?.uid).update(userData).
    then((value) => print('usuario actualizado'))
        .catchError((error) => print('Failed to add user: $error'));

    setState(() {
      estaGuardando=false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
          'Información actualizada con éxito'),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.black,
      ),
    );
  }

  void ComprobacionFechaNacimiento(String fechaFormateada){
    if(fechaFormateada != null ){


      String anoS=fechaFormateada.substring(0,4);
      String mesS=fechaFormateada.substring(5,7);
      String diaS=fechaFormateada.substring(8,10);
      int anoI= int.parse(anoS);
      int mesI= int.parse(mesS);
      int diaI= int.parse(diaS);
      int anoActual = DateTime.now().year;
      int mesActual = DateTime.now().month;
      int diaActual = DateTime.now().day;

      setState(() {
        resultadoAno=anoActual-anoI;
        resultadoMes= mesActual-mesI;
        resultadoDia=diaActual-diaI;
        print('value de fecha nac: '+anoI.toString());

      });


    }else{
      print("fecha no seleccionada");
    }
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto=MediaQuery.of(context).size.height;

    return IgnorePointer(
        ignoring: estaGuardando,
        child:
        Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.green,
              title: Text('My profile'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/negro.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            body:  descargandoDatos? Center(child: CircularProgressIndicator()):Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    child: SingleChildScrollView(
                        child: Form(
                            key: formKeyGeneral,
                            child: Column(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      ////////////////////////////////////////////////////////////////////////////////////////Foto de perfil
                                      margin: EdgeInsets.all(10),
                                      height: alto*0.15,
                                      width: ancho*0.30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black12,
                                        image: fotoFile!=null? DecorationImage(
                                          image: FileImage(fotoFile as File),
                                          fit: BoxFit.cover,
                                        ):
                                        DecorationImage(
                                          image: AssetImage('assets/images/anonimo.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap:(){

                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context)=>FotoAbiertaPerfil(
                                                urlFoto:urlFotoPerfil,
                                                backgroundDecoracion: const BoxDecoration(
                                                    color: Colors.black
                                                ),
                                                minEscala: 300,
                                              )
                                          )
                                      );
                                    },
                                  ),

                                  //////////////////////////////////////////////////////////////////////////////////////Botones Foto Perfil
                                  Container( //color: Colors.black,
                                    height: alto * 0.06,
                                    width: ancho * 0.7,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        FloatingActionButton(
                                          onPressed: () {
                                            TomarFoto();
                                            setState(() {});
                                          }, //getImage,
                                         // tooltip: 'tomar imagen',
                                          child: Icon(
                                            Icons.add_a_photo, color: Colors.white,),
                                          backgroundColor: Colors.green,
                                        ),

                                        FloatingActionButton(
                                          onPressed: () {
                                            GaleriaFotoPerfil();
                                          },
                                        //  tooltip: 'eliminar foto',
                                          child: Icon(Icons.photo, color: Colors.white,),
                                          backgroundColor: Colors.green,
                                        ),
                                        FloatingActionButton(
                                          onPressed: () {
                                            setState(() {
                                              fotoFile = null;
                                            }
                                            );
                                          }, // getfotoUrl,
                                        //  tooltip: 'borrar imagen',
                                          child: Icon(
                                            Icons.phonelink_erase, color: Colors.white,),
                                          backgroundColor: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  /////////////////////////////////////////////////////////////////////////////////////////////Nombre del usuario
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      labelStyle: EstiloTexto(alto),
                                    ),

                                    controller: nombreControlador,
                                    onSaved: (value) {
                                      actualizarControladorNombre(nombreControlador.text);
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your name';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20,),

                                  ///////////////////////////////////////////////////////////////////////////////////////Fecha de Nacimiento
                                  TextFormField(
                                      controller: fechaControlador,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        labelText: "Birthdate",

                                      ),
                                      onSaved:(value){

                                        actualizarControladorfechaNacimiento(fechaControlador.text);
                                      },
                                      validator: (value) {
                                        ComprobacionFechaNacimiento(fechaControlador.text);
                                        if (value == null || value.isEmpty)
                                        {
                                          return 'Enter your date of birth';
                                        }
                                        else if(resultadoAno<18)
                                        {
                                          print('resultado año: '+resultadoAno.toString());
                                          return 'You are a minor';
                                        }
                                        else if(resultadoAno==18 && resultadoMes<0)
                                        {
                                          return 'You are still a minor';
                                        }
                                        else if(resultadoAno==18 && resultadoMes==0 && resultadoDia<0)
                                        {
                                          return 'You are still a few days minor';
                                        }
                                        return null;
                                      },
                                      readOnly: true,

                                      onTap: () async {
                                        DateTime? fechaEscogida =  await showDatePicker(context: context,
                                            initialDate: DateTime.now(), firstDate: DateTime(1920), lastDate: DateTime.now());

                                        String fechaFormateada =  DateFormat('yyyy-MM-dd').format(fechaEscogida!);
                                        ComprobacionFechaNacimiento(fechaFormateada);
                                      }
                                  ),

                                  SizedBox(height: 20,),

                                  ////////////////////////////////////////////////////////////////////////////////////////////////Genero
                                  Container(
                                    width: ancho,
                                    // height: alto*0.2,
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width:ancho*0.5,
                                            child: Text('Gender', style: TextStyle(fontSize: 15, color: Colors.grey)
                                            )
                                        ),
                                        //dropdown elegir profesión
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            value: usuario.genero,
                                            items: listaGenero.map((option) {
                                              return DropdownMenuItem<String>(
                                                value: option,
                                                child: Text(option),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == 'Nothing') {
                                                return 'Select a gender';
                                              }
                                              return null;
                                            },
                                            onChanged: actualizarDropdownValorGenero,),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /////////////////////////////////////////////////////////////////////////////////////////Profesion
                                  Container(
                                    width: ancho,
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width:ancho*0.5,
                                          child:  Text('Research', style:  TextStyle(fontSize: 15, color: Colors.grey)),
                                        ),

                                        //////////////////////////////////////////////////////////////////////// //dropdown elegir profesión
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            menuMaxHeight: alto*0.5,
                                            value: usuario.profesion ,
                                            items: listaCategoria.map((option) {
                                              return DropdownMenuItem<String>(
                                                value: option,
                                                child: Text(option),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == 'Nothing') {
                                                return 'Select a category';
                                              }
                                              return null;
                                            },
                                            onChanged: actualizarDropdownValorProfesion,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  ////////////////////////////////////////////////////////////////////////////Especialidad del usuario
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: especialidadControlador,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Specific field of study',
                                      labelStyle: EstiloTexto(alto),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter your specific field of study';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      actualizarControladorEspecialidad(especialidadControlador.text);
                                    },
                                  ),

                                  SizedBox(height: 30,),

                                  ////////////////////////////////////////////////////////////////////////////////////////////// //Descripcion
                                  TextFormField(
                                    maxLength: 400,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Research description',
                                      labelStyle: EstiloTexto(alto),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: descripcionControlador,
                                    onSaved: (value) {
                                      actualizarControladorDescripcion(descripcionControlador.text);
                                    },
                                  ),

                                  SizedBox(height: 30,),

                                  Text('6 photographs maximum',
                                    style: EstiloInstrucciones(alto),),

                                  /////////////////////////////////////////////////////////////////////////////////////////////////////4 Fotografías
                                  Column(
                                    children: [
                                      Container(
                                        height: alto*0.35,
                                        child:
                                        ImagesPrecargadas(),
                                      ),

                                      SizedBox(height: 30,),

                                      Text('Video', style: EstiloInstrucciones(alto),),
                                      /////////////////////////////////////////////////////////////////////////////////////////////////////1 video textfield

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child:

                                            TextFormField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Enter your YouTube URL',
                                                  fillColor: Colors.green.withAlpha(20),
                                                  filled: true,
                                                  hintStyle: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.green,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    icon: const Icon(Icons.clear, color: Colors.green,),
                                                    onPressed: () => youtubeControlador.clear(),
                                                  ),
                                                ),

                                                textAlign: TextAlign.center,
                                                controller: youtubeControlador,

                                                onChanged: (value) {
                                                  actualizarControladorYoutube(youtubeControlador.text);
                                                  if (youtubeControlador.text.isNotEmpty) {
                                                    String? id = YoutubePlayer.convertUrlToId(youtubeControlador.text);
                                                    actualizarIdVideo(id.toString());
                                                  }
                                                },
                                                onSaved: (value) {
                                                  actualizarControladorYoutube(
                                                      youtubeControlador.text);
                                                  if (youtubeControlador.text
                                                      .isNotEmpty) {
                                                    String? id = YoutubePlayer
                                                        .convertUrlToId(
                                                        youtubeControlador.text);
                                                    actualizarIdVideo(id.toString());
                                                  }
                                                }
                                            ),
                                          ),

                                          SizedBox(width: 5,),
                                        ],
                                      ),

                                      SizedBox(height: 10,),
                                      ///////////////////////////////////////////////////////////////////////////////////////////////Video Youtube

                                      VideoYoutubeUsuario( controladorYoutube: controladorVideoYoutube ,urlYoutube: youtubeControlador.text,),

                                      SizedBox(height: 40,),

                                      Text('Social networks',
                                        style: TextStyle(color: Colors.grey),),

                                      SizedBox(height: 30,),

                                      //Página Web
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: pagwebControlador,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Web page',
                                          labelStyle: EstiloTexto(alto),
                                        ),
                                        onSaved: (value) {
                                          actualizarControladorPagWeb(pagwebControlador.text);
                                        },
                                      ),

                                      SizedBox(height: 30,),

                                      //Facebook
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: facebookControlador,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Facebook URL',
                                          labelStyle: EstiloTexto(alto),
                                        ),
                                        onSaved: (value) {
                                          actualizarControladorFace(facebookControlador.text);
                                        },
                                      ),

                                      SizedBox(height: 30,),

                                      //Instagram
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: instagramControlador,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Instagram URL',
                                          labelStyle: EstiloTexto(alto),
                                        ),

                                        onSaved: (value) {
                                          actualizarControladorInsta(instagramControlador.text);
                                        },
                                      ),

                                      SizedBox(height: 30,),

                                      //Tik Tok
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: tiktokControlador,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Tik Tok URL',
                                          labelStyle: EstiloTexto(alto),
                                        ),

                                        onSaved: (value) {
                                          actualizarControladorTikTok(tiktokControlador.text);
                                        },
                                      ),

                                      SizedBox(height: 30,),

                                      //E- mail
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: emailControlador,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'e-mail',
                                          labelStyle: EstiloTexto(alto),
                                        ),

                                        onSaved: (value) {
                                          actualizarControladorEmail(emailControlador.text);
                                        },
                                      ),

                                      SizedBox(height: 30,),

                                      //Teléfono
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: telefonoControlador,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Cellphone number',
                                          labelStyle: EstiloTexto(alto),
                                        ),
                                        onChanged: (value) => {actualizarControladorTelefono},

                                        onSaved: (value) {
                                          actualizarControladorTelefono(telefonoControlador.text);
                                        },
                                      ),


                                      SizedBox(height: 30,),

                                      //Botón para guardar el mapa con los datos del usuario en firebase
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(ancho * 0.4, alto * 0.07)),
                                          onPressed: () async
                                          {
                                            if (formKeyGeneral.currentState!.validate())
                                            {
                                              formKeyGeneral.currentState!.save();
                                              GuardarEnFirebase();
                                            }

                                            else {

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(
                                                    'Complete the required fields'),
                                                  duration: Duration(seconds: 5),
                                                  backgroundColor: Colors.black,
                                                ),
                                              );
                                            }
                                          },

                                          child: estaGuardando? Center(child: CircularProgressIndicator(color: Colors.white,),):
                                          Text('Save', style: TextStyle(fontSize: alto*0.028),)
                                      ),
                                      SizedBox(height: 30,),
                                    ],
                                  )
                                ]
                            )
                        )
                    )
                )
            )
        )
    );
  }
}
EstiloTexto(double alto) {
  return TextStyle(
      fontSize:  alto*0.022,
      color: Colors.grey
  );
}
EstiloInstrucciones(double alto) {
  return TextStyle(
      fontSize:  alto*0.017,
      color: Colors.grey
  );
}
