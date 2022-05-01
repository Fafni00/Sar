import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> addToCart({data}) {
    return cart.doc(user?.uid).set(data);
  }
}
