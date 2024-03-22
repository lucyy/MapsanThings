import 'package:flutter/material.dart';
import '../../Mapa/UI/Pantallas/Mapa_Despliegue.dart';
import '../../Usuario/Repositorio/Usuario_Sesion_Repositorio.dart';
import '../../Usuario/UI/Pantallas/Pantalla_Ajustes.dart';
import '../../Usuario/UI/Pantallas/Pantalla_Perfil_Usuario.dart';
import '../../Usuarios_Perfiles/UI/Pantallas/Perfil_En_Lista.dart';
import 'Mapa_Ubicacion.dart';



//const ubicacionBackground = "fetchBackground";

/*
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case ubicacionBackground:
        {
        break;
        }
    }
    return Future.value(true);
  });
}

  */

class TabMenu extends StatefulWidget {
  TabMenu({Key? key,
  }) : super(key: key);

  @override
  _TabMenuState createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> with SingleTickerProviderStateMixin{

  late TabController controlTabMenu;
  final UsuarioSesionRepositorio usuarioSesionRepo=UsuarioSesionRepositorio();

//  Workmanager workmanager= Workmanager();

  @override
  void initState() {
    super.initState();

    controlTabMenu = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 2,
        child: Scaffold(

            appBar: AppBar(

              foregroundColor: Colors.green,
              flexibleSpace: Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/negro.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text('Maps and Things'),
              automaticallyImplyLeading: false,

              bottom: TabBar(
                indicatorColor: Colors.green,
                controller: controlTabMenu,
                tabs: [
                  Tab(icon: Icon(Icons.perm_identity, color: Colors.green,)
                  ),
                  Tab(icon: Icon(Icons.map_rounded, color: Colors.green)
                  ),
                ],
              ),

              actions: [




          IconButton(
          icon: Icon(Icons.person_pin_circle,),
        onPressed: ()  async{
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>  MapaUbicacion(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
      ),


                PopupMenuButton(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    itemBuilder: (context){
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text("My Profil"),
                        ),

                        PopupMenuItem<int>(
                          value: 1,
                          child: Text("Settings"),
                        ),

                        PopupMenuItem<int>(
                          value: 2,
                          child: Text("Sign Out"),
                        ),
                      ];
                    },

                    onSelected:(value){
                      if(value == 0){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>  PantallaPerfilUsuario(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(opacity: animation, child: child);
                            },
                          ),
                        );

                      }
                      else if(value == 1)
                      {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            PantallaAjustes()
                        )
                        );

                      }else if(value == 2){

                        usuarioSesionRepo.SignOutGoogleFire();
                      }
                    }
                ),
              ],
            ),
            body:

            TabBarView(
              controller: controlTabMenu,
              physics: controlTabMenu.index == 1 ?
              NeverScrollableScrollPhysics() :
              AlwaysScrollableScrollPhysics(),

              children: [
                PerfilEnLista(controlTabMenu: controlTabMenu,),
                MapaDespliegue(),
              ],
            )
        ),
      );
  }
}