import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart' as plline;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart' as gplace;
import 'package:intl/intl.dart';
import 'package:place_picker/uuid.dart';
import 'package:signature/signature.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../dynamic_widget.dart';
import '../../g.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../g.dart' as g;
import 'dart:io' as io;




import 'dart:convert';

import 'package:flutter/material.dart';
import '../../g.dart';
import 'package:uuid/uuid.dart' as vuuid;
import 'package:http/http.dart' as http;




import 'package:http/http.dart' as http;





class xParser extends WidgetParser {

  final List<String> dtag;
  xParser(this.dtag);


  @override
  Widget parse(Map<String, dynamic> m, BuildContext buildContext,
      ClickListener listener) {

    if(m["id"]==null){
      m["id"]=g.createid();
    }
    m["skey"]= dtag[0];
    if(!m["id"].toString().contains(".")){
      m["id"]=m["skey"]+"."+m["id"];
    }
    return xui_ex(buildContext,m,listener);

  }

  @override
  String get widgetName => "x";
}

class xui_ex extends StatefulWidget {

  final BuildContext ctx;
  final ClickListener listener;
  final  Map<String, dynamic> m;
  String cmdtag="";
  StreamController<String> eventx = null;


  xui_ex( this.ctx, this.m,this.listener);

  String id() {
    return g.null2str(m["id"]);
  }
  String get_uitag() {
    return g.null2str(m["ui"]);
  }
  String val(){
    return "";
  }
  String setval(String val){
    cmdtag="";

  }
  String setcmd(String val){
    cmdtag="cmd";

  }

  String add_event(String val){
    cmdtag="";
    try {
      if(eventx!=null){
        eventx.add(val);
      }
    }catch(e){}
  }


  @override
  _xui_exState createState() => _xui_exState(m);

}

class _xui_exState  extends State<xui_ex> {

  final  Map<String, dynamic> m;
  String skey;

  String id="";
  String sval="";
  _xui_exState(this.m);
  String clickEvent="";
  var ui;
  String uitag="";

  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(27.7089427, 85.3086209); //location to show in map


  plline.PolylinePoints polylinePoints = plline.PolylinePoints();
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);
  var ireq=0;
  final List<Marker> _markers = [];
  List<String> l;

  gplace.GooglePlace googlePlace;
  GoogleMapsPlaces gmapplace ;
  List<gplace.AutocompletePrediction> predictions = [];
  CameraPosition p;


  var txt_controller = TextEditingController();


  var uuid = new vuuid.Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
