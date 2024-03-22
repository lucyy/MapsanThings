import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Usuario/Modelo/Usuario.dart';
import '../../Bloc/DataFirebase_Bloc/Data_Fire_Bloc.dart';
import '../../Bloc/DataFirebase_Bloc/Data_Fire_Event.dart';
import '../../Repositorio/Usuario_Repositorio.dart';
import 'Tarjeta_Perfil_EnLista.dart';





class PerfilEnLista extends StatefulWidget {
  final TabController controlTabMenu;
  const PerfilEnLista({
    Key? key,
    required this.controlTabMenu,

  }) : super(key: key);

  @override
  State<PerfilEnLista> createState() => _PerfilEnListaState();
}

class _PerfilEnListaState extends State<PerfilEnLista>    with AutomaticKeepAliveClientMixin<PerfilEnLista>{

  @override
  bool get wantKeepAlive => true;

  UsuarioRepositorio repoUsuario=UsuarioRepositorio();
  String uidObtenido='';

  @override
  void initState() {
    uidActual();
    super.initState();
  }

  Future<void> uidActual ()async
  {
    setState(() async{
      uidObtenido=await repoUsuario.ObtenerUidActual();
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Usuario>>(
        stream: repoUsuario.obtenerUsuarios(),
        builder:(context, AsyncSnapshot<List<Usuario>> snapshot)  {

          final List<Usuario> usuarios= snapshot.data ?? [];
        final List<Usuario> usuariosLista=usuarios.where((element) => element.idUsuario!= uidObtenido).toList();

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: Center(child: CircularProgressIndicator())
            );
          }

          else if(snapshot.hasData) {
            BlocProvider.of<DataFireBloc>(context).add(DescargarUsuariosEvent(usuariosLista));

            return  ListView.builder(
                itemCount:usuariosLista.length,
                itemBuilder: (BuildContext context, int index) {
                  return  TarjetPerfilEnLista(
                    usuario: usuariosLista[index], controlTabMenu: widget.controlTabMenu,
                  );
                }
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
