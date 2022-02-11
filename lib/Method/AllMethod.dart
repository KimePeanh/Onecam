import 'package:buymee/Auth/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Home.dart';

class Method {
  final String set;
  Method(this.set);

  void sendOTP(BuildContext context,
      {required String phone,
      required String fname,
      required String lname,
      required String pw,
      required String sex,
      required String dob}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: '+855' + phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          SnackBar(
            content: Text('Hi'),
            duration: const Duration(milliseconds: 2000),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          Navigator.pop(context);
          SnackBar(
            content: Text('Fail'),
            duration: const Duration(milliseconds: 2000),
          );
        },
        codeSent: (String verification, int? resendToken) async {
          String verificationId = verification;
          if (set == "login") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginOtp("login", verification,
                        "fname", "lname", phone, "pw", "sex", "dob")));
          } else if (set == "signup") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginOtp("signup", verification,
                        fname, lname, phone, pw, sex, dob)));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Navigator.pop(context);
        });
  }

  void loging(BuildContext context,
      {required String OTP, required String verID}) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: OTP,
      );
      FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = (await _auth.signInWithCredential(credential)).user!;
      if (user.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage('')));
      }
    } catch (e) {
      print(e);
    }
  }
}
