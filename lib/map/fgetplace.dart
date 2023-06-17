import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../g.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getplace(),
    );
  }
}

class getplace extends StatefulWidget{
  @override
  _getplaceState createState() => _getplaceState();
}

class _getplaceState extends State<getplace> {



  GoogleMapController mapController; //contrller for Google map
  CameraPosition cameraPosition;
  LatLng startLocation = my_location;
  String location = "Search Location";
  final List<Marker> _markers = [];

  int ireq=0;



  read_posistion(int ix,CameraPosition p){
      Future.delayed( Duration(milliseconds: 1000), () {
            if(ix==ireq){
                 tmsg("${p.target.latitude} ${{p.target.longitude}} ");
            }
      });

    }

  @override
  Widget build(BuildContext context) {



    return SafeArea(child:
    Stack(
      children: [


        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 14),


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
          },

          onCameraMove: (p) {
            ireq+=1;
            read_posistion(ireq,p);
            setState(() {
              _markers.first =
                  _markers.first.copyWith(positionParam: p.target);
            });
          },
        ),
        Center(child:
        Container(width: 40.0,height: 40.0,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 45),
            child:CachedNetworkImage(
              maxWidthDiskCache:100,
              imageUrl: url_pin,))),


        Positioned(  //widget to display location name
            top:10,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                child: Container(
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width - 40,
                    child: ListTile(
                      leading: Image.asset("images/pin.png", width: 25,),
                      title:Text(location, style: TextStyle(fontSize: 18),),
                      dense: true,
                    )
                ),
              ),
            )
        )

      ],
    ));
  }




}