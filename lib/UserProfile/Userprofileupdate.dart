// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/UserProfile/UserNavigation.dart';
import 'package:ecommerce_app/UserProfile/UserProflie.dart';
import 'package:ecommerce_app/Model/Usermodel.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateProfile extends StatefulWidget {
  static const String id = 'udateprofile';
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final name = TextEditingController();
  final username = TextEditingController();
  final contact = TextEditingController();

  updateProfile() {
    if (_formkey.currentState!.validate()) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'name': name.text,
        'username': username.text,
        'contact': contact.text,
      });
    }
  }

  Widget _textField({
    TextEditingController? controller,
    String? label,
    TextInputType? inputType,
    int? maxLine,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLine,
      decoration: InputDecoration(
        label: Text(label!),
        labelStyle: TextStyle(
            color: AppColors.buttonColor.withOpacity(0.5), fontSize: 14),
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        //for focused border
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.textboxColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.textboxColor,
            )),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter $label';
        }
      },
    );
  }

  @override
  void initState() {
    UpdateProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.buttonColor,
            automaticallyImplyLeading: false,
            title: Text(
              'Edit Profile',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UserNavigation())));
                })),
        body: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 40),
                // name field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textField(
                      label: ' Enter Name',
                      inputType: TextInputType.text,
                      controller: name),
                ),
                SizedBox(height: 10),

                // usernamefield
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textField(
                      label: ' Enter UserName',
                      inputType: TextInputType.text,
                      controller: username),
                ),
                SizedBox(height: 10),

                // contact field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _textField(
                      label: ' Enter Contact',
                      inputType: TextInputType.text,
                      controller: contact),
                ),
                SizedBox(height: 10),

                Container(
                  width: 140,
                  height: 40,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.buttonbackgroundColor)),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        EasyLoading.show(status: 'Updating profile...');
                        updateProfile().then((value) {
                          EasyLoading.showSuccess('Profile Updated');
                          Navigator.pop(context);
                        });
                      }),
                )
              ],
            )));
  }
}
