import 'package:ecommerce_app/SellerProduct/AllProduct/Components/ProductCard.dart';
import 'package:ecommerce_app/Services/AddProductService.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../Model/AllProductModel.dart';

class ApprovedProducts extends StatelessWidget {
  const ApprovedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddProductService _service = AddProductService();
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
