import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Sellerregistration/Firebase_service.dart';
import '../Sellerregistration/SellerModel.dart';

class SellerProvider with ChangeNotifier {
  final FirebaseServices _service = FirebaseServices();
  DocumentSnapshot? doc;
  //this is for the database upload part in addproduct
  Seller? seller;

  getsellerData() {
    _service.seller.doc(_service.user!.uid).get().then((document) {
      doc = document;
      //to upload the seller information while adding the product in the database
      seller = Seller.fromJson(document.data() as Map<String, dynamic>);
      notifyListeners();
    });
  }
}
