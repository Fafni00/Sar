import 'package:ecommerce_app/SellerHomepage/SellerNavigation.dart';
import 'package:ecommerce_app/Sellerregistration/Firebase_service.dart';
import 'package:ecommerce_app/UserRegistration/UserLogin.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class SellerLoginpage extends StatefulWidget {
  static const String id = 'login-page';
  const SellerLoginpage({Key? key}) : super(key: key);

  @override
  State<SellerLoginpage> createState() => _SellerLoginpageState();
}

@override
class _SellerLoginpageState extends State<SellerLoginpage> {
  //formkey
  final _formkey = GlobalKey<FormState>();
  final FirebaseServices _service = FirebaseServices();
  final FirebaseAuth _auths = FirebaseAuth.instance;

  //_securetext boolean value for password
  bool _secureText = true;

//editing controller
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
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
            child: Column(children: [
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
              image: AssetImage("assets/images/Decor1.png"), fit: BoxFit.cover),
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
            Text('Welcome To Your Store',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            // to create a straight line
            Container(
              child: Container(
                height: 5,
                width: 300,
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
    ])));
  }

  // Login Functions
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auths
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => Sellernavigation()))),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
