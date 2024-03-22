
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:intl/intl.dart';



class VideoYoutubeUsuario extends StatefulWidget {

  final String urlYoutube;
  final   YoutubePlayerController controladorYoutube;
  const VideoYoutubeUsuario
      ({Key? key,
    required this.controladorYoutube, required this.urlYoutube,

  }) : super(key: key);

  @override
  _VideoYoutubeUsuarioState createState() => _VideoYoutubeUsuarioState();
}

class _VideoYoutubeUsuarioState extends State<VideoYoutubeUsuario> with AutomaticKeepAliveClientMixin  {

  bool silencio=true;
  bool play=true;
  double volumen = 100;
  bool estaListo = false;

  YoutubePlayerController controladorYoutubeUsuario=YoutubePlayerController(initialVideoId:'');
  late PlayerState estado;

  void listener() {
    setState(() {
      estado = controladorYoutubeUsuario.value.playerState;
      if(estado==PlayerState.playing)
      {
        play=true;
      }
      else if(estado==PlayerState.paused)
      {
        play=false;
      }
    }
    );
    // }
  }
  @override
  void initState(){

    controladorYoutubeUsuario=YoutubePlayerController(
      initialVideoId: widget.controladorYoutube.initialVideoId,
      flags:YoutubePlayerFlags(
          hideControls: true,
          mute:silencio,
          loop: true
      ),
    )..addListener(listener);

    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    controladorYoutubeUsuario.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto=MediaQuery.of(context).size.height;
    return    Column(
      children: [
        Container(
          width: ancho,
          child: ElevatedButton(

            onPressed: (){
              if (widget.urlYoutube.isNotEmpty) {
                var id = YoutubePlayer.convertUrlToId(
                    widget.urlYoutube
                ) ??
                    '';
                setState(() {
                  controladorYoutubeUsuario.load(id);
                }
                );
              }
            },
            child: Text('Comprobar Video'),
          ),
        ),
        Container(
            color: Colors.black,
            height: alto*0.4,
            child:
            Column(
                children: [
                  Expanded(
                    child:
                    YoutubePlayer(
                      controller:  controladorYoutubeUsuario,
                      onReady: () {
                        estaListo = true;
                      },
                    ),
                  ),

                  Text(
                    Duration(
                        seconds: controladorYoutubeUsuario.value.position.inSeconds) .
                    toString().substring(0,7),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  ProgressBar(
                    controller:controladorYoutubeUsuario,
                    colors: ProgressBarColors(
                        playedColor: Colors.green,
                        backgroundColor: Colors.black12,
                        handleColor: Colors.green
                    ),
                    isExpanded: false,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              play? controladorYoutubeUsuario.pause():
                              controladorYoutubeUsuario.play();
                              play =!play;
                            }
                            );
                          },
                          icon:play? Icon(
                            Icons.pause,
                            color: Colors.white,):
                          Icon(Icons.play_arrow,
                            color: Colors.white,)
                      ),
                      SizedBox(width: ancho*0.3,),

                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: volumen,
                          min: 0.0,
                          max: 100.0,
                          divisions: 100,
                          label: '${(volumen).round()}',activeColor: Colors.white,
                          onChanged: estaListo
                              ? (value) {
                            setState(() {
                              volumen = value;
                              if(volumen==0)
                              {
                                silencio=true;
                              }
                              else  if(volumen!=0)
                              {
                                silencio=false;
                              }
                            }
                            );
                            controladorYoutubeUsuario.setVolume(volumen.round());
                          }
                              : null,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              silencio? controladorYoutubeUsuario.unMute():
                              controladorYoutubeUsuario.mute();
                              silencio=!silencio;
                            }
                            );
                          },
                          icon:silencio? Icon(
                            Icons.volume_off,
                            color: Colors
                                .white,) :  Icon(
                              Icons.volume_down,
                              color: Colors.white)
                      ),
                    ],
                  ),
                ]
            )
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
