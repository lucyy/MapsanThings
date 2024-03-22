import 'package:flutter/material.dart';



class ProfileImageFullScreen extends StatelessWidget {
 // final Product product;
  final String urlFotoP;

  const ProfileImageFullScreen({Key? key,
    required this.urlFotoP,
 // required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//appBar: AppBar(),
      body: Stack(
        children:[
          Image(
          image: NetworkImage(urlFotoP), //AssetImage(product.image), // AssetImage('assets/images/gab.jpeg'),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
       Align(
         alignment: Alignment.topRight,
         child: Container(

         //  alignment: Alignment.topRight,
         //  color: Colors.white,
           margin: EdgeInsets.only(top: 40, right: 10),
           decoration: BoxDecoration(
             color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(30))

           ),
           child: IconButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               icon: Icon( Icons.close, color: Colors.white,)
           ),
         ),
       ),
        ]
      ),

    );
  }
}
