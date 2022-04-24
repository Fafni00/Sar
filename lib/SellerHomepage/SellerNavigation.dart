// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/Navigationpages/Cart.dart';
import 'package:ecommerce_app/Navigationpages/Homepage.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/SellerProfileSection.dart';
import 'package:ecommerce_app/category/Categories.dart';
import 'package:ecommerce_app/Navigationpages/Profile.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Sellernavigation extends StatefulWidget {
  const Sellernavigation({Key? key}) : super(key: key);

  @override
  State<Sellernavigation> createState() => _SellernavigationState();
}

class _SellernavigationState extends State<Sellernavigation> {
  List pages = [
    Homepage(),
    SellerProfileSection(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        unselectedItemColor: AppColors.buttonnavigation,
        selectedItemColor: AppColors.buttonbackgroundColor,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
