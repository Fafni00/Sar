import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Model/HomeproductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  User? user = FirebaseAuth.instance.currentUser;

  // Future<void> addToCart({data}) {
  //   return cart.doc(user?.uid).set(data.toJson());
  // }

  Future<void> addToCart({Product? product, String? productId}) {
    cart.doc(user?.uid).set({
      'user': user?.uid,
    });
    return cart.doc(user?.uid).collection('products').add({
      'productId': productId,
      'productName': product!.productName,
      'price': product.regularPrice,
      'storeName': product.storeName,
      'qty': 1,
      'total': product.regularPrice,
      'img': product.imageUrls?[0] ?? '',
    });
  }

  Future<void> updateCartQty(
    docId,
    qty,
    /*total*/
  ) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(user!.uid)
        .collection('product')
        .doc(docId);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("Product does not exist in Cart");
          }
          transaction.update(documentReference, {
            'qty': qty,
            //'total': total,
          });

          // Return the new count
          return qty;
        })
        .then((value) => print("Cart Updated"))
        .catchError((error) => print("Failed to update user cart: $error"));
  }

  Future<void> removeFromCart(docId) async {
    cart.doc(user!.uid).collection('products').doc(docId).delete();
  }

  Future<void> checkData() async {
    final snapshot = await cart.doc(user!.uid).collection('products').get();
    if (snapshot.docs.isEmpty) {
      cart.doc(user!.uid).delete();
    }
  }

  Future<DocumentSnapshot> getStoreName() async {
    DocumentSnapshot doc = await cart.doc(user!.uid).get();
    return doc;
  }
}
