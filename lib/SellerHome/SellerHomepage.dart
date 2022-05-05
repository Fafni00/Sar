// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/SellerHome/components/SellerProductDisplay/SellerHomeCat.dart';
import 'package:ecommerce_app/SellerHome/components/SellerBanner.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
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
      SizedBox(height: 30),
      SellerBanner(),
      SellerHomeCat(),
    ])));
  }
}
