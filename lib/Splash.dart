import 'package:buymee/Auth/otp.dart';
import 'package:buymee/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth/Login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late final User user;
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    await Future.delayed(Duration(seconds: 2), () {});
    FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
      print(firebaseuser);
      if (firebaseuser == null) {     
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage('')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          width: 150,
          height: 150,
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}
