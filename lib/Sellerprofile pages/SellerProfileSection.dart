import 'package:ecommerce_app/Sellerprofile%20pages/Drawer.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/Sellerprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class SellerProfileSection extends StatelessWidget {
  static const String id = 'sellerprofile';
  const SellerProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sellerData = Provider.of<SellerProvider>(context);
    if (_sellerData.doc == null) {
      _sellerData.getsellerData();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF056608),
        title: Text(
          'Seller Profile',
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
      drawer: SellerDrawer(),
      body: Container(
        child: Text('Seller Profile'),
      ),
    );
  }
}
