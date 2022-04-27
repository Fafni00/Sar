// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/UserProfile/Order%20pages/Vieworderpage.dart';
import 'package:ecommerce_app/UserRegistration/UserLogin.dart';
import 'package:ecommerce_app/UserProfile/Userprofileupdate.dart';
import 'package:ecommerce_app/UserRegistration/Usermodel.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: const Color(0xFFe2efdd),
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          automaticallyImplyLeading: false,
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
                  color: Colors.white,
                  child: Row(children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Text('U',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.text1Color,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
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
                Positioned(
                    right: 10.0,
                    //top: 10.0,
                    child: IconButton(
                      icon: Icon(Icons.edit_outlined,
                          color: AppColors.buttonbackgroundColor),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => UpdateProfile())));
                      },
                    )),
              ],
            ),
            SizedBox(height: 30),
            ListTile(
                leading: Icon(Icons.history),
                title: Text('My Orders'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => ViewOrder())));
                },
                horizontalTitleGap: 5,
                shape:
                    Border(bottom: BorderSide(color: AppColors.buttonColor))),
            ListTile(
                leading: Icon(Icons.comment),
                title: Text('Reviews & Ratings'),
                onTap: () {},
                horizontalTitleGap: 5,
                shape:
                    Border(bottom: BorderSide(color: AppColors.buttonColor))),
            ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
                horizontalTitleGap: 5,
                shape:
                    Border(bottom: BorderSide(color: AppColors.buttonColor))),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, Loginpage.id);
                },
                horizontalTitleGap: 5,
                shape:
                    Border(bottom: BorderSide(color: AppColors.buttonColor))),
          ]),
        ));
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
}
