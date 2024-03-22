import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../Menu/Pantallas/TabManu.dart';
import '../../../Usuarios_Perfiles/Bloc/DataFirebase_Bloc/Data_Fire_Bloc.dart';
import '../../../Usuarios_Perfiles/Bloc/DataFirebase_Bloc/Data_Fire_Event.dart';
import '../../../Usuarios_Perfiles/Bloc/DataFirebase_Bloc/Data_Fire_State.dart';
import '../../../Usuarios_Perfiles/Repositorio/Usuario_Repositorio.dart';
import '../../Bloc/Foto_Bloc.dart';
import '../../Bloc/Foto_Event.dart';
import '../../Bloc/Foto_State.dart';
import '../../Modelo/Lista_Genero.dart';
import '../../Modelo/Lista_Categoria.dart';
import '../../Modelo/Usuario.dart';
import '../Widgets/Perfil_Usuario_Mas_Inicial/Video_Youtube_Usuario.dart';


class PantallaPerfilUsuarioInicial extends StatefulWidget {
  const PantallaPerfilUsuarioInicial({Key? key}) : super(key: key);

  @override
  _PantallaPerfilUsuarioInicialState createState() => _PantallaPerfilUsuarioInicialState();
}

class _PantallaPerfilUsuarioInicialState extends State<PantallaPerfilUsuarioInicial> {

  UsuarioRepositorio usuarioRepositorio=UsuarioRepositorio();

  TextEditingController nombreControlador = TextEditingController();
  TextEditingController especialidadControlador = TextEditingController();
  TextEditingController fechaControlador=TextEditingController();
  TextEditingController SloganControlador = TextEditingController();
  TextEditingController DescripcionControlador = TextEditingController();
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

  Usuario usuario= Usuario(
      nombre:'',
      emailsesion: '',
      idUsuario:'',
      idVideo:'',
      fechaNacimiento:'',
      profesion:listaCategoria.first,
      genero:listaGenero.first,
      especialidad:'',
      //slogan:'',
      descripcion:'',
      redSocialPagweb:'',
      redSocialFacebook:'',
      redSocialInsta:'',
      redSocialTikTok:'',
      redSocialEMail:'',
      redSocialTelefono:'',
    //  redSocialWhatsapp:'',
      ubicacion:'',
      urlFotoPerfil:'',
      urlVideo:'');

  UsuarioRepositorio urRepo=UsuarioRepositorio();

  File? fotoFile;
 // List<File> imagenesElegidas = [];
  int actual=0;

  YoutubePlayerController controladorVideoYoutube=YoutubePlayerController(initialVideoId: '');

  String urlFotoPerfil='urlFotoPerfil';

  final pickerImagenes = ImagePicker();

  bool estaCheck=false;
  bool estaGuardando=false;
  bool hayFotos=true;
  bool ubicando=false;
  String miUbicacionCadena='';

  int resultadoAno=0;
  int resultadoMes=0;
  int resultadoDia=0;

  @override
  void initState() {
    super.initState();
    obtenerMiUbicacion();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void actualizarFotoPerfil(String value) {

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

        fotoFile=File(archivoCompreso.path);

      } else {
        print('No seleccionado');
      }


    });
  }


  List<File> imagenesElegidas = [];
  Future<void> ElegirImagenesServicios() async {//arreglar, limitar a 4 imagenes, arreglar el if
  final List<XFile>? images = await ImagePicker().pickMultiImage();
    if(imagenesElegidas.length == 0) {

      if (images != null ) {

        if(images.length>6) {
          setState(() {
            for (int i = 0; i < 6; i++) {
              imagenesElegidas.add(File(images[i].path));
            }

          });

     }
        else if (images.length<=6)
        {
          setState(() {
            imagenesElegidas.addAll(
                images.map((image) => File(image.path)).toList());
          });
        }
      }
    }
    else {
      if (images != null ) {
        if (images.length > 5 || imagenesElegidas.length+ images.length>6) {

          setState(() {
            int j=0;
            for (int i = imagenesElegidas.length; i < 6; i++) {
              imagenesElegidas.add(File(images[j].path));
              j++;
            }
          });
        }
        else {
     setState(() {

            imagenesElegidas.addAll(
                images.map((image) => File(image.path)).toList());
          }
          );
        }
      }
    }
  }


  //Función de foto de perfil, seleccionar foto de la galería
  Future<void> GaleriaFotoPicker() async {
    final picker = ImagePicker();
    final archivoImagenSeleccionada = await picker.pickImage(source: ImageSource.gallery);
    final archivoCompreso= await FlutterImageCompress.compressAndGetFile(
      archivoImagenSeleccionada!.path,
      archivoImagenSeleccionada!.path + '_fire.jpg',
      quality: 50,
    );
    setState(() {
      if (archivoCompreso != null) {
        fotoFile = File(archivoImagenSeleccionada.path);
      }
    });
  }


  Future<void> obtenerMiUbicacion() async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

