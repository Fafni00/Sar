import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Cart/cartprovider.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart-screen';
  final DocumentSnapshot? document;
  const CartScreen({
    this.document,
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      bottomSheet: Container(
          height: 60,
          color: AppColors.buttonColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\Rs.${_cartProvider.subTotal.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {},
                      child: Text('Checkout',
                          style: TextStyle(fontSize: 18, color: Colors.white)))
                ],
              ),
            ),
          )),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBozIsSxrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(widget.document.['storeName'], style: TextStyle(fontSize: 18),),
                    Text(
                      '${_cartProvider.cartQty} ${_cartProvider.cartQty > 1 ? 'Item' : 'Items'}',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.buttonnavigation),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Container(
              child: Column(
            children: [ListTile()],
          ))),
    );
  }
}
