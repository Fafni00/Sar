import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Services/SellerRegistrationServices.dart';
import '../Model/SellerModel.dart';

class SellerProvider with ChangeNotifier {
  //final FirebaseServices _service = FirebaseServices();
  CollectionReference sellerRef =
      FirebaseFirestore.instance.collection('seller');
  //User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? doc;
  //this is for the database upload part in addproduct
  Seller? seller;

  getsellerData() async {
    //print(_service.user!.uid);
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
    print("Receiving seller data");
    doc = await sellerRef.doc(user.uid).get();
    print(doc!.data());
    seller = Seller.fromJson(doc!.data() as Map<String, dynamic>);
    print(seller!.storeName);
    print("Seller details set");
    notifyListeners();
  }

  resetSellerData() {
    seller = null;
    print("Seller set to null");
    //notifyListeners();
  }
}

  // Seller? getSeller() {
  //   return seller;
  // }