String search_status="";




  @override
  void initState() {



    txt_controller.addListener(() {
      _onChanged();
    });






    googlePlace = gplace.GooglePlace(g.google_apikey());
    gmapplace = GoogleMapsPlaces(apiKey: g.google_apikey());


    uitag=getuitag();
    skey =g.null2str(m["skey"]);
    id=g.null2str(m["id"]);
    if(m.containsKey("edit_value")){
      g.saveiform(id, g.null2str(m["edit_value"]));
    }
    clickEvent = m.containsKey("click_event") ? m['click_event'] : "";


    switch(uitag) {
      case "map_picker":
        //read_current_point();
         break;
      case "google_map2point":
        markers.add(Marker( //add start location marker
          markerId: MarkerId(startLocation.toString()),
          position: startLocation, //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Starting Point ',
            snippet: 'Start Marker',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));

        markers.add(Marker( //add distination location marker
          markerId: MarkerId(endLocation.toString()),
          position: endLocation, //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Destination Point ',
            snippet: 'Destination Marker',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));

        getDirections();
        break;
    }

    read_event();

    super.initState();


  }
  read_event(){
      widget.eventx = new StreamController();
      widget.eventx.stream.listen((data) async {

        l=data.split(",");
//g.tmsg("${l}");

switch(l[1]){

  case "move":
    try{

      if(l[2]=="x"){
        PlacesDetailsResponse detail =
        await gmapplace.getDetailsByPlaceId(g.p_point);
        double lat = detail.result.geometry.location.lat;
        double lng = detail.result.geometry.location.lng;
        g_location = LatLng(lat,lng);

        g.plink["this_lat"]=lat;
        g.plink["this_lon"]=lng;

       mapController.moveCamera(CameraUpdate.newLatLng(g_location));

      }else {
        mapController.moveCamera(CameraUpdate.newLatLng(LatLng(g.cdblx(l[2]), g.cdblx(l[3]))));
      }
    }catch(e){
      g.tmsg("move to error.${e}");
    }
    break;
}

       // g.tmsg("get event ${data}");


      });

  }





  add2point(){
    markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections();
  }

  String getuitag(){
    if(m.containsKey("ui")){
      return m["ui"].toString();
    }
    if(m.containsKey("uitag")){
      return m["uitag"].toString();
    }
    return "";
  }

  on_textchange(int ix,CameraPosition p){
    Future.delayed( Duration(milliseconds: 1000), () {
      if(ix==ireq){

      }
    });

  }

  read_posistion(int ix,CameraPosition px){
    p=px;
    Future.delayed( Duration(milliseconds: 1000), () {
      if(ix==ireq){
       // g.tmsg("${p.target.latitude} ${{p.target.longitude}} ");
        g.plink["this_lat"]=px.target.latitude;
        g.plink["this_lon"]=px.target.longitude;
        g.plink["map_address"]="";

         run_cmd();
      }
    });

  }


  void dispose() {
    if(widget.eventx!=null){
      widget.eventx.close();
    }
    super.dispose();
  }


  Set<Marker> getmarkers() { //markers to place on map

    if(mounted) {
      setState(() {
        markers.add(Marker( //add first marker
          markerId: MarkerId(showLocation.toString()),
          position: showLocation, //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Marker Title First ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));

        markers.add(Marker( //add second marker
          markerId: MarkerId(showLocation.toString()),
          position: LatLng(27.7099116, 85.3132343), //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Marker Title Second ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));

        markers.add(Marker( //add third marker
          markerId: MarkerId(showLocation.toString()),
          position: LatLng(27.7137735, 85.315626), //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Marker Title Third ',
            snippet: 'My Custom Subtitle',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));

        //add more markers here
      });
    }

    return markers;
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    plline.PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      g.google_apikey(),
      plline.PointLatLng(startLocation.latitude, startLocation.longitude),
      plline.PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: plline.TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((plline.PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }


  void autoCompleteSearch(String value) async {
    String lang=g.cstr(g.null2str(m["lang"]),"th");
    var result = await googlePlace.autocomplete.get(value,language:lang);

   // g.tmsg("r=${result.predictions.length}");
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions;
      });
    }
  }

  run_cmd(){
    if(m.containsKey("run_cmd")){
      g.run_cmd=m["run_cmd"];
    }
  }


  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(txt_controller.text);
  }

  void getSuggestion(String input) async {


    if(input!=""){
      setState(() {
        search_status="Search....";
      });
    }

    String kPLACES_API_KEY = google_apikey();
    String type = 'th';

    try{
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
            search_status="";
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
      // toastMessage('success');
    }

  }

  read_current_point() async {
 Future.delayed(Duration(milliseconds: 1000), () async {
   try{
     await g.read_gps();

     p=CameraPosition( //innital position in map
       target: my_location, //initial position
       zoom: g.cdbl(m["zoom"],13.0), //initial zoom level
     );
     mapController.moveCamera(CameraUpdate.newLatLng(my_location));
     g.plink["this_lat"]=my_location.latitude;
     g.plink["this_lon"]=my_location.longitude;


   }catch(e){}
 });




  }

  uisearch_place2(){
    return

      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              autofocus: true,
              controller: txt_controller,
              decoration: InputDecoration(
                hintText: "Seek your location here",
                focusColor: Colors.white,
                border: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel), onPressed: () {
                  txt_controller.clear() ;

                },
                ),
              ),
            ),
          ),
          Text(search_status),
          Container(
              child:
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    if(_placeList.length>0) {
                      try {
                        g.hide_keyboard();
                       // g.alert("p=${_placeList[index]}");
                        g.p_point = _placeList[index]["place_id"];
                        g.plink["map_address"] =
                        await _placeList[index]["description"];
                        run_cmd();

                      /*  Future.delayed(Duration(milliseconds: 100), () {
                          setState(() {
                            iheight = 0;
                            txt_controller.text="";
                          });

                        });*/


                      }catch(e){
                        g.tmsg("error${e}");
                      }


                    }

                  },
                  child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          ))
        ],
      );
  }

  uisearch_place(){
    return
      Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: txt_controller,
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(14.0),
                hintText: m.containsKey("hinttext")?m["hinttext"]:"Search...",
                focusColor: Colors.white,
                border: InputBorder.none,

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),

                floatingLabelBehavior: FloatingLabelBehavior.never,

                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed:(){
                    Navigator.pop(g.ctx());

                  } ,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed:(){

                    txt_controller.clear();
                    g.hide_keyboard();
                    setState(() {
                      predictions = [];

                    });
                  } ,
                ),
              ),
              onChanged: (value) {

             if (value.isNotEmpty) {


                  autoCompleteSearch(value);

                } else {
                  if (predictions.length > 0 && mounted) {

                    setState(() {
                      predictions = [];
                    });
                  }
                }
              },
            ),
                Expanded(
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(predictions[index].description),
                        onTap: () async {

                          if(predictions.length>0) {

                            g.plink["map_address"] = predictions[index].description;
                            g.p_point = predictions[index].placeId;
                            g.hide_keyboard();
                            run_cmd();



                          }

                        },
                      );
                    },
                  ),
                ),
          ]
      );
  }

  ui_google_map(){
    return
      Stack(
          alignment: Alignment.topCenter,
          children: [

            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: startLocation,
                  zoom: 14),
              myLocationEnabled: true,
              markers: _markers.toSet(),
              onMapCreated: (controller) {
                final marker = Marker(
                  visible: false,
                  markerId: MarkerId('0'),
                  onDragEnd: ((p) {
                    //tmsg("${p.latitude}  ${p.longitude}");
                  }),
                  position: startLocation,
                );
                _markers.add(marker);
                if(mounted){
                  setState(() {
                    mapController = controller;
                  });
                }

              },

              onCameraMove: (px) {
                ireq+=1;
                read_posistion(ireq,px);
                if(mounted){
                  setState(() {
                    _markers.first =
                        _markers.first.copyWith(positionParam: px.target);
                  });
                }

              },
            ),
            Center(child:
            Container(width: 40.0,height: 40.0,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 45),
                child:CachedNetworkImage(
                  maxWidthDiskCache:100,
                  imageUrl: g.url_pin,))),


          ]);
  }

  @override
  Widget build(BuildContext context) {


    switch(uitag){
      case "map":
          ui=  GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true, //enable Zoom in, out on map
              initialCameraPosition: CameraPosition( //innital position in map
                target: showLocation, //initial position
                zoom: g.cdbl(m["zoom"],13.0), //initial zoom level
              ),
              markers: getmarkers(), //markers to show on map
              mapType: MapType.normal,
              myLocationEnabled: true,
              onMapCreated: (controller) { //method called when map is created
                if(mounted) {
                  setState(() {
                    mapController = controller;
                  });
                }
              },
              onCameraMove: (p) {

              }
            );
        break;
      case "map2point":
        ui=GoogleMap( //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition( //innital position in map
            target: startLocation, //initial position
            zoom: g.cdbl(m["zoom"],13.0), //initial zoom level
          ),
          markers: markers, //markers to show on map
          polylines: Set<Polyline>.of(polylines.values), //polylines
          mapType: MapType.normal, //map type
          onMapCreated: (controller) { //method called when map is created
            if(mounted) {
              setState(() {
                mapController = controller;
              });
            }
          },
        );
        break;
      case "getmap":

        ui=
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: startLocation,
                  zoom: 14),


              markers: _markers.toSet(),
              myLocationEnabled: true,
              onMapCreated: (controller) {
                final marker = Marker(
                  visible: false,
                  markerId: MarkerId('0'),
                  onDragEnd: ((p) {
                    //tmsg("${p.latitude}  ${p.longitude}");
                  }),
                  position: startLocation,
                );
                _markers.add(marker);
                if(mounted){
                  setState(() {
                    mapController = controller;
                  });
                }

              },

              onCameraMove: (p) {
                ireq+=1;
                read_posistion(ireq,p);
                if(mounted){
                  setState(() {
                    _markers.first =
                        _markers.first.copyWith(positionParam: p.target);
                  });
                }

              },
            );

        break;


      case "search_place":
       ui=uisearch_place();
        break;

      case "search_place2":
        ui=uisearch_place2();
        break;
      case "map_picker":
        ui= ui_google_map();


          break;





    }






    if (clickEvent != "") {
      return InkWell(
        onTap: () {
          widget.listener.onClicked(clickEvent);
        },
        child: AbsorbPointer(
            absorbing: true,  //To disable from touch use false while **true** for otherwise
            child: ui
        ),
      );
    } else {
      return ui;
    }

  }
}
