// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/SellerProfile/SellerProfileSection.dart';
import 'package:ecommerce_app/UserHomePage/Homepage.dart';
import 'package:ecommerce_app/category/CategoriesPage.dart';

import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Cart/Cart.dart';

class categoriesnavigation extends StatefulWidget {
  const categoriesnavigation({Key? key}) : super(key: key);

  @override
  State<categoriesnavigation> createState() => _categoriesnavigationState();
}

class _categoriesnavigationState extends State<categoriesnavigation> {
  List pages = [
    Homepage(),
    CategoriesPage(),
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
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
