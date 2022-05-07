import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Model/HomeproductModel.dart';
import 'package:ecommerce_app/Services/Cartservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
    this.product,
    required this.productId,
  }) : super(key: key);
  final Product? product;
  final String productId;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final CartServices _cart = CartServices();
  bool _loading = true;
  bool _exist = false;
  int _qty = 1;
  String? _docId;

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  getCartData() async {
    final snapshot = await _cart.cart.doc(userId).collection('products').get();
    if (snapshot.docs.isEmpty) {
      setState(() {
        _loading = false;
      });
    } else {
      {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(userId)
        .collection('products')
        .where('productId', isEqualTo: widget.productId)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doc['productID'] == widget.productId) {
                  //to show that the product has been added in the cart
                  setState(() {
                    _exist = true;
                    _qty = doc['qty'];
                    _docId = doc.id;
                  });
                }
              }),
            });

    return _loading
        ? SizedBox(
            height: 56,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).backgroundColor),
            )))
        : InkWell(
            onTap: (() {
              log('adding product');
              _cart
                  .addToCart(
                product: widget.product,
                productId: widget.productId,
              )
                  .then((value) {
                setState(() {
                  _exist = true;
                });
                EasyLoading.showSuccess('Product Added to Cart');
                log('Product Added Successfully');
              });
            }),
            child: Container(
              color: AppColors.buttonnavigation,
              margin: const EdgeInsets.only(left: 10),
              height: 50,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(0.8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(width: 10),
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 20),
                      Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
