
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';

import '../../Modelo/Foto.dart';

class FotoAbierta extends StatefulWidget {

  LoadingBuilder? loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic? minScale;
  dynamic maxScale=500; //estaba final
  final int initialIndex;
  final PageController pageController;
  final List<Foto> gallerias;
  final Axis scrollDirection;

  FotoAbierta({Key? key,
    this.loadingBuilder,
    required this.backgroundDecoration,
    required this.minScale, this.maxScale,
    required this.initialIndex,
    //required this.pageController,
    required this.gallerias,
    required this.scrollDirection}) :  pageController = PageController(initialPage: initialIndex);  // super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _FotoAbierta();
  }
}

class _FotoAbierta extends State<FotoAbierta>
{
  int? currentIndex;

  @override
  void initState(){
    super.initState();
    currentIndex=widget.initialIndex;
  }

  void onPageChanged(int index)
  {
    setState(() {
      currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.gallerias[currentIndex!.toInt()].description.toString(),),),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.gallerias.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration as BoxDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,


            ),

          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index)
  {
    final Foto item= widget.gallerias[index];
    return // item.isSVG as bool ?

    PhotoViewGalleryPageOptions(
        imageProvider: AssetImage(item.resource.toString(),),
        initialScale:  PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5+ index / 10),
        maxScale: PhotoViewComputedScale.contained * 1.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id!.toInt())
    );
  }

}