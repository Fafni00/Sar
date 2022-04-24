// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/UserProfile/UserProflie.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  static const String id = 'udateprofile';
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  var name = TextEditingController();
  var username = TextEditingController();
  var email = TextEditingController();
  var contact = TextEditingController();

  @override
  void inistate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Edit Profile',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => UserProfile())));
              }),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 56,
          color: AppColors.text1Color.withOpacity(0.7),
          child: Center(
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formkey,
                child: Column(children: [
                  TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          labelText: ' Name',
                          labelStyle: TextStyle(color: AppColors.buttonColor),
                          contentPadding: EdgeInsets.all(0.8)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      }),

                  SizedBox(height: 30),

                  //for username
                  TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                          labelText: 'UserName',
                          labelStyle: TextStyle(color: AppColors.buttonColor),
                          contentPadding: EdgeInsets.all(0.8)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter UserName';
                        }
                        return null;
                      }),

                  SizedBox(height: 30),

                  //for contact
                  TextFormField(
                    controller: contact,
                    decoration: InputDecoration(
                        labelText: ' Contact',
                        labelStyle: TextStyle(color: AppColors.buttonColor),
                        contentPadding: EdgeInsets.all(0.8)),
                  ),

                  SizedBox(height: 30),
                  //for email
                  TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: AppColors.buttonColor),
                          contentPadding: EdgeInsets.all(0.8)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      }),

                  SizedBox(height: 30),
                ]))));
  }
}
