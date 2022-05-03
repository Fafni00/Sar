import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Banner/HomeproductModel.dart';
import 'package:ecommerce_app/Sellerregistration/SellerModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> addToCart({data}) {
    return cart.doc(user?.uid).set(data.toJson());
  }

  // Future<void> addToCart(document) {
  //   cart.doc(user!.uid).set({
  //     'user': user!.uid,
  //   });
  //   return cart.doc(user!.uid).collection('products').add({
  //     'productId': document.data()['productID'],
  //     'productName': document.data()['productName'],
  //     'storeName': document.data()['storeName'],
  //     'sizeList': document.data()['sizeList'],
  //   });
  // }
}
