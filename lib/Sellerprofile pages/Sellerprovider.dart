import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Sellerregistration/Firebase_service.dart';
import '../Sellerregistration/SellerModel.dart';
import 'package:get_storage/get_storage.dart';

class SellerProvider with ChangeNotifier {
  final FirebaseServices _service = FirebaseServices();
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? doc;
  //this is for the database upload part in addproduct
  Seller? seller;
  getsellerData() {
    var box = GetStorage();
    print('output' + box.read('id'));
    box.write('id', FirebaseAuth.instance.currentUser?.uid);
    _service.seller.doc(box.read('id')).get().then((document) {
      doc = document;
      print(doc.toString());
      //to upload the seller information while adding the product in the database
      seller = Seller.fromJson(document.data() as Map<String, dynamic>);
      notifyListeners();
    });
  }
}
