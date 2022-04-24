// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/UserRegistration/Authprovider.dart';
import 'package:ecommerce_app/UserRegistration/UserLogin.dart';
import 'package:ecommerce_app/UserProfile/Userprofileupdate.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;
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
          leading: Container(
            margin: EdgeInsets.only(left: 300),
            child: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Loginpage())));
                }),
          ),
        ),
        body: Center(
          child: Column(children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('My Account',
                      style: TextStyle(
                        fontSize: 15,
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
                        child: Text('j',
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
                                Text('Edit User Name',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.text1Color,
                                    )),
                                Text(
                                  'Email',
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
                        FirebaseAuth.instance.signOut();
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
                horizontalTitleGap: 5,
                shape:
                    Border(bottom: BorderSide(color: AppColors.buttonColor))),
            ListTile(
                leading: Icon(Icons.comment),
                title: Text('Reviews & Ratings'),
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
                title: Text('Notifications'),
                horizontalTitleGap: 5,
                shape:
                    Border(bottom: BorderSide(color: AppColors.buttonColor))),
          ]),
        ));
  }
}
