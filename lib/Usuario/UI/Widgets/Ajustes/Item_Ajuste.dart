import 'package:flutter/material.dart';
class ItemAjuste extends StatefulWidget {

  final Icon icono;
  final String titulo;
  final String contenido;
  final Function funcion;
  const ItemAjuste({Key? key,
    required this.icono,
    required this.titulo,
    required this.funcion,
    required this.contenido}) : super(key: key);

  @override
  _ItemAjusteState createState() => _ItemAjusteState();
}

class _ItemAjusteState extends State<ItemAjuste> {
  @override
  Widget build(BuildContext context) {

    double ancho=MediaQuery.of(context).size.width;
    return
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(widget.titulo),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(widget.titulo),
                            content: Text(widget.contenido),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: widget.icono
                )
              ],



    );
  }
}
