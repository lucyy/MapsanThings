/*
import 'package:flutter/material.dart';

import '../../Chat/Auxiliar/constants.dart';
import '../../Chat/Auxiliar/helperfunctions.dart';
import '../../Chat/Repositorio/database.dart';

class MailUserName extends StatelessWidget {
   MailUserName({Key? key}) : super(key: key);

  TextEditingController controladorEmail=TextEditingController();
  TextEditingController controladorNombreUsuario= TextEditingController();
   DatabaseMethods databaseMethods= new DatabaseMethods();

   final formkey= GlobalKey<FormState>();

   funcion()  async{
     Map<String, String> userInfoMap = {
       "nombre": controladorNombreUsuario.text,
       "email": controladorEmail.text,
     };

     databaseMethods.uploadUserInfo(userInfoMap);


/*
     HelperFunctions.saveUserNameSharedPreference(
         controladorNombreUsuario.text);

 */

     HelperFunctions.saveUserEmailSharedPreference(
         controladorEmail.text);

     Constants.myName =HelperFunctions.getUserEmailSharedPreference().toString();
       //  HelperFunctions.getUserNameSharedPreference().toString();
     print("mi nombre es: " + Constants.myName);


   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Hola')),
      body: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                  Form(
                  key: formkey,
                  child: Column(
                  children: [ TextFormField(
                    decoration:InputDecoration(
                      hintText: 'email'
                    ),
                    controller: controladorEmail,
                  ),


                TextFormField(
                  decoration:InputDecoration(
                      hintText: 'nombre de usuario'
                  ),
                  controller: controladorNombreUsuario,
                ),

                      ]
                  )
              ),

                ElevatedButton(onPressed: (){
                      funcion();

                }, child: Text('Guardar')
                )

              ],
            ),

      ),
    );
  }
}

*/