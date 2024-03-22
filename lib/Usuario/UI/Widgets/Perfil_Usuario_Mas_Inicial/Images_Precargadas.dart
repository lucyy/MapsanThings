import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Usuarios_Perfiles/UI/Widgets/Foto_Abierta_Precargada.dart';
import 'Foto_Contenedor_Precargada.dart';


class ImagesPrecargadas extends StatefulWidget  {

  ImagesPrecargadas({Key? key,

  }) : super(key: key);

  @override
  _ImagesPrecargadasState createState() => _ImagesPrecargadasState();
}

class _ImagesPrecargadasState extends State<ImagesPrecargadas> {

  final List<ImageProvider> _imageProviders = [];
  List<String>? urlsFotosServiciosDescargadas = [];
  int actual=0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var usuarioActual;
  List<File> imagenesElegidas = [];

  @override
  void initState() {

    super.initState();
    usuarioActual=auth.currentUser;
    obtenerFotosServicioUrls();
  }

  Future<void> GaleriaElegirFotos() async {
    final List<XFile> imagenes = await ImagePicker().pickMultiImage();

    final List<File?> imagenesCompresas = [];

    for (final imagen in imagenes) {
      final archivoCompreso = await FlutterImageCompress.compressAndGetFile(
        imagen.path,
        imagen.path + '_fire.jpg',
        quality: 50,
      );

      imagenesCompresas!.add(archivoCompreso as File?);
    }

    if (imagenesCompresas != null) {
      setState(() {
        imagenesElegidas.addAll(
            imagenesCompresas.map((imageCompressed) => File(imageCompressed!.path)).toList());
      });
    }
  }

  Future<void> obtenerFotosServicioUrls() async {

    final storageRef = FirebaseStorage.instance.ref().child('usuarios_fotos/${usuarioActual?.uid}/servicio/');
    final ListResult result = await storageRef.listAll();
    final List<Reference> allFiles = result.items;
    final List<String> photoUrls = [];

    for (final ref in allFiles) {
      final String url = await ref.getDownloadURL();
      photoUrls.add(url);
    }

    setState(() {
      urlsFotosServiciosDescargadas = photoUrls;
    });

    try {
      if(urlsFotosServiciosDescargadas!=null) {
        // Precarga todas las imágenes en la lista de URL de imagen
        for (String imageUrl in urlsFotosServiciosDescargadas!) {
          final ImageProvider imageProvider = NetworkImage(imageUrl);
          final Image resolvedImage = Image(image: imageProvider);
          resolvedImage.image.resolve(ImageConfiguration()).addListener(
              ImageStreamListener((_, __) {
                setState(() {
                  // Actualiza el estado con la lista de ImageProvider precargados
                  _imageProviders.add(imageProvider);
                });
              }));
        }
      }
    }
    catch(error)
    {
      print(''+error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    double alto=MediaQuery.of(context).size.height;
    double ancho= MediaQuery.of(context).size.width;

    return _imageProviders.length== urlsFotosServiciosDescargadas!.length?  Column(
      children: [
        Expanded(
          child: _imageProviders.isNotEmpty? Stack(
              children: [ Container(
                color: Colors.black,
                width: ancho,
                child:  CarouselSlider(
                  items: _imageProviders.map((item) => Container(

                    child: FotoContenedorPrecargada(
                      onTap: () { AbrirFoto(context, actual);},
                      imageProvider: item,
                    ),
                  )).toList(),
                  options: CarouselOptions(
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason){
                        setState(() {
                          actual=index;
                        });
                      }
                  ),
                ),
              ),

                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () async{

                        setState(() {
                        });
                      },
                      icon: Icon(Icons.cancel, color: Colors.green,)
                  ),
                ),
              ]
          ): Container(child: Center(child: Text('No existen imágenes'),),color: Colors.black12,),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(int i=0;i<_imageProviders.length;i++)
              Container(
                height: 10,
                width: 10,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: actual==i? Colors.green:Colors.white,
                    shape: BoxShape.circle,
                    boxShadow:[
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(2,2)
                      )
                    ]
                ),
              )
          ],
        ),
        SizedBox(height: 10,),

        Container(
          height: alto*0.06,
          width: ancho*0.46,
          child:
          FloatingActionButton(
            onPressed:() async{
              await GaleriaElegirFotos();
            },// getfotoUrl,
            tooltip: 'elegir fotos',
            child: Icon(Icons.photo_album,color: Colors.white, ),
            backgroundColor:  Colors.green,
          ),
        ),
      ],
    ):Center(child: CircularProgressIndicator());
  }

  AbrirFoto(BuildContext context, int index) {

    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>FotoAbiertaPrecargada(
                listaImageProviders:_imageProviders,
                backgroundDecoration: const BoxDecoration(
                    color: Colors.black
                ),
                minScale: 300,
                initialIndex: index,
                scrollDirection: Axis.horizontal)
        )
    );
  }
}
