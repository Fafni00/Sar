// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/AddProductspage.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/AllProduct.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/Drawer.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/Sellerprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utils/Colors.dart';

class SellerProfileSection extends StatelessWidget {
  static const String id = 'sellerprofile';
  const SellerProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sellerData = Provider.of<SellerProvider>(context);
    if (_sellerData.seller == null) {
      print("Reading the seller data");
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
      body: Column(
        children: [
          Container(
              child: _sellerData.doc == null
                  ? Text('Fetching..',
                      style: TextStyle(color: Colors.white, fontSize: 10))
                  : Column(children: [
                      //to show the Store Image
                      Row(
                        children: [
                          Container(
                            height: 200,
                            width: 392,
                            child: CachedNetworkImage(
                              imageUrl: _sellerData.doc!['storeImage'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40),
                      //to show the Store Name
                      Container(
                        margin: EdgeInsets.only(
                          right: 16,
                          left: 16,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                offset: Offset(3, 3),
                                color: Color(0xFF056608).withOpacity(0.3),
                              ),
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(-3, -3),
                                color: Color(0xFF056608).withOpacity(0.3),
                              ),
                            ]),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              _sellerData.doc!['storeName'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                            SizedBox(height: 10),

                            //to show the Owner name
                            Container(
                              margin: EdgeInsets.only(right: 20, left: 90),
                              child: Row(children: [
                                Text('Owner :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                SizedBox(width: 10),
                                Text(
                                  _sellerData.doc!['ownerName'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ]),
                            ),
                            SizedBox(height: 10),
                            //to show the Address
                            Container(
                              margin: EdgeInsets.only(right: 20, left: 90),
                              child: Row(children: [
                                Text('Address :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                SizedBox(width: 10),
                                Text(
                                  _sellerData.doc!['address'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ]),
                            ),
                            SizedBox(height: 10),
                            //to show the Contact Number
                            Container(
                              margin: EdgeInsets.only(right: 20, left: 40),
                              child: Row(children: [
                                Text('Contact Number :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                SizedBox(width: 10),
                                Text(
                                  _sellerData.doc!['contactNumber'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ]),
                            ),
                            SizedBox(height: 10),
                            //to show the Email
                            Container(
                              margin: EdgeInsets.only(right: 20, left: 40),
                              child: Row(children: [
                                Text('Email Address :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                SizedBox(width: 10),
                                Text(
                                  _sellerData.doc!['emailAddress'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ])),

          // to create the Add product and All product section in seller profile
          SizedBox(height: 20),

          Container(
            height: 5,
            color: const Color(0xFFe2efdd),
          ),
          SizedBox(height: 20),

          Column(
            children: [
              Row(children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) =>
                                      AddProductScreen()));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 40, bottom: 20, right: 100),
                                height: 120,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/addproduct.png"),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          offset: Offset(3, 3),
                                          color: Colors.grey.withOpacity(0.4)),
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: Offset(-3, -3),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 4),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 20, right: 0),
                                  child: Text(
                                    'Add Product',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF056608),
                                    ),
                                  )),
                            ])),
                  ],
                ),
                SizedBox(width: 5),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext) => AllProduct()));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20, right: 30),
                                height: 120,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/viewproduct.png"),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          offset: Offset(3, 3),
                                          color: Colors.grey.withOpacity(0.4)),
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: Offset(-3, -3),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 4),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 0, bottom: 20, right: 0),
                                  child: Text(
                                    'View Products',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF056608),
                                    ),
                                  )),
                            ])),
                  ],
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
