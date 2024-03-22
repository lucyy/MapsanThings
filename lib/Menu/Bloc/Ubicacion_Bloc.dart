

import 'package:flutter_bloc/flutter_bloc.dart';

import 'UbicacionEvent.dart';
import 'Ubicacion_State.dart';

class UbicacionBloc extends Bloc<UbicacionEvent, UbicacionState>{
  UbicacionBloc(UbicacionState initialState) : super(initialState){

    on<UbicacionTriggerEvent>((event, emit){
     bool temp= event.ubicando;
     if(temp==true)
       {
         emit (UbicacionActivaState());
       }
     else if(temp==false)
       {
         emit(UbicacionPasivaState());
       }
    }
    );
  }

}