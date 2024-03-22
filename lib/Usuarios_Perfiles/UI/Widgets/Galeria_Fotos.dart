
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../Modelo/Foto.dart';
import 'Foto_Abierta.dart';
import 'Foto_Contenedor.dart';


class GaleriaFotos extends StatefulWidget {
  const GaleriaFotos({Key? key}) : super(key: key);

  @override
  _GaleriaFotosState createState() => _GaleriaFotosState();
}

class _GaleriaFotosState extends State<GaleriaFotos> {
  bool verticalGallery=false;
  List<Foto> galleries =[
    Foto(id:0, resource: "assets/images/mountain.jpg", description: "Imagen Montaña 1", isSVG: false),
    Foto(id:1, resource: "assets/images/mountain1.jpg", description: "Imagen Montaña 2", isSVG: false),
    Foto(id:2, resource: "assets/images/mountain2.jpg", description: "Imagen Montaña 3", isSVG: false),

  ];

  int _current=0;

  @override
  Widget build(BuildContext context) {
    return

      Container(
        height:270,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 300.0,
                child:ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CarouselSlider(
                      items: galleries.map((item) => Container(
                        child: FotoContenedor(
                          fotoModelo: item,
                          onTap: (){
                            _abrirFoto(context, item.id!);
                          },
                        ),
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

                    //   Video_Deploy(),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i=0;i<galleries.length;i++)
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
            //  Video_Deploy()
            //    ButterFlyAssetVideo()
          ],
          // ),
        ),
      );
  }

  void _abrirFoto(BuildContext context, final int index){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>FotoAbierta(
                gallerias:galleries,
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

