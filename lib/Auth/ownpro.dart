import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlng/latlng.dart';
import 'package:geolocator/geolocator.dart';

class UserProfile extends StatefulWidget {
  final String name;
  final String id;
  final String phone;
  final String uid;
  final String url;
  const UserProfile(this.name, this.id, this.phone, this.uid, this.url);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var location = [];
  var Helplocation = [];
  var _firebaseInstance = FirebaseFirestore.instance;
  Position? _position;
  String? _currentlocation;
  bool isLoading = false;
  double? lat;
  double? lng;
  Set<Marker> _marker = {};
  void eytt() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    Helplocation.add(position.latitude as double);
    Helplocation.add(position.longitude as double);
    print(Helplocation);
  }
  

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getposition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Noooooooo");
      }
    } else {
      print("Location not found");
    }
    return await Geolocator.getCurrentPosition();
  }

  void createmap(GoogleMapController controller) {
    // setState(() {
    //   print(lat);
    //   // _marker.add(
    //   //   Marker(
    //   //       markerId: MarkerId('id-1'),
    //   //       position: LatLng(lat, lng),
    //   //       infoWindow: InfoWindow(
    //   //         title: 'kime',
    //   //       )),
    //   // );
    // });
  }

  // void ll() async {
  //   Position position = await getposition();
  //   setState(() {
  //     lat = position.latitude;
  //     lng = position.longitude;
  //     print(lat);
  //     print(lng);
  //   });
  // }

  void btclick() async {
    setState(() {
      if (bt == "My Location") {
        setState(() {
          //location.add()
          eytt();
          getLocation();
          print("Help locationnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
          print(Helplocation);
          print(Helplocation[0]);
        });
        setState(() {
          bt = "Help";
          print(bt);
        });
      } else if (bt == "Help") {
        setState(() {
          bt = "Stop";
        });
      } else {
        setState(() {
          bt = "My Location";
          print(bt);
        });
      }
    });
  }

  String bt = "My Location";
  late GoogleMapController mapController;
  //LatLng location = LatLng(35.68, 51.41);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getLocation() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["Phonenumber"] == widget.phone) {
          setState(() {
            location = doc["location"];
            //Helplocation = location;
            print("Here location");
            print(location);
            if (Helplocation.isEmpty) {
              setState(() {
                print("Help empty");
                print(location[0] as double);
                lat = location[0] as double;
                lng = location[1] as double;
                print("LAt afert location[0");
                print(lat);
                print(lng);
                print("LAt afert location[0");
              });
            } else {
              setState(() {
                print("Noooooooooooooo");
                lat = Helplocation[0] as double;
                lng = Helplocation[1] as double;
              });
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    //_getCurrentLocation();
    print(widget.phone);
    //ll();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng _center = LatLng(lat!, lng!);
    print("Lat in wedgit");
    print(lat);
    return ScreenUtilInit(
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(231, 11, 11, 1.0),
          leading: new IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(widget.name),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30.h),
                  width: 130.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(widget.url),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                width: 428.w,
                height: 51.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(11, 143, 231, 1.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      child: Text(
                        "Friend",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    // if (_currentPosition != null)
                    //   Text(
                    //       "LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}"),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 150.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(231, 11, 11, 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Text(
                          "History",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () async {
                        eytt();
                        // setState(() {
                        //   isLoading = true;
                        // });
                        // _position = await _determinePosition();
                        // print(_position!.accuracy);
                      },
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    Image(
                        width: 30,
                        height: 30,
                        image: AssetImage("assets/images/mor.png")),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (_currentlocation != null)
                Container(
                    width: 350.w,
                    child: Text(
                      "Location : $_currentlocation",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: 428.w,
                    height: 430.h,
                    color: Colors.amber,
                    child: GoogleMap(
                      //onMapCreated: GoogleMapController(),
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 15.0,
                      ),
                    ),
                  ),
                  Center(
                    child: InkWell(
                      child: Container(
                        width: 300.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 370.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(231, 11, 11, 1.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Text(
                          bt,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      onTap: () async {
                        setState(() {
                          btclick();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }
}
