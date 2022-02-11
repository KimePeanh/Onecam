import 'dart:convert';

import 'package:buymee/Auth/login.dart';
import 'package:buymee/Method/AllMethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String sex = "";
  String id = "";
  String verificationId = "";
  TextEditingController f_name = TextEditingController();
  TextEditingController l_name = TextEditingController();
  TextEditingController DOB = TextEditingController();
  TextEditingController phonee = TextEditingController();
  TextEditingController pwController = TextEditingController();
  var _firebaseInstance = FirebaseFirestore.instance;
  Method method = Method("signup");



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SafeArea(
                  child: Center(
                child: Container(
                  width: 150.w,
                  height: 150.h,
                  margin: EdgeInsets.only(top: 50.h),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              )),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: Text(
                  "What's Your Name ?",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              name(),
              SizedBox(
                height: 5.h,
              ),
              phoneInput(),
              SizedBox(
                height: 5.h,
              ),
              DOBInput(),
              SizedBox(
                height: 5.h,
              ),
              textpassword(),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 264.w,
                child: Text("Please use your real name to make it easier for next time to recognize you.",style: TextStyle(fontSize: 11,color: Colors.grey),textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 40.h,
              ),
              ButtonSex(),
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: InkWell(
                  child: Container(
                    width: 266.w,
                    height: 60.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(231, 11, 11, 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0, 2),
                          ),
                        ]),
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () async {
                    method.sendOTP(context,
                        phone: phonee.text,
                        fname: f_name.text,
                        lname: l_name.text,
                        pw: pwController.text,
                        sex: sex,
                        dob: DOB.text);
                  },
                ),
              ),
              SizedBox(height: 50.h,),
              InkWell(
                child: Text(
                  'Allready have an account',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }

  Widget phoneInput() {
    return Container(
        width: 390.w,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          controller: phonee,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your phone number",
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 13, horizontal: 15),
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  " +855 ",
                  style: TextStyle(fontSize: 16),
                ),
              )),
        ));
  }

  Widget name() {
    return Container(
      width: 390.w,
      height: 52.h,
      child: Row(
        children: <Widget>[
          Container(
              width: 191.w,
              height: 52.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.grey),
              ),
              child: TextFormField(
                controller: f_name,
                obscureText: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "First name",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                ),
              )),
          SizedBox(
            width: 8.w,
          ),
          Container(
              width: 191.w,
              height: 52.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.grey),
              ),
              child: TextFormField(
                controller: l_name,
                obscureText: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Last name",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                ),
              )),
        ],
      ),
    );
  }

  Widget DOBInput() {
    return Container(
        width: 390.w,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 340.w,
              child: TextFormField(
                controller: DOB,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "DD/MM/YY",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                ),
              ),
            ),
            Container(
              width: 30.w,
              height: 30.h,
              child: Image(
                image: AssetImage('assets/images/down.png'),
              ),
            ),
          ],
        ));
  }

  Widget ButtonSex() {
    return Container(
      width: 287.w,
      height: 49.h,
      child: Row(
        children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: 141.w,
              height: 49.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromRGBO(245, 97, 97, 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Text(
                'Female',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            onTap: () async {
              sex = "female";
            },
          ),
          SizedBox(
            width: 5.w,
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: 141.w,
              height: 49.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromRGBO(11, 143, 231, 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(0, 2),
                    ),
                  ]),
              child: Text(
                'Male',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
            onTap: () async {
              sex = "male";
            },
          ),
        ],
      ),
    );
  }

  Widget textpassword() {
    return Container(
        width: 390.w,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.grey),
        ),
        child: TextFormField(
          controller: pwController,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
            contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          ),
        ));
  }
}
