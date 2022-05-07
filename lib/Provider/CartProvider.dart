import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Services/Cartservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final CartServices _cart = CartServices();

  double subTotal = 0.0;
  int cartQty = 0;
  QuerySnapshot? snapshot;
  List cartList = [];

  Future<double?> getCartTotal() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    var cartTotal = 0.0;
    List _newList = [];
    QuerySnapshot snapshot =
        await _cart.cart.doc(userId).collection('products').get();

    for (var doc in snapshot.docs) {
      if (!_newList.contains(doc.data())) {
        _newList.add(doc.data());
        cartList = _newList;
        notifyListeners();
      }
      cartTotal = cartTotal + doc['total'];
    }
    subTotal = cartTotal;
    cartQty = snapshot.size;
    this.snapshot = snapshot;
    notifyListeners();
    return cartTotal;
  }
}
