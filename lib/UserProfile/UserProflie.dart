// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Model/Usermodel.dart';
import 'package:ecommerce_app/Order/MyOrder.dart';
import 'package:ecommerce_app/UserLoginRegistration/UserLogin.dart';
import 'package:ecommerce_app/UserProfile/Userprofileupdate.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Sar',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Center(
            child: Column(children: [
          Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('My Account',
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.text1Color,
                    ))),
          ),
          Stack(
            children: [
              Container(
                color: const Color(0xFFe2efdd),
                child: Row(children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.buttonColor,
                      child: Text('U',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ))),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 70,
                            child: Column(children: [
                              Text('${loggedInUser.name}',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: AppColors.text1Color,
                                  )),
                              Text(
                                '${loggedInUser.email}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.text1Color,
                                ),
                              ),
                            ]),
                          )),
                    ],
                  )
                ]),
              ),
            ],
          ),
          // to show the orderpage
          SizedBox(height: 30),
          Column(children: [
            Row(children: [
              Row(children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext) => MyOrder()));
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 40, bottom: 20, right: 100),
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/Receipt.png"),
                                    fit: BoxFit.cover),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      offset: Offset(3, 3),
                                      color: Colors.grey.withOpacity(0.4)),
                                  BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(-3, -3),
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                ]),
                          ),
                          SizedBox(height: 4),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 50, bottom: 20, right: 10),
                              child: Text(
                                'My Order',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF056608),
                                ),
                              )),
                        ])),

                // to show the queries
                SizedBox(height: 30),
                Column(children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext) =>
                                            UpdateProfile()));
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 20),
                                      height: 120,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/editprofile.png"),
                                              fit: BoxFit.contain),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                offset: Offset(3, 3),
                                                color: Colors.grey
                                                    .withOpacity(0.4)),
                                            BoxShadow(
                                              blurRadius: 1,
                                              offset: Offset(-3, -3),
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                          ]),
                                    ),
                                    SizedBox(height: 4),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 18, bottom: 20),
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF056608),
                                          ),
                                        )),
                                  ])),
                        ],
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ]),
              ])
            ]),
          ]),
          Container(
            margin: EdgeInsets.only(top: 236),
            width: 400,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(),
              color: AppColors.textboxColor,
            ),
            child: InkWell(
              child: Text('Log Out',
                  style: TextStyle(
                      color: AppColors.buttonnavigation,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                _signOut(context);
              },
            ),
          )
        ])));
  }

  //get userdetails
  getUserDetail() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then(((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    }));
  }

  _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Loginpage(),
            ),
          ),
        );
  }
}
