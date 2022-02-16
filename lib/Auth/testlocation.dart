import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Testloca extends StatefulWidget {
  const Testloca({Key? key}) : super(key: key);

  @override
  _TestlocaState createState() => _TestlocaState();
}

class _TestlocaState extends State<Testloca> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.36179, 103.86056),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(11.5646058983, 104.913674593),
      //tilt: 59.440717697143555,

      zoom: 19);
  @override
  void initState() {
    // TODO: implement initState
    _goToTheLake();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 250,
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: (position) {
            double lat = position.target.latitude;
            double lng = position.target.longitude;
            print(lat);
          },
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    //controller.getLatLng();
  }
}
