import 'package:ecommerce_app/SellerHome/SellerHomepage.dart';
import 'package:ecommerce_app/SellerProfile/SellerProfileSection.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class SellerProfileNavigation extends StatefulWidget {
  static const String id = 'sellerprofilenavigation';
  SellerProfileNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<SellerProfileNavigation> createState() =>
      _SellerProfileNavigationState();
}

class _SellerProfileNavigationState extends State<SellerProfileNavigation> {
  List pages = [
    SellerHomepage(),
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
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
