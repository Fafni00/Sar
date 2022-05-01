// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/SellerHomepage/SellerHomepage.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/SellerProfileSection.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class Sellernavigation extends StatefulWidget {
  String uId;
  Sellernavigation({Key? key, required this.uId}) : super(key: key);

  @override
  State<Sellernavigation> createState() => _SellernavigationState();
}

class _SellernavigationState extends State<Sellernavigation> {
  List pages = [
    SellerHomepage(),
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
