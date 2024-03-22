import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../Usuario/UI/Widgets/Perfil_Usuario_Mas_Inicial/Foto_Contenedor_Precargada.dart';
import '../Foto_Abierta_Precargada.dart';


//se carga las imágenes desde la firebase, aquí está el botón editar para borrar o agregar imágenes,
//no se necesita guardar las url en doc

class FotosServicioUsuarios extends StatefulWidget  {
  /*
  final List<String> imageUrls=['https://firebasestorage.googleapis.com/v0/b/whosnearme-7fd51.appspot.com/o/usuarios_fotos%2FyJbOwYbu9XQEJhV6c1mRqaI3iJg2%2Fservicio%2F16802837737640.jpg?alt=media&token=9389e76b-65c5-4987-bd81-0bdb2d8f7028',
    'https://firebasestorage.googleapis.com/v0/b/whosnearme-7fd51.appspot.com/o/usuarios_fotos%2FyJbOwYbu9XQEJhV6c1mRqaI3iJg2%2Fservicio%2F16802838065051.jpg?alt=media&token=67f75b88-d0f0-4032-9363-225f2391e933',
    'https://firebasestorage.googleapis.com/v0/b/whosnearme-7fd51.appspot.com/o/usuarios_fotos%2FyJbOwYbu9XQEJhV6c1mRqaI3iJg2%2Fservicio%2F16802838283572.jpg?alt=media&token=29fb0dcc-2824-4f3a-95af-eaac67f901f3',
'https://firebasestorage.googleapis.com/v0/b/whosnearme-7fd51.appspot.com/o/usuarios_fotos%2FyJbOwYbu9XQEJhV6c1mRqaI3iJg2%2Fservicio%2F16802838657153.jpg?alt=media&token=a5ab1899-7e68-423e-9069-2089cb09566b',
    'https://firebasestorage.googleapis.com/v0/b/whosnearme-7fd51.appspot.com/o/usuarios_fotos%2FyJbOwYbu9XQEJhV6c1mRqaI3iJg2%2Fservicio%2F16802850123323.jpg?alt=media&token=eab77de2-ab63-4ba4-afe7-862d043bee7d',
  ];

   */

  final String uidUsuario;
  // final List<String> imageUrls;
  FotosServicioUsuarios({Key? key,
    required this.uidUsuario,
    //  required this.imageUrls,
    //  this.imageUrls
  }) : super(key: key);


  @override
  _FotosServicioUsuariosState createState() => _FotosServicioUsuariosState();
}

class _FotosServicioUsuariosState extends State<FotosServicioUsuarios> {


  final List<ImageProvider> _imageProviders = [];
  List<String>? urlsFotosServiciosDescargadas = [];
  int _current=0;
 // final FirebaseAuth _auth = FirebaseAuth.instance;
 // var currentUser;

  @override
  void initState() {
    super.initState();
   // currentUser=_auth.currentUser;
    _getfotosServicioUrls();
    //getImages();
    //  print('el length de las image es: '+widget.imageUrls.length.toString());
    // getImages();



  }
  Future<void> _getfotosServicioUrls() async {
    //  final currentUser = _auth.currentUser;
   // final storageRef = FirebaseStorage.instance.ref().child('usuarios_fotos/${currentUser?.uid}/servicio/');
    final storageRef = FirebaseStorage.instance.ref().child('usuarios_fotos/${widget.uidUsuario}/servicio/');
    final ListResult result = await storageRef.listAll();
    final List<Reference> allFiles = result.items;
    final List<String> photoUrls = [];

    for (final ref in allFiles) {
      final String url = await ref.getDownloadURL();
      photoUrls.add(url);
      // print('si se imoprime la foto servicio: '+url);
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
                  //    print('los image providers '+ widget.imageUrls[3]);
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

  /*
//  Future<List<ImageProvider>> getImages() async
  Future<void> getImages() async
  {
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
                  //    print('los image providers '+ widget.imageUrls[3]);
                });
              }));
        }
      }
    }
    catch(error)
    {
      print(''+error.toString());
    }

  //  return _imageProviders;
  }

   */

  @override
  Widget build(BuildContext context) {

    double alto=MediaQuery.of(context).size.height;
    double ancho= MediaQuery.of(context).size.width;

    return _imageProviders.length== urlsFotosServiciosDescargadas!.length?  Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            width: ancho,
            child:  CarouselSlider(
              items: _imageProviders.map((item) => Container(

                // child:// GestureDetector(
                // onTap: _abrirFoto(context, _current),
                child:// Image(image: item, fit: BoxFit.cover)
                FotoContenedorPrecargada(
                  onTap: () { _abrirFoto(context, _current);},
                  imageProvider: item,
                ),
                //  ),
              )).toList(),
              options: CarouselOptions(
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason){

                    setState(() {
                      _current=index;
                    });
                  }
              ),
            ),

            /*CarouselSlider.builder(
              itemCount: _imageProviders.length,
             // itemCount: widget.imageUrls.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final ImageProvider imageProvider = _imageProviders[index];
                return  GestureDetector(
                    child: Image(image: imageProvider, fit: BoxFit.cover),
                  onTap: _abrirFoto(context,index),
                );

              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              //  autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason){

                    setState(() {
                      _current=index;
                    });
                  }
              ),
            ),

            */
          ),
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
                    color: _current==i? Colors.orange:Colors.white,
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
        //Botones 4 Fotos
        Container( //color: Colors.black,
            height: alto * 0.04,
            width: ancho * 0.3,
            child:
            ElevatedButton(
              onPressed: (){},
              child: Text('Editar'),
            )
          /*
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround,
                  children: [
                    /*
                        FloatingActionButton(
                          onPressed:(){
                        //    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPhotos()));
                          //  TomarFoto();
                          //  setState(() {
                         //   });
                          }, //getImage,
                          tooltip: 'agregar imágenes',
                          child: Icon(Icons.add_a_photo,color: Colors.white,),
                          backgroundColor:  Colors.orange,
                        ),
*/
                    FloatingActionButton(
                      onPressed: () {
                       // _pickImages();
                        //GaleriaVariasFotosPicker();
                        //  GaleriaFotoPicker();
                      }, // getfotoUrl,
                      tooltip: 'eliminar foto',
                      child: Icon(Icons.photo, color: Colors
                          .white,),
                      backgroundColor: Colors.orange,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          // _selectedImages.re;
                        });
                      }, // getfotoUrl,
                      tooltip: 'borrar imagen',
                      child: Icon(Icons.phonelink_erase,
                        color: Colors.white,),
                      backgroundColor: Colors.orange,
                    ),
                  ],
                ),

                     */
        ),
      ],


    ):Center(child: CircularProgressIndicator());


  }

  _abrirFoto(BuildContext context, int index) {

    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>FotoAbiertaPrecargada(
                listaImageProviders:_imageProviders,
                //  loadingBuilder: loadingBuilder,
                backgroundDecoration: const BoxDecoration(
                    color: Colors.black
                ),
                minScale: 300,
                initialIndex: index,
                // galleries: galleries,
                scrollDirection: Axis.horizontal)
        )
    );
  }


}
