import 'package:buymee/userpf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  //const SearchScreen({Key? key}) : super(key: key);
  final String phone;
  final String ownid;
  const SearchScreen(this.phone, this.ownid);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final User use = FirebaseAuth.instance.currentUser!;
  String name = "";
  String uid = "";
  TextEditingController search = TextEditingController();
  List product = [];
  var _firebaseInstance = FirebaseFirestore.instance;

  fetchUSer() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        product.add({
          "Username": qn.docs[i]["Username"],
          "url": qn.docs[i]["url"],
        });
      }
      print(product);
    });
    return qn.docs;
  }

  void friClick() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["Phonenumber"] == widget.phone) {
          setState(() {
            uid = querySnapshot.docs.toString();
          });
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUSer();
    print(widget.ownid);
    print(widget.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: 428.w,
                height: 140.h,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(231, 11, 11, 1.0),
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
                    InkWell(
                      child: Image(
                          width: 30,
                          height: 30,
                          image: AssetImage('assets/images/arrow.png')),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Container(
                      width: 210.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 15.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        //controller: search,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                    Image(
                        width: 30,
                        height: 30,
                        image: AssetImage('assets/images/search.png')),
                  ],
                ),
              ),
              Container(
                width: 428.w,
                height: 780.h,
                color: Colors.white,
                //child: Flexible(
                  //flex: 1,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (name != "" && name != null)
                        ? FirebaseFirestore.instance
                            .collection("AllUsers")
                            .where("keyword", arrayContains: name.toLowerCase())
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("AllUsers")
                            .snapshots(),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                return Container(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        child: ListTile(
                                          title: Text(
                                            data['Username'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          leading: CircleAvatar(
                                            
                                            backgroundColor: Colors.transparent,
                                            backgroundImage: NetworkImage(
                                              data['url'],
                                             
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Profile(
                                                      data['Username'],
                                                      data['url'],
                                                      data['id'],
                                                      widget.phone,
                                                      data['Phonenumber'],
                                                      widget.ownid)));
                                        },
                                      ),
                                      Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                );
                              });
                    },
                  ),
                ),
              //),
            ],
          ),
        ),
      ),
      designSize: const Size(428, 926),
    );
  }
}
