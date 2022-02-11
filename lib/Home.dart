import 'dart:io';
import 'package:buymee/Auth/ownpro.dart';
import 'package:buymee/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'Auth/Login.dart';
import 'managefri.dart';

class Homepage extends StatefulWidget {
  //const Homepage({Key? key}) : super(key: key);
  final String PhoneNumber;
  const Homepage(this.PhoneNumber);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController search = TextEditingController();
  List<String> imagelist = [];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var dotpisition = 0;
  List product = [];
  int _index = 0;
  String Itemurl = " ";
  int _dataLength = 1;
  var _firebaseInstance = FirebaseFirestore.instance;
  String Newname = "";
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String url = "";
  String uil = "";
  String newUid = "";
  String phonenum = "";
  String username = "";
  String id = "";
  late final User user;
  late final DocumentSnapshot userdata;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["uid"] == uid) {
          setState(() {
            newUid = uid;
            username = doc["Username"];
            url = doc["url"];
            phonenum = doc["Phonenumber"];
            id = doc["id"];
            print(id);
            print(url);
          });
        }
      });
    });

    //print(uemail);
  }

  @override
  void initState() {
    // TODO: implement initState
    // _initUser();
    getCurrentUser();

    print(id + "ddddddddddddddddddddddddddddddddddddddd");
    print(username);
    super.initState();
  }

  int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    FirebaseStorage storage = FirebaseStorage.instance;
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 27) / 2.8;
    final double itemWidth = size.width / 2;
    return ScreenUtilInit(
      builder: () => Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        drawer: newMenu(context),
        body: Column(
          children: <Widget>[
            Container(
              width: 428.w,
              height: 186.h,
              padding: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: Color.fromRGBO(231, 11, 11, 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 80.w,
                    height: 186.h,
                    //color: Colors.amber,
                    padding: EdgeInsets.only(left: 15.w),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        child: Image(
                          image: AssetImage('assets/images/menu.png'),
                        ),
                      ),
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 224.h,
                    alignment: Alignment.centerRight,
                    child: Text(
                      username,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 90.w,
                    height: 186.h,
                    //color: Colors.white,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 15.w),
                    child: Container(width: 60, height: 60, child: show()),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 83.h,
            ),
            Container(
              width: 368.w,
              height: 153.h,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 180.w,
                    height: 155.h,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bpolice.png'),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    width: 180.w,
                    height: 155.h,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bff.png'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            Container(
              width: 368.w,
              height: 153.h,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 180.w,
                    height: 155.h,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bHos.png'),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    width: 180.w,
                    height: 155.h,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/bfri.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: 428.w,
          height: 172.h,
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/sos.png'),
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }

  Widget newMenu(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 317.w,
            height: 193.h,
            padding: EdgeInsets.only(top: 20.h),
            color: Color.fromRGBO(231, 11, 11, 1.0),
            child: Row(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: 100.w,
                      height: 190.h,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10.w),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: profile(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 150.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(username,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              phonenum,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 317.w,
            height: 1.h,
            color: Colors.white,
          ),
          Container(
              width: 317.w,
              height: 732.h,
              color: Color.fromRGBO(231, 11, 11, 1.0),
              padding: EdgeInsets.only(left: 20.w, top: 10.h),
              child: Column(children: <Widget>[
                Row(children: [
                  IconButton(
                      onPressed: () {
                        iamgepicker();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  ),
                ]),
                Row(children: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.lock,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Change password',
                    style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  ),
                ]),
                InkWell(
                  child: Row(children: [
                    IconButton(
                        onPressed: () {
                          Search();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.search,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(fontSize: 17.sp, color: Colors.white),
                    ),
                  ]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen(phonenum, id)));
                  },
                ),
                Row(children: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.star,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Feedback',
                    style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  ),
                ]),
                InkWell(
                  child: Row(children: [
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.userFriends,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      'Manage FriendList',
                      style: TextStyle(fontSize: 17.sp, color: Colors.white),
                    ),
                  ]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                managefri(phonenum, id, newUid)));
                  },
                ),
                Row(children: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.cog,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  ),
                ]),
                Row(children: [
                  IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((onValue) {
                          Fluttertoast.showToast(msg: "Logout");
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  ),
                ]),
              ])),
        ],
      ),
    );
  }

  Widget show() {
    return Center(
      child: InkWell(
        child: Stack(
          children: <Widget>[
            image == null
                ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 80.0,
                    backgroundImage: NetworkImage(url),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 80.0,
                    //backgroundImage: FileImage(File(image!.path)),
                    backgroundImage: FileImage(File(image!.path)),
                  ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UserProfile(username, id, phonenum, newUid, url)));
        },
      ),
    );
  }

  Widget profile() {
    return Center(
      child: Stack(
        children: <Widget>[
          image == null
              ? CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80.0,
                  backgroundImage: NetworkImage(url),
                )
              : CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80.0,
                  //backgroundImage: FileImage(File(image!.path)),
                  backgroundImage: FileImage(File(image!.path)),
                ),
          Positioned(
            bottom: 0.1,
            right: 0.1,
            child: InkWell(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 25,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (builder) => botton());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget botton() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              InkWell(
                child: Icon(
                  Icons.camera_alt,
                ),
                onTap: () {},
              ),
              InkWell(
                child: Icon(
                  Icons.image,
                ),
                onTap: () {
                  iamgepicker();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void iamgepicker() async {
    final XFile? Selectimage =
        await _picker.pickImage(source: ImageSource.gallery);
    print(Selectimage!.path);
    setState(() {
      image = Selectimage;
    });
  }

  Widget Search() {
    return SafeArea(
      child: Container(
        width: 428.w,
        height: 926.h,
        child: Column(
          children: <Widget>[
            Container(
              width: 428.w,
              height: 186.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                      width: 40,
                      height: 40,
                      image: AssetImage('assets/images/arrow.png')),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    width: 266.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Image(image: AssetImage('assets/images/search.png')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
