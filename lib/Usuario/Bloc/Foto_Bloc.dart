

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapsandthings/Usuario/Bloc/Foto_Event.dart';
import 'package:mapsandthings/Usuario/Bloc/Foto_State.dart';

class FotoBloc extends Bloc<FotoEvent, FotoState>{
  FotoBloc(): super(FotoInicialState()){

    on<FotoBorrarEvent>((event, emit) {

      emit(FotoBorradaState());
    });

  }
}