import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditarFotos extends StatefulWidget {
  const EditarFotos({Key? key}) : super(key: key);

  @override
  _EditarFotosState createState() => _EditarFotosState();
}

class _EditarFotosState extends State<EditarFotos> {


  List<File> imagenesElegidas = [];

  Future<void> GaleriaVariasFotosPicker() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();

    if (imagenesElegidas.length <= 4) {

      setState(() {

      }

      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fotografías'),),
      body: Container(
        child: Column(
          children: [
            Container(height: 500,),
            Row(
              children: [
                ElevatedButton(onPressed: (){
                  GaleriaVariasFotosPicker();
                }, child: Text('Agregar')),
                ElevatedButton(onPressed: (){}, child: Text('Borrar Todo')),
              ],
            )
          ],
        ),
      )
    );
  }
}
