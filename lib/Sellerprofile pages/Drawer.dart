// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/product_provider.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/AddProductspage.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/ViewOrder.dart';
import 'package:ecommerce_app/Sellerregistration/SellerLogin.dart';
import 'package:ecommerce_app/UserRegistration/UserLogin.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/AllProduct.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/SellerProfileSection.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/Sellerprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerDrawer extends StatelessWidget {
  const SellerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sellerData = Provider.of<SellerProvider>(context);

    Widget _menu({String? menuTitle, IconData? icon, String? route}) {
      return ListTile(
        leading: Icon(
          icon,
          color: Color(0xFF056608),
        ),
        title: Text(menuTitle!, style: TextStyle(color: Color(0xFF056608))),
        onTap: () {
          Navigator.pushReplacementNamed(context, route!);
        },
      );
    }

    return Drawer(
        child: Column(children: [
      Container(
        height: 130,
        color: Color(0xFF056608),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerHeader(
              child: _sellerData.doc == null
                  ? Text('Fetching..',
                      style: TextStyle(color: Colors.white, fontSize: 10))
                  : Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              child: CachedNetworkImage(
                                  imageUrl: _sellerData.doc!['storeImage']),
                            ),
                            SizedBox(width: 6),
                            Text(
                              _sellerData.doc!['storeName'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _menu(
                menuTitle: 'Home',
                icon: Icons.home,
                route: SellerProfileSection.id),
            ExpansionTile(
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: Color(0xFF056608),
                ),
                title: Text('products',
                    style: TextStyle(color: Color(0xFF056608))),
                children: [
                  _menu(
                      menuTitle: 'All Products',
                      icon: Icons.shopping_bag_outlined,
                      route: AllProduct.id),
                  _menu(
                      menuTitle: 'Add Product',
                      icon: Icons.add_shopping_cart,
                      route: AddProductScreen.id),
                ]),
            _menu(
                menuTitle: 'View Order',
                icon: Icons.receipt,
                route: ProductOrder.id),
          ],
        ),
      ),
      ListTile(
          title: Text('Signout', style: TextStyle(color: Color(0xFF056608))),
          trailing: Icon(
            Icons.exit_to_app,
            color: Color(0xFF056608),
          ),
          onTap: () {
            _signOut();
            //final _sellerData = Provider.of<SellerProvider>(context);
            _sellerData.resetSellerData();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Loginpage()));
          }),
    ]));
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();
    User? user = FirebaseAuth.instance.currentUser;
    print('Current User ');
    print(user?.uid);
  }
}
