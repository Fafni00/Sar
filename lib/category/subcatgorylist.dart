import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Banner/UserProductDetailScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'Category Model/subcatproductmodel.dart';

class SubProductList extends StatelessWidget {
  final String? subCategory;
  const SubProductList({Key? key, this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreQueryBuilder<Product>(
        query: productQuery(subCategory: subCategory),
        builder: (context, snapshot, _) {
          // ...

          return GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1 / 1.20),
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              // if we reached the end of the currently obtained items, we try to
              // obtain more items
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                // Tell FirestoreQueryBuilder to try to obtain more items.
                // It is safe to call this function from within the build method.
                snapshot.fetchMore();
              }

              var productIndex = snapshot.docs[index];
              final product = productIndex.data();
              String productID = productIndex.id;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UserProductDetail()));
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            offset: Offset(5, 5),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          BoxShadow(
                            blurRadius: 3,
                            offset: Offset(-5, -5),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ]),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 80,
                            width: 90,
                            child: Hero(
                              tag: product.imageUrls![0],
                              child: CachedNetworkImage(
                                  imageUrl: product.imageUrls![0],
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Text(product.productName!,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
