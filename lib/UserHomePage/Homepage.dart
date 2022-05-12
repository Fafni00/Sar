// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/Cart/CartNotification.dart';
import 'package:ecommerce_app/Model/HomeproductModel.dart';
import 'package:ecommerce_app/UserHomePage/Components/HomeProductDisplay/Categoryforhomepage.dart';
import 'package:ecommerce_app/UserHomePage/Components/banner_widge_page.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:search_page/search_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, this.snapshot}) : super(key: key);
  final FirestoreQueryBuilderSnapshot? snapshot;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Product> _productList = [];

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  getProductList() {
    return widget.snapshot?.docs.forEach((element) {
      Product product = element.data();
      setState(() {
        _productList.add(Product(
          productName: product.productName,
          storeName: product.storeName,
          regularPrice: product.regularPrice,
          salesPrice: product.salesPrice,
          category: product.category,
          mainCategory: product.mainCategory,
          subCategory: product.subCategory,
          description: product.description,
          saledate: product.saledate,
          sku: product.sku,
          manageInventory: product.manageInventory,
          stockonhand: product.stockonhand,
          reOrderLevel: product.reOrderLevel,
          manageDeliveries: product.manageDeliveries,
          deliveryCharge: product.deliveryCharge,
          deliveryLocation: product.deliveryLocation,
          tags: product.tags,
          sizeList: product.sizeList,
          additionalDetail: product.additionalDetail,
          unit: product.unit,
          imageUrls: product.imageUrls,
          selleruid: product.selleruid,
          approved: product.approved,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: CartNotification(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
            child: Column(children: [
          //code for the background picture and Text on the topleft corner of the screen
          Container(
            //inserting background picture and adjusting its size
            height: 100,
            margin: EdgeInsets.only(right: 240),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Decor3.png"),
                  fit: BoxFit.cover),
            ),
          ),

          Container(
              width: 400,
              margin: EdgeInsets.only(
                left: 150,
              ),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Sār',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF056608),
                          )),
                    ],
                  ),
                ],
              )),
          //to create the announcement in the page
          Container(
            color: const Color(0xFF228B22),
            child: Column(children: [
              Container(
                height: 35,
                margin: EdgeInsets.only(left: 20, right: 10),
                child: Row(children: [
                  Row(children: [
                    Icon(Icons.info_rounded, color: Colors.white, size: 18),
                    Text('Promoting Local Business',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ))
                  ]),
                  SizedBox(
                    width: 10,
                  ),
                  Row(children: [
                    Icon(Icons.info_outline, color: Colors.white, size: 18),
                    Text('100% Genuine Products',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ))
                  ])
                ]),
              )
            ]),
          ),
          SizedBox(height: 2),

          //to display banner
          BannerWigetPage(),
          SizedBox(height: 5),

          //to display the categorylabel
          CategoryHomepage(),
        ])));
  }
}
