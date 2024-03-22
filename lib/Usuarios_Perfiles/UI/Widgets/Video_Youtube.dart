
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoYoutube extends StatefulWidget {

  final String idVideo;
  const VideoYoutube({Key? key,
    required this.idVideo,

  }) : super(key: key);

  @override
  _VideoYoutubeState createState() => _VideoYoutubeState();
}

class _VideoYoutubeState extends State<VideoYoutube> with AutomaticKeepAliveClientMixin  {

  bool silencio=true;
  bool play=true;
  int volumen=3;
  double _volume = 100;
  double duracion = 0;
  bool _isPlayerReady = false;
  late PlayerState _playerState;

  YoutubePlayerController controladorYoutube = YoutubePlayerController(
    initialVideoId: '',//'iLnmTe5Q2Qw',
  );

  void listener() {

      setState(() {
        _playerState = controladorYoutube.value.playerState;
        if(_playerState==PlayerState.playing)
          {
            play=true;
          }
        else if(_playerState==PlayerState.paused)
        {
          play=false;
        }
      });

  }


  @override
  void initState(){

    _playerState = PlayerState.unknown;
controladorYoutube= YoutubePlayerController(initialVideoId: widget.idVideo,

  flags:YoutubePlayerFlags(
autoPlay: false,
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
    controladorYoutube.dispose();
    print('dispose video');
  }

  @override
  Widget build(BuildContext context) {

    double ancho = MediaQuery
        .of(context)
        .size
        .width;
    double alto=MediaQuery.of(context).size.height;
    return    Container(
        color: Colors.black,
        height: alto*0.35,

        child:
                  Column(
                      children: [
                        Expanded(

                          child:

                          YoutubePlayer(
                            showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                              controller:  controladorYoutube,

                            onReady: () {
                              _isPlayerReady = true;
                              controladorYoutube.play();
                            },


                          ),
                        ),

                        Text( Duration( seconds: controladorYoutube.value.position.inSeconds) .toString().substring(0,7), style: TextStyle(color: Colors.white),),


                        ProgressBar(
                          controller: controladorYoutube,
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
                                   play? controladorYoutube.pause():controladorYoutube.play();
                                   play =!play;
                                  });
                                },
                                icon:play? Icon(Icons.pause, color: Colors.white,): Icon(Icons.play_arrow, color: Colors.white,)
                            ),
                            SizedBox(width: ancho*0.3,),


                          //  SizedBox(width: ancho*0.10,),


                            Expanded(
                              child: Slider(
                                inactiveColor: Colors.transparent,
                                value: _volume,
                                min: 0.0,
                                max: 100.0,
                                divisions: 100,
                                label: '${(_volume).round()}',activeColor: Colors.white,

                                onChanged: _isPlayerReady
                                    ? (value) {
                                  setState(() {
                                    _volume = value;
                                    if(_volume==0)
                                      {
                                        silencio=true;
                                      }
                                    else  if(_volume!=0)
                                    {
                                      silencio=false;
                                    }
                                  });
                                  controladorYoutube.setVolume(_volume.round());
                                }
                                    : null,

                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    silencio? controladorYoutube.unMute():controladorYoutube.mute();
                                    silencio=!silencio;
                                  });
                                },
                                icon:silencio? Icon(Icons.volume_off, color: Colors
                                    .white,) :  Icon(Icons.volume_down, color: Colors.white)
                            ),



                          ],
                        ),

                      ]
                  )
                  );
              }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
// bool get wantKeepAlive => throw UnimplementedError();
}