// Imprimir la ubicación actual en la consola
    print('Latitud: ${position.latitude}, Longitud: ${position.longitude}');

    String miLatitud= position.latitude.toString();
    String miLongitud=position.longitude.toString();

    //Importante, se le retiró el cero al final para que no exista conflicto con el tratamiento de la ubicación, ya que se le guarda como cadena de caracteres
    String miLatitudSinCero = miLatitud.replaceAll(RegExp(r'0*$'), '');
    String miLongitudSinCero = miLongitud.replaceAll(RegExp(r'0*$'), '');

    miUbicacionCadena=miLatitudSinCero+'+'+miLongitudSinCero;
    print('la ubicacion es: '+miUbicacionCadena);
  }

  @override
  Widget build(BuildContext context) {
    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto = MediaQuery
        .of(context)
        .size
        .height;
    return IgnorePointer(
        ignoring: estaGuardando,
        child:
        Scaffold(
            appBar: AppBar(title: Text('Enter the information'),
              automaticallyImplyLeading: true,),
            body: SingleChildScrollView(

              child: BlocBuilder<DataFireBloc, DataFireState>(
                  builder: (context, state) {
                    if (state is UsuarioCargaNdoState) {
                      return Container(
                          child: Center(child: CircularProgressIndicator(),));
                    }
                    return

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Container(
                            child: Form(
                              key: formKeyGeneral,
                              child: Column(
                                children: [
                                  //foto del usuario
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(500),
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey
                                      ),
                                      image: fotoFile != null
                                          ? DecorationImage(
                                        image: FileImage(fotoFile!),
                                        fit: BoxFit.cover,
                                      )
                                          : DecorationImage(
                                        image: AssetImage(
                                            'assets/images/anonimo.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    height: ancho * 0.8,
                                    width: ancho * 0.8,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                  ),

                                  //Botones Foto Perfil
                                  Container( //color: Colors.black,
                                    height: alto * 0.06,
                                    width: ancho * 0.7,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      children: [
                                        FloatingActionButton(
                                          onPressed: () {
                                            TomarFoto();
                                          },
                                         // tooltip: 'tomar imagen',
                                          child: Icon(Icons.add_a_photo,
                                            color: Colors.white,),
                                          backgroundColor: Colors.green,
                                        ),

                                        FloatingActionButton(
                                          onPressed: () {
                                            GaleriaFotoPicker();
                                          },
                                        //  tooltip: 'eliminar foto',
                                          child: Icon(
                                            Icons.photo, color: Colors.white,),
                                          backgroundColor: Colors.green,
                                        ),
                                        FloatingActionButton(
                                          onPressed: () {
                                            setState(() {
                                              fotoFile = null;
                                            });
                                          },
                                      //    tooltip: 'borrar imagen',
                                          child: Icon(Icons.phonelink_erase,
                                            color: Colors.white,),
                                          backgroundColor: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),

                                  //Nombre del usuario
                                  TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      labelStyle: EstiloTexto(alto),
                                    ),

                                    controller: nombreControlador,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      actualizarControladorNombre(
                                          nombreControlador.text);
                                    },
                                  ),

                                  SizedBox(height: 20,),

                                  //Fecha de Nacimiento
                                  TextFormField(
                                      controller: fechaControlador,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        labelText: "Birthdate",

                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter your date of birth';
                                        }
                                        else if (resultadoAno < 18) {
                                          return 'You are a minor';
                                        }
                                        else if (resultadoAno == 18 &&
                                            resultadoMes < 0) {
                                          return 'You are still a minor';
                                        }
                                        else if (resultadoAno == 18 &&
                                            resultadoMes == 0 &&
                                            resultadoDia < 0) {
                                          return 'You are still a few days minor';
                                        }

                                        return null;
                                      },
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? fechaEscogida = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1920),
                                            lastDate: DateTime.now());

                                        if (fechaEscogida != null) {
                                          print(
                                              fechaEscogida);
                                          String fechaFormateada = DateFormat(
                                              'yyyy-MM-dd').format(
                                              fechaEscogida);
                                          //GUARDAR
                                          actualizarControladorfechaNacimiento(
                                              fechaFormateada);
                                          String anoS = usuario.fechaNacimiento
                                              .substring(0, 4);
                                          String mesS = usuario.fechaNacimiento
                                              .substring(5, 7);
                                          String diaS = usuario.fechaNacimiento
                                              .substring(8, 10);
                                          int anoI = int.parse(anoS);
                                          int mesI = int.parse(mesS);
                                          int diaI = int.parse(diaS);
                                          int anoActual = DateTime
                                              .now()
                                              .year;
                                          int mesActual = DateTime
                                              .now()
                                              .month;
                                          int diaActual = DateTime
                                              .now()
                                              .day;

                                          setState(() {
                                            fechaControlador.text = usuario
                                                .fechaNacimiento; //set foratted date to TextField value.


                                            resultadoAno = anoActual - anoI;
                                            resultadoMes = mesActual - mesI;
                                            resultadoDia = diaActual - diaI;
                                            print('value de fecha nac: ' +
                                                anoI.toString());
                                          }
                                          );
                                        } else {
                                          print("fecha no seleccionada");
                                        }
                                      }
                                  ),

                                  SizedBox(height: 20,),

                                  //Genero
                                  Container(
                                    width: ancho,
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                            width: ancho * 0.5,
                                            child: Text('Gender',
                                                style: TextStyle(fontSize: 15,
                                                    color: Colors.grey)
                                            )
                                        ),
                                        //dropdown elegir género
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

                                  //Profesion
                                  Container(
                                    width: ancho,
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          width: ancho * 0.5,
                                          child: Text('Research',
                                              style: TextStyle(fontSize: 15,
                                                  color: Colors.grey)),
                                        ),
                                        //dropdown elegir profesión
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            value: usuario.profesion,
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

                                  //Especialidad del usuario
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
                                      actualizarControladorEspecialidad(
                                          especialidadControlador.text);
                                    },
                                  ),

                                  SizedBox(height: 30,),


                                  //Descripcion
                                  TextFormField(
                                    maxLength: 400,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Research description',
                                      labelStyle: EstiloTexto(alto),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: DescripcionControlador,
                                    onSaved: (value) {
                                      actualizarControladorDescripcion(
                                          DescripcionControlador.text);
                                    },
                                  ),

                                  SizedBox(height: 30,),

                                  Text('6 photographs maximum',
                                    style: EstiloInstrucciones(alto),),

                                  //4 Fotografías

                                  BlocBuilder<FotoBloc, FotoState>(
                                      builder: ( context, state) {
                                        if (state is FotoBorradaState) {
                                          return
                                            //imagenesElegidas en  lugar de _selectedimages
                                            Column(
                                              children: [
                                                Container(
                                                    height: 300,
                                                    child: //_selectedImages != null ?

                                                    GridView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3),
                                                      itemCount: imagenesElegidas!.length,
                                                      itemBuilder: (context, index) {
                                                        return Stack(
                                                            fit: StackFit.expand,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(5),
                                                                child: Image.file(
                                                                  imagenesElegidas![index], //) //Image.network(
                                                                  //  imagenesElegidas![index],
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment.topRight,
                                                                child: IconButton(
                                                                    onPressed: () {

                                                                      setState(() {
                                                                        imagenesElegidas.removeAt(index);
                                                                      });

                                                                      //  _selectedImages![index].deleteSync();
                                                                      BlocProvider.of<FotoBloc>(context).add(FotoBorrarEvent());


                                                                    },
                                                                    icon: Icon(Icons.cancel)
                                                                ),
                                                              ),
                                                            ]
                                                        );
                                                      },
                                                    )
                                                ),
                                                SizedBox(height: 10,),
                                                //Botones 6 Fotos
                                                Container(
                                                  height: alto*0.06,
                                                  width: ancho*0.46,
                                                  child:
                                                  FloatingActionButton(
                                                    onPressed:() async{

                                                      await ElegirImagenesServicios();

                                                    },// getfotoUrl,
                                                  //  tooltip: 'elegir fotos',
                                                    child: Icon(Icons.add_circle_outline,color: Colors.white, ),
                                                    backgroundColor:  Colors.green,
                                                  ),
                                                ),
                                              ],
                                            );//
                                        }
                                        else if(state is FotoInicialState)
                                        {
                                          return
                                            //imagenesElegidas en  lugar de _selectedimages
                                            Column(
                                              children: [
                                                Container(
                                                    height: 250,
                                                    child: //_selectedImages != null ?

                                                    GridView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3),
                                                      itemCount: imagenesElegidas!.length,
                                                      itemBuilder: (context, index) {
                                                        return Stack(
                                                            fit: StackFit.expand,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(5),
                                                                child: Image.file(
                                                                  imagenesElegidas![index], //) //Image.network(
                                                                  //  imagenesElegidas![index],
                                                                  fit: BoxFit.cover,
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment.topRight,
                                                                child: IconButton(
                                                                    onPressed: () async{

                                                                      setState(() {
                                                                        imagenesElegidas.removeAt(index);
                                                                      });
                                                                      //  await _selectedImages[index].delete();
                                                                      BlocProvider.of<FotoBloc>(context).add(FotoBorrarEvent());

                                                                    },
                                                                    icon: Icon(Icons.cancel)
                                                                ),
                                                              ),
                                                            ]
                                                        );
                                                      },
                                                    )
                                                ),
                                                SizedBox(height: 10,),
                                                //Botones 6 Fotos
                                                Container(
                                                  height: alto*0.06,
                                                  width: ancho*0.46,
                                                  child:
                                                  FloatingActionButton(
                                                    onPressed:() async{

                                                      await ElegirImagenesServicios();

                                                    },// getfotoUrl,
                                                  //  tooltip: 'elegir fotos',
                                                    child: Icon(Icons.add_circle_outline,color: Colors.white, ),
                                                    backgroundColor:  Colors.green,
                                                  ),
                                                ),
                                              ],
                                            );
                                        }
                                        return
                                          Column(
                                            children: [
                                              Container(child: Text('No hay fotos'),
                                              ),
                                              SizedBox(height: 10,),
                                              //Botones 6 Fotos
                                              Container(
                                                height: alto*0.06,
                                                width: ancho*0.46,
                                                child:
                                                FloatingActionButton(
                                                  onPressed:() async{
                                                    // GaleriaVariasFotosPicker();

                                                    await ElegirImagenesServicios();
                                                    //GaleriaVariasFotosPicker();
                                                    //  GaleriaFotoPicker();
                                                  },// getfotoUrl,
                                                //  tooltip: 'elegir fotos',
                                                  child: Icon(Icons.add_circle_outline,color: Colors.white, ),
                                                  backgroundColor:  Colors.green,
                                                ),
                                              ),
                                            ],
                                          );

                                      }
                                  ),




                                  SizedBox(height: 30,),

                                  Text(
                                    'Youtube URL', style: EstiloInstrucciones(
                                      alto),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Expanded(
                                        child:
                                        TextFormField(

                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter your YouTube URL',
                                              fillColor: Colors.green.withAlpha(
                                                  20),
                                              filled: true,
                                              hintStyle: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.green,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: const Icon(Icons.clear,
                                                  color: Colors.green,),
                                                onPressed: () =>
                                                    youtubeControlador.clear(),
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            controller: youtubeControlador,

                                            onChanged: (value) {
                                              actualizarControladorYoutube(
                                                  youtubeControlador.text);
                                              if (youtubeControlador.text
                                                  .isNotEmpty) {
                                                String? id = YoutubePlayer
                                                    .convertUrlToId(
                                                    youtubeControlador.text);
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

                                  VideoYoutubeUsuario(
                                    controladorYoutube: controladorVideoYoutube,
                                    urlYoutube: youtubeControlador.text,),

                                  SizedBox(height: 30,),
                                  SizedBox(height: 30,),

                                  Text('Redes Sociales', style: TextStyle(
                                      color: Colors.grey),),

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
                                      actualizarControladorPagWeb(
                                          pagwebControlador.text);
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
                                      actualizarControladorFace(
                                          facebookControlador.text);
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
                                      actualizarControladorInsta(
                                          instagramControlador.text);
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
                                      actualizarControladorTikTok(
                                          tiktokControlador.text);
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
                                      actualizarControladorEmail(
                                          emailControlador.text);
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

                                    onSaved: (value) {
                                      actualizarControladorTelefono(
                                          telefonoControlador.text);
                                    },
                                  ),

                                  SizedBox(height: 30,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      ubicando
                                          ? Text('Location On')
                                          : Text('Location Off'),
                                      Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.green,
                                        ),
                                        child: IconButton(onPressed: () {
                                          // Obtener la ubicación actual

                                          setState(() async{
                                            ubicando = !ubicando;
                                            if (ubicando == true) {
                                              actualizarControladorUbicacion(
                                                await miUbicacionCadena);
                                            }
                                            else {
                                              actualizarControladorUbicacion('');

                                            }
                                          }
                                          );
                                        },
                                            icon: ubicando ? Icon(
                                              Icons.person_pin_circle,
                                              color: Colors.white,) :
                                            Icon(
                                              Icons.cancel, color: Colors.white,)
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 30,),

                                  //Aceptar condiciones de uso
                                  Row(
                                      children: [
                                        Text('Accept Terms and Conditions'),
                                        Checkbox(
                                            activeColor: Colors.black,
                                            value: estaCheck,
                                            onChanged: (nuevoBool) {
                                              setState(() {
                                                estaCheck = nuevoBool as bool;
                                              }
                                              );
                                            }
                                        ),
                                      ]
                                  ),

                                  estaCheck ? Text('') : Text(
                                    'Accept the Terms and Conditions',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red),),

                                  ExpansionTile(
                                    leading: Icon(Icons.description),
                                    title: Text(
                                      'Terms and Conditions',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    backgroundColor: Colors.grey.shade100,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          'Terms and conditions related to this application including:'
                                              'use of user location data and personal information,'
                                              'to enter the application...',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 30,),

                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              ancho * 0.4, alto * 0.07)),
                                      onPressed: () async

                                      {
                                        if (imagenesElegidas.isEmpty) {
                                          //se activa el aviso de subir al menos una foto
                                          setState(() {
                                            hayFotos = false;
                                          });
                                          ;
                                        }
                                        else if (imagenesElegidas.isNotEmpty) {
                                          setState(() {
                                            hayFotos = true;
                                          });
                                        }

                                        usuario.idUsuario =
                                        await urRepo.ObtenerUidActual();

                                        if (formKeyGeneral.currentState!
                                            .validate() && estaCheck == true &&
                                            hayFotos == true)
                                        {
                                          formKeyGeneral.currentState!.save();
                                          setState(() {
                                            estaGuardando=true;
                                          });

                                          urlFotoPerfil =
                                          await urRepo.SubirUnaImagen(
                                              imagen: fotoFile as File);
                                          usuario.urlFotoPerfil = await urlFotoPerfil;
                                          BlocProvider.of<DataFireBloc>(context)
                                              .add(SubirVariasImagenesEvent(
                                              imagenesElegidas));
                                          BlocProvider.of<DataFireBloc>(context)
                                              .add(CrearUsuarioEvent(usuario));
                                          setState(() {
                                            estaGuardando=false;
                                          }
                                          );

                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TabMenu()));
                                        }
                                        else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(
                                                'Complete the required fields'),
                                              duration: Duration(seconds: 5),
                                              backgroundColor: Colors.black,
                                            ),
                                          );
                                        }
                                      },

                                      child: estaGuardando? Center(
                                        child:
                                        CircularProgressIndicator(
                                          color: Colors.white,),
                                      ):
                                      Text('Guardar',
                                        style: TextStyle(fontSize: alto * 0.028),)
                                  ),
                                  SizedBox(height: 30,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                  }
              ),
            )
        )
    );
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
}

