import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/Firebaseservice.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/ProductCard.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../Utils/Colors.dart';

class UnpublishedProducts extends StatelessWidget {
  const UnpublishedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseService _service = FirebaseService();
    return FirestoreQueryBuilder<Product>(
        query: productQuery(false),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }
          return ProductCard(
            snapshot: snapshot,
          );
        });
  }
}
