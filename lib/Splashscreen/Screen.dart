// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/UserLoginRegistration/UserLogin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // for Background image
        margin: EdgeInsets.only(top: 0, bottom: 0),
        height: 1000,
        width: 800,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splashscreen.png"),
            fit: BoxFit.cover,
          ),
        ),
        // for logo in splashscreen
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100, bottom: 30),
                ),
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  backgroundColor: Colors.transparent,
                ),
                // texts in splashscreen
                Text('Sār',
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Text('An E-Commerce App For Local Business',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                //for textbox
                Container(
                  margin: EdgeInsets.only(top: 200, bottom: 30),
                  width: 250,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(),
                    color: const Color(0xFF1F9D0C),
                  ),
                  child: RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => Loginpage()),
                          text: 'Get Started',
                          style: TextStyle(
                            fontSize: 23,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
