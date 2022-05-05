// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Splashscreen/Screen.dart';
import 'package:flutter/material.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({Key? key}) : super(key: key);

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen(),
    );
  }
}
