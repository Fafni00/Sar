import 'package:ecommerce_app/SellerProfile/SellerProfileSection.dart';

import 'package:flutter/material.dart';

import '../Utils/Colors.dart';

class ProductOrder extends StatelessWidget {
  static const String id = 'product order';
  const ProductOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.buttonnavigation,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => SellerProfileSection())));
          },
        ),
      ),
    );
  }
}
