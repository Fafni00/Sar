import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Sellerregistration/Firebase_service.dart';

class SellerAuthProvider with ChangeNotifier {
  final FirebaseAuth _auths = FirebaseAuth.instance;
  DocumentSnapshot? snapshot;
  final FirebaseServices _service = FirebaseServices();

  Future<DocumentSnapshot> getUserDetails() async {
    DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('seller')
        .doc(_auths.currentUser!.uid)
        .get();
    this.snapshot = result;
    notifyListeners();
    return result;
  }
}
