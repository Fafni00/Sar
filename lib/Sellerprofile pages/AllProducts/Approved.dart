import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/Firebaseservice.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Productcard.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../Utils/Colors.dart';

class ApprovedProducts extends StatelessWidget {
  const ApprovedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseService _service = FirebaseService();
    return FirestoreQueryBuilder<Product>(
        query: productQuery(true),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }
          if (snapshot.docs.isEmpty) {
            return Center(child: Text('No Published Products'));
          }
          return ProductCard(snapshot: snapshot);
        });
  }
}
