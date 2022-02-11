import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  //const Profile({ Key? key }) : super(key: key);
  final String name;
  final String url;
  final String id;
  final String ph;
  final String uid;
  final String ouwidd;
  const Profile(this.name, this.url, this.id, this.ph, this.uid, this.ouwidd);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var reFri = [];
  var addfri = [];
  var fri = [];
  var kerefri = [];
  var kefri = [];
  var keaddfri = [];
  var _firebaseInstance = FirebaseFirestore.instance;
  String thisuid = "";
  String keuid = "";
  String pfuid = "";
  String ownid = "";
  String ownUid = "";
  String BTfri = "Add Friend";

  final User user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore fire = FirebaseFirestore.instance;

  void update() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(ownUid)
        .update({'addfri': addfri});
  }

  void keupdate() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(keuid)
        .update({'reFri': kerefri});
  }

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("AllUsers");

  void confirm() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(ownUid).update({
      'reFri': FieldValue.arrayRemove([widget.id])
    });
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(ownUid)
        .update({'fri': fri});
  }

  void KEconfirm() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(keuid).update({
      'addfri': FieldValue.arrayRemove([widget.ouwidd])
    });
    print(keuid + "bbbbbbbbbbbbbbbbbbbbbbbbbb");
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(keuid)
        .update({'fri': kefri});
    print(kefri);
  }
  // void keconfirm() async {
  //   QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
  //   FirebaseFirestore.instance.collection("AllUsers").doc(keuid).update({
  //     'addfri': FieldValue.arrayRemove([widget.ouwidd])
  //   });
  //   FirebaseFirestore.instance
  //       .collection("AllUsers")
  //       .doc(keuid)
  //       .update({'fri': kefri});
  // }

  void cancelRe() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(ownUid).update({
      'addfri': FieldValue.arrayRemove([widget.id])
    });
    FirebaseFirestore.instance.collection("AllUsers").doc(keuid).update({
      'reFri': FieldValue.arrayRemove([widget.ouwidd])
    });
  }

  void TransferOwnList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["Phonenumber"] == widget.ph) {
          addfri = doc["addfri"];
          fri = doc["fri"];
          reFri = doc["reFri"];
          ownid = doc["id"];
          ownUid = doc["uid"];
          print(ownUid + " MyUId");
        }
      });
    });
  }

  void friClick() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (BTfri == "Add Friend") {
          if (doc["Phonenumber"] == widget.ph) {
            print('trueeeeeeeeeeeeeeeeeeeeeeeeeeee');
            setState(() {
              addfri.add(widget.id);
              kerefri.add(ownid);
              BTfri = "Cancel request";
              update();
              keupdate();
            });
          }
        } else if (BTfri == "Cancel request") {
          if (doc["Phonenumber"] == widget.ph) {
            setState(() {
              cancelRe();
              BTfri = "Add Friend";
            });
          }
        } else if (BTfri == "Confirm") {
          if (doc["Phonenumber"] == widget.ph) {
            setState(() {
              fri.add(widget.id);
              kefri.add(widget.ouwidd);
              confirm();
              BTfri = "Friend";
              KEconfirm();
            });
          }
        }
      });
    });
  }

  void uid() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["Phonenumber"] == widget.uid) {
          setState(() {
            keuid = doc["uid"];
            kerefri = doc["reFri"];
            kefri = doc["fri"];
            keaddfri = doc["addfri"];
            print(widget.ouwidd);
            print(keuid);
            print("hoooooooooooooooooooooooo");
          });
        }
      });
    });
  }

  void addList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print('trueeeeeeeeeeeeeeeeeeeeeeeeeeee');
        if (doc["Phonenumber"] == widget.ph) {
          setState(() {
            addfri = doc["addfri"];
            reFri = doc["reFri"];
            fri = doc["fri"];
            print(addfri);
            print("ji");
            print(reFri);
          });
        }
        for (int i = 0; i < addfri.length; i++) {
          if (addfri[i].toString() == widget.id) {
            setState(() {
              BTfri = "Cancel request";
              print(BTfri);
            });
          }
        }
        for (int i = 0; i < reFri.length; i++) {
          if (reFri[i].toString() == widget.id) {
            setState(() {
              BTfri = "Confirm";
              print(BTfri);
            });
          }
        }
        for (int i = 0; i < fri.length; i++) {
          if (fri[i].toString() == widget.id) {
            setState(() {
              BTfri = "Friend";
              print(BTfri);
            });
          }
        }
      });
    });
  }

  void checklist() async {
    setState(() {
      for (int i = 0; i < reFri.length; i++) {
        if (reFri[i].toString() == widget.id.toString()) {
          BTfri = "Confirm";
        }
      }
      for (int i = 0; i < addfri.length; i++) {
        if (addfri[i].toString() == widget.id.toString()) {
          BTfri = "Cancel Request";
        }
      }
      for (int i = 0; i < fri.length; i++) {
        if (fri[i].toString() == widget.id.toString()) {
          BTfri = "Firend";
        }
      }
    });
  }

  @override
  void initState() {
    print("hiiifrist");
    TransferOwnList();
    uid();
    addList();
    //checklist();
    print(user.uid);
    print(widget.uid);
    print(widget.ouwidd);
    print(widget.id + "dddddddddddddddddddd");
    print(widget.ph);
    print('hidowww');
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
                    width: 428.w,
                    height: 119.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(231, 11, 11, 1.0),
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(15),
                        //     bottomRight: Radius.circular(15)),
                        ),
                    padding: EdgeInsets.only(left: 25.w),
                    child: InkWell(
                      child: Image(
                        width: 40,
                        height: 40,
                        image: AssetImage('assets/images/back.png'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Container(width: 143, height: 143, child: show()),
                ),
                SizedBox(height: 30.h),
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 354.w,
                  height: 50.h,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 164.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(66, 103, 178, 1.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: Offset(0, 2),
                                ),
                              ]),
                          child: Text(
                            BTfri,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          friClick();
                        },
                      ),
                      SizedBox(
                        width: 26.w,
                      ),
                      Container(
                        width: 164.w,
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(231, 11, 11, 1.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Text(
                          "History",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }

  Widget show() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 143,
            height: 143,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 80.0,
              backgroundImage: NetworkImage(widget.url),
            ),
          ),
        ],
      ),
    );
  }
}
