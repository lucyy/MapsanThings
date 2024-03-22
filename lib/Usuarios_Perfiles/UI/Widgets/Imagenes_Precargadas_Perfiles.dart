
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../Usuarios_Perfiles/UI/Widgets/Foto_Abierta_Precargada.dart';
import '../../../Usuario/UI/Widgets/Perfil_Usuario_Mas_Inicial/Foto_Contenedor_Precargada.dart';

class ImagenesPrecargadasPerfiles extends StatefulWidget  {

  final String idUsuario;

  ImagenesPrecargadasPerfiles({
    Key? key,
    required this.idUsuario,

  }) : super(key: key);


  @override
  _ImagenesPrecargadasPerfilesState createState() => _ImagenesPrecargadasPerfilesState();
}

class _ImagenesPrecargadasPerfilesState extends State<ImagenesPrecargadasPerfiles> {


  final List<ImageProvider> _imageProviders = [];
  List<String>? urlsFotosServiciosDescargadas = [];
  int actual=0;

  @override
  void initState() {

    super.initState();
    obtenerFotosServicioUrls();
  }
  Future<void> obtenerFotosServicioUrls() async {
  //  await Future.delayed(Duration(milliseconds: 500));
    final storageRef = FirebaseStorage.instance.ref().child('usuarios_fotos/${widget.idUsuario}/servicio/');
    final ListResult result = await storageRef.listAll();
    final List<Reference> allFiles = result.items;
    final List<String> photoUrls = [];

    if(allFiles!=[]) {
      for (final ref in allFiles) {
        final String url = await ref.getDownloadURL().
        whenComplete(() => null);
        photoUrls.add(url);
      }
    }
      setState(() {
        urlsFotosServiciosDescargadas =  photoUrls;
      }
      );

    try {
      if(urlsFotosServiciosDescargadas!=null) {
        for (String imageUrl in urlsFotosServiciosDescargadas!) {
          final ImageProvider imageProvider = NetworkImage(imageUrl);
          final Image resolvedImage = Image(image: imageProvider);
          resolvedImage.image.resolve(ImageConfiguration()).addListener(
              ImageStreamListener((_, __) {
                setState(() {
                  _imageProviders.add(imageProvider);
                }
                );
              }
              )
          );
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

    return _imageProviders.length== urlsFotosServiciosDescargadas!.length?  Container(
      height: alto*0.3,
      child: Column(
        children: [
          Expanded(
            child: _imageProviders.isNotEmpty?
                  Container(
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
                          }
                          );
                        }
                    ),
                  ),
            ):
            Container(child:
            Center(
              child: Text('There are no images'),
            ),
              color: Colors.black12,),
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
                      color: actual==i? Colors.green:
                      Colors.white,
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

        ],
      ),
    ):Center(
        child: CircularProgressIndicator()
    );
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
