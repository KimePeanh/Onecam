import 'package:buymee/Home.dart';
import 'package:buymee/Method/AllMethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class LoginOtp extends StatefulWidget {
  //const LoginOtp({Key? key}) : super(key: key);
  final state;
  final verID;
  final fname;
  final lname;
  final phone;
  final pw;
  final sex;
  final dob;

  LoginOtp(this.state, this.verID, this.fname, this.lname, this.phone, this.pw,
      this.sex, this.dob);

  @override
  _LoginOtpState createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Method method = Method("login");
  late User user;
  var fri = [];
  var reFri = [];
  var addfri = [];
  var _firebaseInstance = FirebaseFirestore.instance;
  String id = "";
  void getid() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    int n = qn.docs.length + 1;
    id = n.toString();
    print(id);
  }

  @override
  void initState() {
    getid();
    print(widget.state);
    print(widget.verID);
    super.initState();
  }

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
                    width: 150.w,
                    height: 150.h,
                    margin: EdgeInsets.only(top: 100.h),
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Container(
                  width: 358.w,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please confirm your Phone Vertification",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 358.w,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter your code here",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 60.h),
                otp(),
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
                      widget.state,
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }

  Widget otp() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 70,
      fieldWidth: 30.w,
      style: TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (pin) {
        print(pin);
      },
      onCompleted: (pin) async {
        print("Completed: " + pin);
        //method.loging(context, OTP: pin, verID: widget.verID);
        if (widget.state == "login") {
          method.loging(context, OTP: pin, verID: widget.verID);
        } else if (widget.state == "signup") {
          createaccount(context, OTP: pin);
        }
      },
    );
  }

  void createaccount(BuildContext context, {required String OTP}) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verID,
        smsCode: OTP,
      );
      final User user = (await _auth.signInWithCredential(credential)).user!;
      if (user.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('AllUsers')
            .doc(user.uid)
            .set({
              'id': id,
              'Username': widget.fname + " " + widget.lname,
              'Phonenumber': '+855' + widget.phone,
              'password': widget.pw,
              'date_bd': widget.dob,
              'sex': widget.sex,
              'email': "",
              'fri': fri,
              'addfri': addfri,
              'reFri': reFri,
              'uid': user.uid,
              'url':
                  'https://firebasestorage.googleapis.com/v0/b/protection-8ff5c.appspot.com/o/userr.png?alt=media&token=5c76162c-c2e0-41b9-975f-7846c8dd401d',
            })
            .then((value) => print('SSS'))
            .catchError((e) => print(e));
        user.updateDisplayName("+855" + widget.phone);
        user.updatePhotoURL(
            'https://firebasestorage.googleapis.com/v0/b/protection-8ff5c.appspot.com/o/userr.png?alt=media&token=5c76162c-c2e0-41b9-975f-7846c8dd401d');
        user.reload();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage('')));

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomeScreen(widget.phonenumberr)));
      }
    } catch (e) {
      print(e);
    }
  }
}
