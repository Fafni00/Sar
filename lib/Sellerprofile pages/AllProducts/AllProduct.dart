// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Approved.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Unpublishedproducts.dart';
import 'package:flutter/material.dart';

import '../Drawer.dart';

class AllProduct extends StatelessWidget {
  static const String id = 'all product';
  const AllProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color(0xFF056608),
              title: Text('All Product',
                  style: TextStyle(fontSize: 35, color: Colors.white)),
              elevation: 0,
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 6, color: Colors.white)),
                tabs: [
                  Tab(
                    child: Text('Approved'),
                  ),
                  Tab(
                    child: Text('Unplublished'),
                  )
                ],
              )),
          drawer: SellerDrawer(),
          body: TabBarView(
            children: [
              ApprovedProducts(),
              UnpublishedProducts(),
            ],
          ),
        ));
  }
}
