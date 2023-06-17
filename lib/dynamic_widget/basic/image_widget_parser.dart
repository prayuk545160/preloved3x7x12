 import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:io' as io;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../dynamic_widget.dart';
import '../../g.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
 import 'package:path/path.dart' as path;


class AssetImageWidgetParser extends WidgetParser {
  final List<String> dtag;
  AssetImageWidgetParser(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {


    m["skey"]= dtag[0];

    String name = m['name'];
    String semanticLabel =
    m.containsKey('semanticLabel') ? m['semanticLabel'] : null;
    bool excludeFromSemantics = m.containsKey('excludeFromSemantics')
        ? m['excludeFromSemantics']
        : false;
    double scale = m.containsKey("scale") ? m['scale'] : null;
    double width = m.containsKey('width') ? m['width'] : null;
    double height = m.containsKey('height') ? m['height'] : null;
    Color color = m.containsKey('color') ? parseHexColor(m['color']) : null;
    BlendMode blendMode =
    m.containsKey('blendMode') ? parseBlendMode(m['blendMode']) : null;
    BoxFit boxFit =
    m.containsKey('boxFit') ? parseBoxFit(m['boxFit']) : null;
    Alignment alignment = m.containsKey('alignment')
        ? parseAlignment(m['alignment'])
        : Alignment.center;
    ImageRepeat repeat = m.containsKey('repeat')
        ? parseImageRepeat(m['repeat'])
        : ImageRepeat.noRepeat;
    Rect centerSlice =
    m.containsKey('centerSlice') ? parseRect(m['centerSlice']) : null;
    bool matchTextDirection = m.containsKey('matchTextDirection')
        ? m['matchTextDirection']
        : false;
    bool gaplessPlayback =
    m.containsKey('gaplessPlayback') ? m['gaplessPlayback'] : false;
    FilterQuality filterQuality = m.containsKey('filterQuality')
        ? parseFilterQuality(m['filterQuality'])
        : FilterQuality.low;

    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";

    var widget = Image.asset(
      name,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
      fit: boxFit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return InkWell(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  String get widgetName => "AssetImage";
}

class NetworkImageWidgetParser extends WidgetParser {

  final List<String> dtag;
  NetworkImageWidgetParser(this.dtag);

  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    m["skey"]= dtag[0];
    return networkimage_ex(buildContext,m,listener);
  }

  @override
  String get widgetName => "NetworkImage";
}
 class img_parse extends WidgetParser {

   final List<String> dtag;
   img_parse(this.dtag);

   @override
   Widget parse(Map<String, dynamic> m, BuildContext buildContext,
       ClickListener listener) {

     m["skey"]= dtag[0];
     return networkimage_ex(buildContext,m,listener);
   }

   @override
   String get widgetName => "image";
 }
class networkimage_ex extends StatefulWidget {

  final  Map<String, dynamic> m;

  final ClickListener link_click;
  final BuildContext ctx;
  StreamController<String> eventx =null;
  networkimage_ex( this.ctx, this.m,this.link_click);


String edit_value="";

  String id() {
    return g.null2str(m["id"]);
  }
  String getcmd(){
    return g.null2str(m["click_event"]);
  }
  String setval(String val){
    try {
      edit_value = val;
      g.saveiform(m["skey"], val);
      eventx.add(val);
    }catch(e){}
  }

  @override
  networkimage_exState createState() => networkimage_exState(m);

}

class networkimage_exState  extends State<networkimage_ex> {

  final  Map<String, dynamic> m;


  String uitag;
  String skey;
  String id;
  String src;
  String error_img;
  List<String> a;
  Map<String, dynamic> h= new Map<String, dynamic>();
  int currentPage = 0;
  int img_width=600;
  int def_width=600;

  bool is_image=true;

  networkimage_exState(this.m);








  @override
  void initState() {
    super.initState();
    uitag=g.getuitag(m);


    skey=g.null2str(m["skey"]);
    id=g.null2str(m["id"]);
    src =g.null2str2(m['src'],g.null2str(m["src2"]));
    error_img=g.null2str(m["src2"]);

    if (m.containsKey("img_src")){
      src =g.null2str(m["img_src"]);
    }
    if (m.containsKey("img_arr")){
      src =g.null2str(m["img_arr"]).split(",").first;
      m['src']=src;
    }
    

    if(m.containsKey("img_width")){
      img_width=g.cint(m["img_width"].toString(),img_width);
    }


    if(g.null2str(m["auto_update"])=="true"){
      try{
        widget.eventx = new StreamController();
        widget.eventx.stream.listen((data) {
          setState(() {
            src=data;
          });
        });
      }catch(e){}
    }

    if(uitag=="cam"){
       g.cam_ctrl = CameraController(g.gcameras[0], ResolutionPreset.max);
       g.cam_ctrl.initialize().then((_) {
         if (!mounted) {
           return;
         }
         setState(() {});
       });
    }


  }
  error_ui  () {
    return CachedNetworkImage(imageUrl:error_img,fit:BoxFit.cover);
}

  @override
  void dispose() {
    try{
      if(widget.eventx!=null){
        widget.eventx.close(); //Streams must be closed when not needed
      }
    }catch(e){}

    if(uitag=="cam"){
      g.cam_ctrl?.dispose();
    }
    super.dispose();


  }


  @override
  Widget build(BuildContext context) {



    String sval="";
    String strui="";

    String semanticLabel =
    m.containsKey('semanticLabel') ? m['semanticLabel'] : null;
    bool excludeFromSemantics = m.containsKey('excludeFromSemantics')
        ? m['excludeFromSemantics']
        : false;
    double scale = m.containsKey("scale") ? m['scale'] : 1.0;
    double width = m.containsKey('width') ? m['width'] : null;
    double height = m.containsKey('height') ? m['height'] : null;
    Color color = m.containsKey('color') ? parseHexColor(m['color']) : null;
    BlendMode blendMode =
    m.containsKey('blendMode') ? parseBlendMode(m['blendMode']) : null;
    BoxFit boxFit =
    m.containsKey('boxFit') ? parseBoxFit(m['boxFit']) : BoxFit.cover;
    Alignment alignment = m.containsKey('alignment')
        ? parseAlignment(m['alignment'])
        : Alignment.center;
    ImageRepeat repeat = m.containsKey('repeat')
        ? parseImageRepeat(m['repeat'])
        : ImageRepeat.noRepeat;
    Rect centerSlice =
    m.containsKey('centerSlice') ? parseRect(m['centerSlice']) : null;
    bool matchTextDirection = m.containsKey('matchTextDirection')
        ? m['matchTextDirection']
        : false;
    bool gaplessPlayback =
    m.containsKey('gaplessPlayback') ? m['gaplessPlayback'] : false;
    FilterQuality filterQuality = m.containsKey('filterQuality')
        ? parseFilterQuality(m['filterQuality'])
        : FilterQuality.low;

    String clickEvent =
    m.containsKey("click_event") ? m['click_event'] : "";



double w;


if(m.containsKey("width_p")){
     w= MediaQuery.of(context).size.width*m["width_p"];
     m["width"]=w;
     img_width=w.toInt();
}
if(m.containsKey("width_d")){
       w= MediaQuery.of(context).size.width+m["width_d"];
       m["width"]=w;
       img_width=w.toInt();
}






if(m.containsKey("width")){
  w=g.get_width(m["width"]);
  img_width=w.toInt();
}
if(m.containsKey("height")){
  height=g.get_height(m["height"]);
}



if(m.containsKey("img_width")){
      img_width=m["img_width"];
}







    if(m.containsKey("error_img")){
      error_img=m["error_img"];
    }
    if(error_img==""){
      error_img=m["wait_img"];
    }
    if(error_img==""){
      error_img=g.nophoto_url;
    }

    var ui2;

    if(m.containsKey("selectval")){
      g.selectx(m["selectval"], m["skey"]);
      g.q.forEach((key, value) {
        src=value;
      });
    }




    if(g.isfoundfield(id)){
      src=g.getdatafield(id);
    }


    if(m.containsKey("null2hide")){
      if(g.null2str(m["null2hide"])==""){
        return  Container(width: 0,height: 0,);
      }
    }


    //gridid.rowindex.field

    if(m.containsKey("bind_data")){
      a=g.null2str(m["bind_data"]).split(".");
      //print("bind_data${a}");
      if(g.db.containsKey(a[0])){
        try {
          h = g.db[a[0]][g.cint(a[1],0)];
          sval =g.null2str(h[a[2]]);
          m["src"]=src.replaceAll("{v}",sval);
         // print("set_src_________${sval}");
        }catch(e){
          //g.tmsg("e.${e}");
        }
      }else{
        //print("not found db ${a[0]}");
      }
    }


    Color cr= Colors.transparent;

    if(m.containsKey("color")){
      cr=g.getcolor(g.null2str(m["color"]));
    }

    var placeholder;
    placeholder=Container();
    if(m.containsKey("wait_img")){
      placeholder= CachedNetworkImage(imageUrl: m["wait_img"]);
    }

    // photoview
    if(uitag=="photoview"){
      ui2=PhotoView(
        imageProvider: CachedNetworkImageProvider(src,maxWidth: img_width),
        backgroundDecoration: BoxDecoration(color: cr),
      );
    }
    else if(uitag=="zooom_image"){
      ui2=InteractiveViewer(
        child:CachedNetworkImage(
          fadeOutDuration:  const Duration(milliseconds: 0),
          fadeInDuration: const Duration(milliseconds: 0),
          memCacheWidth: img_width,
          placeholder: (context, url) =>placeholder,
          color: color,
          colorBlendMode: blendMode,
          fit: boxFit,
          alignment: alignment,
          imageUrl:  src,
          errorWidget: (context, url, error) =>error_ui(),
        )
      );
    }

    else if(uitag=="cam"){

      String sound_url="";

      if (!g.cam_ctrl.value.isInitialized) {
        ui2= Container();
      }else {
       ui2= Container(
            width: width,
            height: height,
            child: CameraPreview(g.cam_ctrl)
        );


       if(g.null2str(m["vdo_auto_save"])=="true"){
         int idelay=g.cint(g.cmdval("vdo_time"), 10);

         String sound_url=g.null2str(g.null2str(m["sound_url"]));

         Future.delayed(Duration(seconds: 1), ()  {
            g.cam_ctrl.startVideoRecording();


            if(sound_url!=""){
              g.play_sound2(sound_url);
            }

           Future.delayed(Duration(seconds: idelay), () {
             g.cam_ctrl.stopVideoRecording().then((XFile file)  async {


               final dir = await g.get_dir_download();
               final sfile = path.join(dir.path, "f_${g.get_datetime_id()}.mp4");
               g.moveFile(File(file.path),sfile);
               g.plink["vdo_file"]=sfile;
               g.select_file=sfile;

               if(sound_url!=""){
                 try {
                   gplayer.stop();
                 } catch (e) {}
               }
               if(g.cmdval("fn_click")!=""){
                 g.t_click=g.cmdval("fn_click");
               }



             });
           });
         });
       }



      }
    }


    // vdoimg
    else if(uitag=="vdoimg"){
      final fileName =  g.getvdoimg("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
      src=fileName;
      ui2=
          SizedBox(
              width: double.infinity,
              height: height,
              child: fileName
          );

    }

    else if(uitag=="IconButton"){
      ui2=IconButton(icon:  CachedNetworkImage(
        fadeOutDuration:  const Duration(milliseconds: 0),
        fadeInDuration: const Duration(milliseconds: 0),
        memCacheWidth: img_width,
        placeholder: (context, url) =>placeholder,
        color: color,
        colorBlendMode: blendMode,
        fit: boxFit,
        alignment: alignment,
        imageUrl:  src,
        errorWidget: (context, url, error) =>error_ui(),
      ),);
    }

      // qrcode
    else if(uitag=="qrcode"){
      double img_size=g.null2num(m["img_size"],320);
      ui2=QrImage(
        data: src,
        version: QrVersions.auto,
        size: img_size,
        gapless: false,
      );
    }
    // oimg
    else if(uitag=="oimg"){

      Color color =  Colors.transparent;
      Color border_color =  Colors.transparent;
      var border_width=null;
      if(m.containsKey("border_color")){
        border_color=g.getcolor(m["border_color"]);
      }
      if(m.containsKey("color")){
        color=g.getcolor(m["color"]);
      }
      if(m.containsKey("border_width")){
        border_width=Border.all(
          color: border_color,
          width: g.cdbl(g.null2str(m["border_width"]),4.0),
        );
      }


      if(src==""){
        src=g.null2str(m["nullimg"]);
      }
      var i_raduis=width/2;
      if(m.containsKey("oimg_radius")){
        i_raduis=m["oimg_radius"];
      }
      ui2=
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              image: DecorationImage(
                image: CachedNetworkImageProvider(src,maxWidth: img_width,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(i_raduis)),
              border: border_width,
            ),
          );

    }
    else {



      if(m["fsrc"]!=null){
        src=g.null2str(m["fsrc"]);
        ui2=
            SizedBox(
                width: g.get_mobilesize(width),
                height:g.get_mobilesize(height),
                child: Image.file(io.File(src),fit: BoxFit.fitWidth)
            );

      }else {


        if(m.containsKey("srcs")){


          String strui = '''

		  {
	  "type":"Row",
  	  "children":[
	  

		   {
             "type":"NetworkImage",
			 "uitag":"oimg",
             "id":"profile_img",
			  "width" :150.0,
		     "height":150.0,
			 "src":"https://cdn.cnn.com/cnnnext/dam/assets/160322105353-bugatti-chiron-next-fastest-car-orig-00001230-large-169.jpg",
			 "click_event":"callapi=social_quprofile;api_pr=uid[{fromu};callintent=p_page;nav_time=0;send_json=h;"
	 },
	 {
             "type":"NetworkImage",
			 "uitag":"oimg",
             "id":"profile_img",
			  "width" :150.0,
		     "height":150.0,
			 "src":"https://cdn.cnn.com/cnnnext/dam/assets/160322105353-bugatti-chiron-next-fastest-car-orig-00001230-large-169.jpg",
			 "click_event":"callapi=social_quprofile;api_pr=uid[{fromu};callintent=p_page;nav_time=0;send_json=h;"
	 },
	  {
             "type":"NetworkImage",
			 "uitag":"oimg",
             "id":"profile_img",
			  "width" :150.0,
		     "height":150.0,
			 "src":"https://cdn.cnn.com/cnnnext/dam/assets/160322105353-bugatti-chiron-next-fastest-car-orig-00001230-large-169.jpg",
			 "click_event":"callapi=social_quprofile;api_pr=uid[{fromu};callintent=p_page;nav_time=0;send_json=h;"
	 }
	 ]
	 }
	 
''';




          Widget ui;//=[DynamicWidgetBuilder.build(jsonDecode(strui),context,null,m["skey"])];
          List<String> arr=g.null2str(m["srcs"]).split(",");
          double  ih= ((arr.length/2).ceil())*height;
          int icol= (MediaQuery. of(context). size. width/width).ceil();
          ui=DynamicWidgetBuilder.buildFromMap(jsonDecode(strui), widget.ctx,widget.link_click);
         // print("xui="+ui.toString());
          ui2=ui;

        }else {
          if(m.containsKey("fill")){
            sval=g.null2str(m["fill"]);
            if(sval.contains("x")){
              width= double.maxFinite;
            }
            if(sval.contains("y")){
              height= double.maxFinite;
            }
          }


          String is_mutiple=g.null2str(m["mutiple"]);
          if(is_mutiple=="true"){

            List<String> a=g.null2str(m["src_file"]).split(",");


            String tval="";
            tval="ui_img${a.length}";
            if(g.json_ui_src[tval]==null){
              tval="ui_imgx";
            }
            if(m.containsKey("ui_img")){
              tval=m["ui_img"];
            }



          /*  if(a.length<=3){
              sval=g.read_json(g.json_ui_src,"ui_img${a.length}");
            }else {
              sval=g.read_json(g.json_ui_src,"ui_imgx");
            }*/

            sval=g.read_json(g.json_ui_src,tval);
            int l=0;
            a.forEach((str) {
              sval=sval.replaceAll("{d${l}}", str);
              sval=sval.replaceAll("{r${l}}", l.toString());
              l+=1;
            });
            sval=sval.replaceAll("{d}", m["src_file"]);
            ui2=DynamicWidgetBuilder.buildFromMap(jsonDecode(sval),  widget.ctx,widget.link_click);

/*

            strui="";
if(m["scroll"]=="h"){
              strui = '''
 {
	  "type":"PageView",
  	  "children":[
		  {*}

 ]}

''';
            } else {
              strui = '''
 {
	  "type":"Column",
	    "crossAxisAlignment":"start",
      "mainAxisAlignment":"start",
  	  "children":[
		  {*}

 ]}

''';
            }


            String tp_loop= "";

            tp_loop=json.encode(m);
            tp_loop=tp_loop.replaceAll("mutiple", "xmutiple")
                .replaceAll("fclick_event", "click_event");


            String s="";
            List<String> a=g.null2str(m["src_file"]).split(",");
            int max_photo=g.cint(m["max_item"],100);

            int  l=0;
            a.forEach((str) {
              s+=tp_loop.replaceAll("{src}",str).replaceAll("{img_rowindex}", "${l}")+",";
              l+=1;
            });
            s=g.rcut(s);

            */
/* int  l=0;
            for(l=0;l<a.length;l++){
              s+=tp_loop.replaceAll("{src}", a[l]).replaceAll("{img_rowindex}", "${l}")+",";
              l+=1;
              //   if(l>max_photo){
              //    break;
              // }
            }*//*





            if(m.containsKey("lui")){
              s= json.encode(m["lui"])+","+s;
            }
            if(m.containsKey("rui")){
              s+="," +json.encode(m["rui"]);
            }

            strui=strui.replaceAll("{*}", s);




            Widget allimg;

            allimg=DynamicWidgetBuilder.buildFromMap(jsonDecode(strui),  widget.oj_ctx,widget.link_click);





            */
/*a.forEach((tp_loop) {
              allimg.add(  SizedBox(
                  width: g.get_mobilesize(width),
                  height:g.get_mobilesize(height),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>placeholder,
                    color: color,
                    colorBlendMode: blendMode,
                    fit: boxFit,
                    alignment: alignment,
                    imageUrl: tp_loop,
                    errorWidget: (context, url, error) => Image.network(img_error),
                  )
              ));
            });*//*





            ui2=








                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    children:[
                      Container(
                          height: 300.0,
                          child:PageView(
                            onPageChanged: (index){
                              print("page change${index}");

                              currentPage=index;
                            },
                            scrollDirection: Axis.horizontal,
                            children: [allimg],
                          )),
                      Text("${currentPage+1}/max"),

                    ]);






*/



          }else {



            
            //maincase

            widget.edit_value=g.null2str(m["src"]);

            try{
            if(m.containsKey("img_split")){
              widget.edit_value=widget.edit_value.split(m["img_split"])[0];
            }}catch(e){}



            if( widget.edit_value==""){
              widget.edit_value=g.null2str(m["nullimg"]);
            }

            if(m.containsKey("bind_data")){
              a=g.null2str(m["bind_data"]).split(".");
              if(g.db.containsKey(a[0])){
                try {
                  h = g.db[a[0]][g.cint(a[1],0)];
                  sval =g.null2str(h[a[2]]);
                  m["src"]= widget.edit_value.replaceAll("{v}",sval);
                 // g.tmsg("img_val=${m["src"]}");
                }catch(e){}
              }
            }

            if(g.str_contrain( widget.edit_value, g.read_cfg("media_ext"))){
              if(m.containsKey("ui_player")){
                ui2=DynamicWidgetBuilder.buildFromMap(m["ui_player"],  widget.ctx,widget.link_click);
              }
              else {

                if(m.containsKey("file_media_ui")){
                  strui= g.read_json(g.json_ui,m["file_media_ui"]);
                }else {
                  strui= g.read_json(g.json_ui,"ui_media_player");
                }
                if(strui.contains('"main_click":false')){
                  is_image=false;
                }


                strui=strui.replaceAll("{src}",  widget.edit_value);
                ui2=DynamicWidgetBuilder.buildFromMap(jsonDecode(strui),  widget.ctx,widget.link_click);

              }
            }else {

              if(m.containsKey("color_filter")){
                    SizedBox(
                        width: g.get_mobilesize(width),
                        height:g.get_mobilesize(height),
                        child:
                        ColorFiltered(
                            child:
                          CachedNetworkImage(
                          fadeOutDuration:  const Duration(milliseconds: 0),
                          fadeInDuration: const Duration(milliseconds: 0),
                          maxWidthDiskCache: img_width,
                          placeholder: (context, url) =>placeholder,
                          color: color,
                          colorBlendMode: blendMode,
                          fit: boxFit,
                          alignment: alignment,
                          imageUrl:  widget.edit_value,
                          errorWidget: (context, url, error) => error_ui(),
                        ),
                       colorFilter: ColorFilter.mode(g.getcolor("color_filter"), BlendMode.color,
                      )
                    ));
              }else {
                ui2=
                    SizedBox(
                        width: g.get_mobilesize(width),
                        height:g.get_mobilesize(height),
                        child:
                        CachedNetworkImage(
                          fadeOutDuration:  const Duration(milliseconds: 0),
                          fadeInDuration: const Duration(milliseconds: 0),
                          maxWidthDiskCache: img_width,
                          placeholder: (context, url) =>placeholder,
                          color: color,
                          colorBlendMode: blendMode,
                          fit: boxFit,
                          alignment: alignment,
                          imageUrl:  widget.edit_value,
                          errorWidget: (context, url, error) => error_ui(),
                        )
                    );
              }

            }



          }

        }

      }
    }

    if(m["padding"]!=null){
      EdgeInsetsGeometry padding = parseEdgeInsetsGeometry(m['padding']);
      ui2=Padding(padding: padding,child: ui2);
    }

    if (widget.link_click != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.link_click.onClicked(clickEvent);
        },
        child:AbsorbPointer(
            absorbing: is_image,  //To disable from touch use false while **true** for otherwise
            child: ui2
        ),
      );
    }
    return ui2;
  }

}