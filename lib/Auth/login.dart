import 'package:buymee/Auth/Signup.dart';
import 'package:buymee/Method/AllMethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  String verificationId = "";
  Method method = Method("login");
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SafeArea(
                  child: Container(
                    width: 301.w,
                    height: 179.h,
                    margin: EdgeInsets.only(top: 40.h),
                    child: Image(
                      image: AssetImage("assets/images/log.png"),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 373.w,
                    child: Text(
                      'Welcom to ONE CAM EMERGENCY...!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(231, 11, 11, 1.0)),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 373.w,
                    child: Text(
                      'Please Sign in or Sign up to Continue',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                PhonenumberInput(),
                SizedBox(
                  height: 7.h,
                ),
                PasswordInput(),
                Container(
                  width: 390.w,
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 70.h,
                ),
                InkWell(
                  child: Container(
                    width: 266.w,
                    height: 52.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(231, 11, 11, 1.0),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () async {
                    FirebaseFirestore.instance
                        .collection('AllUsers')
                        .get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) async {
                        if (doc["Phonenumber"] == "+855" + PhoneController.text &&
                            doc["password"] == PasswordController.text) {
                          method.sendOTP(context,
                              phone: PhoneController.text,
                              fname: "fname",
                              lname: "lname",
                              pw: "pw",
                              sex: "sex",
                              dob: "dob");
                        } else {
                          // print("failllllllllllllllll");
                          // Fluttertoast.showToast(msg: "Failll");
                        }
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  //width: 300.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 1,
                        color: Colors.grey,
                        width: 70.w,
                      ),
                      Text(' Sign up with ',
                          style: TextStyle(fontSize: 15, color: Colors.grey)),
                      Container(
                        height: 1,
                        color: Colors.grey,
                        width: 70.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Signupp(),
                SizedBox(
                  height: 80.h,
                ),
                InkWell(
                  child: Text(
                    "Don't have an account? Signup",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }

  Widget PhonenumberInput() {
    return Container(
      width: 390.w,
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: PhoneController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone number",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            child: Text(
              "+855",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }

  Widget PasswordInput() {
    return Container(
      width: 390.w,
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: PasswordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: false,
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
        ),
      ),
    );
  }

  Widget Signupp() {
    return Container(
      width: 370.w,
      height: 41.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 14.w),
            width: 75.w,
            height: 41.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 30.h,
                  child: Image(
                    image: AssetImage("assets/images/fb.png"),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            margin: EdgeInsets.only(right: 14.w),
            width: 75.w,
            height: 41.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 30.h,
                  child: Image(
                    image: AssetImage("assets/images/google.png"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            margin: EdgeInsets.only(right: 14.w),
            width: 75.w,
            height: 41.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(0, 2),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 30.h,
                  child: Image(
                    image: AssetImage("assets/images/twitter.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
