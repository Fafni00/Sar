import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Cart/CartProducModel.dart';
import 'package:ecommerce_app/Cart/Cartservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Cartpage extends StatefulWidget {
  final Product? product;
  Cartpage(this.product);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  final CartServices _cart = CartServices();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getCartData();
    super.initState();
  }

  getCartData() async {
    _cart.cart.doc(user?.uid);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        EasyLoading.show(status: 'Adding to Cart');
        _cart.addToCart().then((value) {
          EasyLoading.showSuccess('Product Added Successfully');
        });
      }),
      child: Container(
          color: AppColors.buttonnavigation,
          margin: EdgeInsets.only(left: 10),
          height: 50,
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(0.8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 20),
                      Text('Add to Cart',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(width: 20),
                    ],
                  )))),
    );
  }
}
