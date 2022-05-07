// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Cart/CartScreen.dart';
import 'package:ecommerce_app/Provider/CartProvider.dart';
import 'package:ecommerce_app/Services/Cartservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartNotification extends StatefulWidget {
  const CartNotification({Key? key}) : super(key: key);

  @override
  State<CartNotification> createState() => _CartNotificationState();
}

class _CartNotificationState extends State<CartNotification> {
  final CartServices _cart = CartServices();
  DocumentSnapshot? document;

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.buttonnavigation,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(18), topLeft: Radius.circular(18))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          '${_cartProvider.cartQty}${_cartProvider.cartQty == 1 ? 'Item' : 'Items'}',
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      Text(
                        ' | ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text('Rs.${_cartProvider.subTotal}',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext) =>
                            CartScreen(document: document)));
              },
              child: Container(
                  child: Row(
                children: [
                  Text('View Cart',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  SizedBox(width: 10),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
