
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';

class FotoAbiertaPerfil extends StatefulWidget {

  LoadingBuilder? loadingBuilder;
  final Decoration backgroundDecoracion;
  final dynamic? minEscala;
  dynamic maxEscala=500;
  final PageController pagControlador;
  final String urlFoto;

  FotoAbiertaPerfil({Key? key,
    this.loadingBuilder,
    required this.backgroundDecoracion,
    required this.minEscala, this.maxEscala,
    required this.urlFoto,
  }) :  pagControlador = PageController(initialPage: 0);  // super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _FotoAbierta();
  }
}

class _FotoAbierta extends State<FotoAbiertaPerfil>
{
  int? indiceActual;

  @override
  void initState(){
    super.initState();
  }

  void onPageChanged(int index)
  {
    setState(() {
      indiceActual=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Profile picture'),),
      body: Container(
        decoration: widget.backgroundDecoracion,
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: OpcionesFoto,
              itemCount: 1,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoracion as BoxDecoration,
              pageController: widget.pagControlador,
              onPageChanged: onPageChanged,

            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions OpcionesFoto(BuildContext context, int index)
  {
    final String item= widget.urlFoto;
    return
  PhotoViewGalleryPageOptions(
        imageProvider:NetworkImage(
           item),
        initialScale:  PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5+ index / 10),
        maxScale: PhotoViewComputedScale.contained * 1.1,
    );
  }
}

