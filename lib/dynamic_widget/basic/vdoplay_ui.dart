import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:fijkplayer/fijkplayer.dart';
import '../../dynamic_widget/basic/ui.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../dynamic_widget.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:flutter/material.dart';
import '../../g.dart';
import 'image_widget_parser.dart';



class vdoplayerParser extends WidgetParser {

  final List<String> dtag;
  vdoplayerParser(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {
    m["skey"]= dtag[0];
    return vdoplayer_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "vdo_player";
}


class vdoplayer_ex extends StatefulWidget {

  final BuildContext ctx;
  final  Map<String, dynamic> m;
  final ClickListener listener;



  vdoplayer_ex( this.ctx, this.m,this.listener);



  String id() {
    return g.null2str(m["id"]);
  }

  @override
  _vdoplayer_exState createState() => _vdoplayer_exState(m);

}

class _vdoplayer_exState  extends State<vdoplayer_ex> {

  final  Map<String, dynamic> m;
  _vdoplayer_exState(this.m);



  String url;
  String videoUrl='';
  bool is_run=false;
  bool isautoplay=false;

  Widget ui_preview=null;
  Widget ui;
  String clickEvent;
  bool req_run=false;
  bool click_play_vdo=false;
  bool show_cover=false;
  bool focus2play=false;
  bool isinit_player=false;
  int index_stack=0;
  var fit= FijkFit(
    sizeFactor: -0.5,
    aspectRatio: -1,
    alignment: Alignment.center,
  );
  double c_point=0.50;

  final FijkPlayer player = FijkPlayer();



  getboxfit(){
    switch(g.null2str("fit").toLowerCase()){
      case "cover":
        return FijkFit.cover;
        break;
      case "fill":
        return FijkFit.fill;
        break;
      case "fitwidth":
        return FijkFit.fitWidth;
        break;
      case "fitheight":
        return FijkFit.fitHeight;
        break;
      case "ar4_3":
        return FijkFit.ar4_3;
        break;
      case "ar16_9":
        return FijkFit.ar16_9;
        break;
      default:
        return  FijkFit(
          sizeFactor: -0.5,
          aspectRatio: -1,
          alignment: Alignment.center,
        );
        break;
    }

  }

  @override
  void initState() {


    url=g.null2str(m["url"]);
    if(g.null2str(m["autoplay"])=="true"){
      isautoplay=true;
    }
    if(m.containsKey("show_cover")){
      show_cover=m["show_cover"];
    }
    if(m.containsKey("focus2play")){
      focus2play=m["focus2play"];
    }
    if(m.containsKey("c_point")){
      c_point=m["c_point"];
    }


    fit=getboxfit();
    ui_preview = m['ui_preview'] == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(m['ui_preview'], widget.ctx, widget.listener);

    if(ui_preview==null){
      ui_preview=Container(child: Text("Previw"));
    }
    ui_preview=Expanded(child:ui_preview);




    g.player_url=url;



   // player.setLoop(0);

    /*  player.addListener(() {
      if(g.player_url!=url){
        try{
          if(player.state==FijkState.started){
            player.pause();
          }
        }catch(e){}
      }
    });*/

    loopx();
    clickEvent = m.containsKey("click_event") ? m['click_event'] : "";
    super.initState();


  }

/*  init_player(){
    player.setDataSource(url, autoPlay: isautoplay,showCover: show_cover);
  }*/

  loopx(){

    Future.delayed(Duration(milliseconds: 1000), () {
      if(g.player_url!=""){
        if(g.player_url!=url){
          try{
            if(player.state==FijkState.started){
              player.pause();
            }
          }catch(e){}
        }
      }
      loopx();
    });
  }


  @override
  void dispose() {
    super.dispose();
    try{
      player.release();
    }catch(e){}


  }

 pause_vdo(){
   /* if(player.state==FijkState.started){
      player.pause();
    }*/
  try{
    player.pause();
  }catch(e){}
 }


  click_playvdo(){


    if(g.player_url==url){
      if(player.isPlayable()){
        player.start();
      }
    }
    if(click_play_vdo){
      return;
    }
    try{
      click_play_vdo=true;
      setState(() {
        index_stack=1;
      });
      player.start();
      g.player_url=url;
      if (widget.listener != null && clickEvent != null) {
        widget.listener.onClicked(clickEvent);
      }

    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {

    player.setDataSource(url, autoPlay: isautoplay,showCover: show_cover);


    if(g.null2str(m["mode"])=="autoplay"){
      return FijkView(
        fit: fit,
        player: player,
      );
    }else {
      return

        VisibilityDetector(
            key: new PageStorageKey(url),
            onVisibilityChanged: (info) {
              if(focus2play){

                if(info.visibleFraction  >= c_point){
                  setState(() {
                    index_stack=1;
                  });
                  if(player.isPlayable()){
                    player.start();
                  }
                  click_playvdo();
                }else{
                  if(index_stack==1){
                    try{
                      if(g.player_url!=url){
                        pause_vdo();
                      }
                    }catch(e){}
                  }
                }

              }
            },
            child: IndexedStack(
                index: index_stack,
                children: <Widget>[
                    InkWell(
                        onTap: () {
                          setState(() {
                            index_stack=1;
                          });
                          click_playvdo();
                        },
                        child:
                             CachedNetworkImage(
                                width:double.maxFinite,
                                height:double.maxFinite,
                                fit: BoxFit.cover,
                                fadeOutDuration:  const Duration(milliseconds: 0),
                              fadeInDuration: const Duration(milliseconds: 0),
                              imageUrl:m["src"],
                            ),)
                  ,
                  FijkView(
                    fit: fit,
                    player: player,
                  ),

                ])
        );
    }





    /*


    if(g.null2str(m["mode"])=="autoplay"){
      return FijkView(
        fit: fit,
        player: player,
      );
    }
    else if(g.null2str(m["mode"])=="inline_play"){

    return
      VisibilityDetector(
          key: new PageStorageKey(url),
          onVisibilityChanged: (info) {

              if(info.visibleFraction  >= c_point){
                g.player_url = url;
                click_playvdo();
              }else{
                if(!show_wait_ui){
                  try{
                    if(g.player_url!=url){
                      pause_vdo();
                    }
                  }catch(e){}
                }
                click_play_vdo = false;
              }
          },
          child:
          FijkView(
            fit: fit,
            player: player,
          )
      );

    }

    else {

      return
        VisibilityDetector(
            key: new PageStorageKey(url),
            onVisibilityChanged: (info) {
              if(focus2play){

                if(info.visibleFraction  >= c_point){
                  setState(() {
                    show_wait_ui=false;
                  });
                  if(player.isPlayable()){
                    player.start();
                  }
                  click_playvdo();
                }else{
                  if(!show_wait_ui){
                    try{
                      if(g.player_url!=url){
                        pause_vdo();
                      }
                    }catch(e){}
                  }
                }

              }
            },
            child: Stack(
                children: <Widget>[
                  FijkView(
                    fit: fit,
                    player: player,
                  ),
                  InkWell(
                      onTap: () {
                        click_playvdo();
                      },
                      child: IgnorePointer(
                        ignoring: true,
                        child:
                        Visibility(
                          child: ui_preview,
                          visible: show_wait_ui,
                        )
                        ,
                      ))
                        ,
                ])
        );

    }*/

  }

}
class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
class VideoWidget extends StatefulWidget {
  final String url;
  final bool play;

  const VideoWidget({Key key, @required this.url, @required this.play})
      : super(key: key);
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    if (widget.play) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(VideoWidget oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VideoPlayer(_controller);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/*

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },

      builder: (BuildContext context, int index) {
        return Container(
                width: double.infinity,
                height: 300.0,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 50.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final InViewState inViewState =
                    InViewNotifierList.of(context);
                    inViewState.addContext(context: context, id: '$index');

                    return AnimatedBuilder(
                      animation: inViewState,
                      builder: (BuildContext context, Widget child) {
                        return VideoWidget(
                            play: inViewState.inView('$index'),
                            url:
                            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
                      },
                    );
                  },
                ),
              );
            },
          ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1.0,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}

*/

