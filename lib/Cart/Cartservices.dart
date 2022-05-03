import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Banner/HomeproductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  User? user = FirebaseAuth.instance.currentUser;

  // Future<void> addToCart({data}) {
  //   return cart.doc(user?.uid).set(data.toJson());
  // }

  Future<void> addToCart({Product? product, String? productId}) {
    cart.doc(user!.uid).set({
      'user': user!.uid,
    });
    return cart.doc(user!.uid).collection('products').add({
      'productId': productId,
      'productName': product?.productName,
      'storeName': product?.storeName,
      'sizeList': product?.sizeList,
    });
  }
}
