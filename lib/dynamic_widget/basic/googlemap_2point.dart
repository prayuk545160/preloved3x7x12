import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../g.dart';
class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key key}) : super(key: key);
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}
class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static  LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static  LatLng destination = LatLng(37.33429383, -122.06600055);




  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_apikey(), // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),

    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }


  LocationData currentLocation;


  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newLoc) {

        currentLocation = newLoc;
        setState(() {

          sourceLocation=LatLng(
            newLoc.latitude,
            newLoc.longitude,
          );
        });

       googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
            ),
          ),
        );



        setState(() {});
      },
    );
  }


  /*
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {

            setState(() {
              currentLocation=newLoc;
            });
        // setState(() {
        //   currentLocation=LatLng(newLoc.latitude, newLoc.longitude);
        // });


       *//* googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 12.5,
              target: LatLng(
                newLoc.latitude,
                newLoc.longitude,
              ),
            ),
          ),
        );
        *//*

        setState(() {});
      },
    );
  }
*/

  @override
  void initState() {
   getPolyPoints();
   getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return

      Scaffold(
        body:
        currentLocation == null
            ? const Center(child: Text("Loading"))
            : GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
                currentLocation.latitude, currentLocation.longitude),
            zoom: 13.5,
          ),
          markers: {

             Marker(
              markerId: MarkerId("source"),
              position: sourceLocation,
            ),
             Marker(
              markerId: MarkerId("destination"),
              position: destination,
            ),
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId("route"),
              points: polylineCoordinates,
              color: const Color(0xFF7B61FF),
              width: 6,
            ),
          },
        ));
  }
}