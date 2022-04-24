import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class UnpublishedProducts extends StatelessWidget {
  const UnpublishedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Product>(
      query: productQuery(false),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                Product product = snapshot.docs[index].data();
                return ListTile(
                  title: Text(product.productName!),
                );
              }),
        );
      },
    );
  }
}
