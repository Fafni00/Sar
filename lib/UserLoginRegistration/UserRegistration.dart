// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/Model/Usermodel.dart';
import 'package:ecommerce_app/SellerLoginRegistration/SellerRegistrationForm.dart';
import 'package:ecommerce_app/UserLoginRegistration/UserLogin.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserRegistrationPage extends StatefulWidget {
  const UserRegistrationPage({Key? key}) : super(key: key);

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  //Authentcating the firebase
  final _auth = FirebaseAuth.instance;

  //declaring global form key
  final _formkey = GlobalKey<FormState>();
  // editing controllers
  final nameEditingController = new TextEditingController();
  final usernameEditingController = new TextEditingController();
  final contactEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //creating a text field for name
    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,

        //validator
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Name cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Please enter name");
          }
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 15),
          hintText: "Enter Your Name",
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
        ));

    //creating a text field for username
    final usernameField = TextFormField(
        autofocus: false,
        controller: usernameEditingController,
        keyboardType: TextInputType.name,

        //validator
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Username cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Please enter valid username(Min. 8 Character)");
          }
        },
        onSaved: (value) {
          usernameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 15),
          hintText: "Create Username",
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
        ));

    //creating a text field for contactnumber
    final contactField = TextFormField(
        autofocus: false,
        controller: contactEditingController,
        keyboardType: TextInputType.number,

        //validator
        validator: (value) {
          RegExp regex = RegExp(r'^.{10,}$');
          if (value!.isEmpty) {
            return ("Contact cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Please enter valid Contact Number(Min. 10 Character)");
          }
        },
        onSaved: (value) {
          contactEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 15),
          hintText: "Enter Contact Number",
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
        ));

    //creating a text field for email
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        //validator
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter Correct Email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 15),
          hintText: "Enter E-Mail",
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
        ));

    //creating a text field for password
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
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
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 15),
          hintText: "Create Password",
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
        ));

    //creating a text field for name
    final confirmpasswordField = TextFormField(
        autofocus: false,
        controller: confirmpasswordEditingController,
        obscureText: true,
        //validator
        validator: (value) {
          if (confirmpasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password Doesn't Match";
          }
          return null;
        },
        onSaved: (value) {
          confirmpasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 15),
          hintText: "Conform Password",
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
        ));

    //creating register button
    final Registerbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.vertical(),
      color: AppColors.buttonbackgroundColor,
      child: MaterialButton(
        padding: EdgeInsets.only(left: 80, right: 80),
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text("Register",
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
          height: 200,
          width: 440,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Decor2.png"),
            ),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                toolbarHeight: 30,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: AppColors.buttonbackgroundColor),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Loginpage())));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                //For texts in the page
                child: Text('Sār',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),

        // code to create the textfields inside the container
        Container(
          margin: EdgeInsets.only(bottom: 0),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  nameField,
                  SizedBox(
                    height: 10,
                  ),
                  usernameField,
                  SizedBox(
                    height: 10,
                  ),
                  contactField,
                  SizedBox(
                    height: 10,
                  ),
                  emailField,
                  SizedBox(
                    height: 10,
                  ),
                  passwordField,
                  SizedBox(
                    height: 10,
                  ),
                  confirmpasswordField,
                  SizedBox(
                    height: 20,
                  ),
                  Registerbutton,
                ],
              ),
            ),
          ),
        ),

        SizedBox(
          height: 20,
        ),

        // code to create text below register button
        Text('Are You a Seller, Register Your Store Here ',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.text1Color,
            )),

        // Code to create register as seller button
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 50),
            width: 400,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(),
              color: AppColors.textboxColor,
            ),
            child: RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Get.to(() => SellerRegistrationForm()),
                text: "Register as Seller",
                style: TextStyle(color: AppColors.text1Color, fontSize: 18),
              ),
            )),
      ],
    )));
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore
    //calling usermodel
    //sending values to firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.name = nameEditingController.text;
    userModel.username = usernameEditingController.text;
    userModel.contact = confirmpasswordEditingController.text;
    userModel.email = user!.email;
    userModel.password = passwordEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "User Registered Successfully");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Loginpage()), (route) => false);
  }
}
