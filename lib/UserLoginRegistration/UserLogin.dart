// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:ecommerce_app/SellerLoginRegistration/SellerLogin.dart';
import 'package:ecommerce_app/UserHomePage/Homepagenavigation.dart';
import 'package:ecommerce_app/UserLoginRegistration/UserRegistration.dart';

import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Loginpage extends StatefulWidget {
  static const String id = 'login-page';
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

@override
class _LoginpageState extends State<Loginpage> {
  //formkey
  final _formkey = GlobalKey<FormState>();

  //_securetext boolean value for password
  bool _secureText = true;

//editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  //firebase authentication
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // for emailtextfield
    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,

      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter Correct Email");
        }
        return null;
      },
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        hintText: "Email",
        hintStyle: TextStyle(fontSize: 15, color: AppColors.text1Color),
        border: InputBorder.none,
        fillColor: AppColors.textboxColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            )),
      ),
    );

    // creating Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordcontroller,

      //validator
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter Password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Correct password(Min. 6 Characters)");
        }
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },

      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        hintText: "Password",
        hintStyle: TextStyle(fontSize: 15, color: AppColors.text1Color),
        border: InputBorder.none,
        fillColor: AppColors.textboxColor,
        filled: true,
        //for focused border
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            )),
        suffixIcon: IconButton(
          icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _secureText = !_secureText;
            });
          },
        ),
      ),
      obscureText: _secureText,
    );

    // code for creating login button

    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.vertical(),
      color: AppColors.buttonbackgroundColor,
      child: MaterialButton(
        padding: EdgeInsets.only(left: 80, right: 80),
        onPressed: () {
          signIn(emailcontroller.text, passwordcontroller.text);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(
          height: 0,
        ),
        // code for the background picture and Text on the top of the screen
        Container(
          // inserting background picture and adjusting its size
          margin: EdgeInsets.only(bottom: 10),
          height: 390,
          width: 430,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Decor1.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/images/logo.png"),
                backgroundColor: Colors.transparent,
              ),
              //For texts in the page
              Text('Sār',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              Text('An E-Commerce App For Local Business',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 30),
              ),
              Text('Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              // to create a straight line
              Container(
                child: Container(
                  height: 5,
                  width: 220,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 10,
        ),

        //to display the textform created above
        Container(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  emailField,
                  SizedBox(
                    height: 20,
                  ),
                  passwordField,
                  SizedBox(
                    height: 20,
                  ),
                  loginbutton,
                ],
              ),
            ),
          ),
        ),

        SizedBox(
          height: 10,
        ),

        //login as seller
        // code to create clickable texts
        Container(
            height: 40,
            width: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.textboxColor,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(2, 2),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ]),
            child: RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(() => SellerLoginpage()),
                text: " Login as Seller",
                style: TextStyle(color: AppColors.text1Color, fontSize: 20),
              ),
            )),

        SizedBox(
          height: 10,
        ),

        // code to create clickable texts
        RichText(
            text: TextSpan(
                text: "Don\'t have an Account?",
                style: TextStyle(color: Colors.black, fontSize: 15),
                children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(() => UserRegistrationPage()),
                text: "Sign Up",
                style: TextStyle(color: AppColors.text1Color, fontSize: 18),
              ),
            ])),
      ],
    )));
  }

  // Login Functions
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => Homepagenavigation()))),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
