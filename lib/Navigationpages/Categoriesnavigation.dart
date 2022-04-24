// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/Navigationpages/Cart.dart';
import 'package:ecommerce_app/Navigationpages/Homepage.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/SellerProfileSection.dart';
import 'package:ecommerce_app/category/Categories.dart';
import 'package:ecommerce_app/Navigationpages/Profile.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class categoriesnavigation extends StatefulWidget {
  const categoriesnavigation({Key? key}) : super(key: key);

  @override
  State<categoriesnavigation> createState() => _categoriesnavigationState();
}

class _categoriesnavigationState extends State<categoriesnavigation> {
  List pages = [
    Homepage(),
    CategoriesPage(),
    Cartpage(),
    SellerProfileSection(),
  ];
  int currentIndex = 1;
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
          BottomNavigationBarItem(
              label: 'Categories', icon: Icon(Icons.category)),
          BottomNavigationBarItem(
              label: 'Cart', icon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
