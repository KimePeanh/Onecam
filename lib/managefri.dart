import 'package:buymee/userpf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class managefri extends StatefulWidget {
  //const managefri({Key? key}) : super(key: key);
  final String phone;
  final String id;
  final String uid;
  const managefri(this.phone, this.id, this.uid);

  @override
  _managefriState createState() => _managefriState();
}

class _managefriState extends State<managefri> {
  final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var refri = [];
  var fri = [];
  var getrefri = [];
  var userfri = [];
  var myfri = [];
  var Test = [];
  var getFri = [];
  var getRefri = [];
  var newRefri = [];
  String id = "";
  String friid = "";

  void getreFriList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection('AllUsers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            refri = doc["reFri"];
            fri = doc["fri"];
            print("innnnnnnnnn");
            print(refri);
            print(fri);
            print(user.uid);
            print("innnnnnnnnn");
          });
        }
      });
    });
  }

  void showreFri() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        for (int i = 0; i < refri.length; i++) {
          if (refri[i] == doc['id']) {
            userfri.add({
              "url": doc['url'],
              "Username": doc['Username'],
              "Phonenumber": doc['Phonenumber'],
              "id": doc['id']
            });
            print(doc['id']);
          }
        }
      });
    });
  }

  void showFri() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        for (int i = 0; i < fri.length; i++) {
          if (fri[i] == doc['id']) {
            myfri.add({
              "url": doc['url'],
              "Username": doc['Username'],
              "Phonenumber": doc['Phonenumber']
            });
            print(myfri);
          }
        }
      });
    });
  }

  @override
  void initState() {
    getreFriList();
    showreFri();
    showFri();
    print(userfri.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: ScreenUtilInit(
          builder: () => Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(231, 11, 11, 1.0),
                  title: Text("Manage Friend List"),
                  centerTitle: true,
                  bottom: TabBar(tabs: [
                    Tab(
                      text: "Friend Request",
                    ),
                    Tab(
                      text: "Friend",
                    )
                  ]),
                ),
                body: TabBarView(children: [
                   ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: userfri.length,
                        itemBuilder: (context, index) {
                          return Container(
                            //color: Colors.white,
                            padding: EdgeInsets.only(top: 16),
                            child: Column(
                              children: [
                                Container(
                                  width: 400.w,
                                  height: 100.h,
                                  //padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    userfri[index]["url"]),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              userfri[index]["Username"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Profile(
                                                      userfri[index]
                                                          ["Username"],
                                                      userfri[index]["url"],
                                                      userfri[index]["id"],
                                                      widget.phone,
                                                      userfri[index]
                                                          ["Phonenumber"],
                                                      widget.id)));
                                        },
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Container(
                                        width: 80.w,
                                        height: 40,
                                        alignment: Alignment.center,
                                        //color: Color.fromRGBO(231, 11, 11, 1.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(66, 103, 178, 1.0),
                                        ),
                                        child: Text(
                                          "Confirm",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Container(
                                        width: 80.w,
                                        height: 40,
                                        alignment: Alignment.center,
                                        //color: Color.fromRGBO(231, 11, 11, 1.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(231, 11, 11, 1.0),
                                        ),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
               ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: myfri.length,
                        itemBuilder: (_, index) {
                          return Container(
                            //color: Colors.white,
                            padding: EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: 400.w,
                                  height: 70.h,
                                  padding: EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          backgroundImage:
                                              NetworkImage(myfri[index]["url"]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        myfri[index]["Username"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                ]),
              )));
}
