import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Review/AddReview.dart';
import 'package:flutter/material.dart';

class ReviewServices {
  CollectionReference review = FirebaseFirestore.instance.collection('review');

  Future<void> addReview({Map<String, dynamic>? data}) {
    return review.doc().set(data);
  }
}
