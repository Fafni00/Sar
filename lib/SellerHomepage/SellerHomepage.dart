// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/SellerHomepage/Sellerbanner.dart';
import 'package:flutter/material.dart';

class SellerHomepage extends StatefulWidget {
  const SellerHomepage({Key? key}) : super(key: key);

  @override
  State<SellerHomepage> createState() => _SellerHomepageState();
}

class _SellerHomepageState extends State<SellerHomepage> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      //code for the background picture and Text on the topleft corner of the screen
      Container(
        //inserting background picture and adjusting its size
        height: 130,
        margin: EdgeInsets.only(right: 240),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Decor3.png"),
              fit: BoxFit.contain),
        ),
      ),
      SellerBanner(),
    ])));
  }
}
