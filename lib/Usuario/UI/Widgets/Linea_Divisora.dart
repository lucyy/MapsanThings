import 'package:flutter/material.dart';

import '../../../Estilos.dart';


class LineaDivisora extends StatelessWidget {
  const LineaDivisora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size tamanoPantalla= MediaQuery.of(context).size;
    return Container(
      width: tamanoPantalla.width*0.6,

              child: Divider(
                color: ColorVerde1,
                height: 1.5,
              )

    );
  }
}
