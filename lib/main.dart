import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapsandthings/Usuario/Bloc/Foto_Bloc.dart';

import 'Menu/Bloc/Ubicacion_Bloc.dart';
import 'Menu/Bloc/Ubicacion_State.dart';
import 'Usuario/UI/Pantallas/PantallaComprobacioInicial.dart';
import 'Usuarios_Perfiles/Bloc/DataFirebase_Bloc/Data_Fire_Bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //definida en portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>DataFireBloc()),
          BlocProvider(create: (context)=>UbicacionBloc(UbicacionInicialState ())),
          BlocProvider(create: (context)=> FotoBloc())
        ],
        child:  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MAT',
            theme: ThemeData(
              colorScheme: ColorScheme.light(primary: Colors.green),
              // scaffoldBackgroundColor: Colors.white,
            ),
            //  home: TabMenu()));
            home: PantallaComprobacionInicial()
        )
    );
  }
}
