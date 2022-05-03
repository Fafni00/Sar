import 'dart:developer';

import 'package:ecommerce_app/Banner/HomeproductModel.dart';
import 'package:ecommerce_app/Cart/Cartservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    getCartData();
    super.initState();
  }

  getCartData() async {
    final snapshot = await _cart.cart.doc(userId).collection('products').get();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        log('adding product');
        _cart
            .addToCart(product: widget.product, productId: widget.productId)
            .then((value) {
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
