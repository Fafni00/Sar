import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/SellerHome/components/SellerProductDisplay/SellerProductDetail.dart';
import 'package:ecommerce_app/Model/SellerProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class SellerHomeProductList extends StatelessWidget {
  final String? category;
  const SellerHomeProductList({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Product>(
      query: productQuery(category: category),
      builder: (context, snapshot, _) {
        // ...

        return GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1 / 1.40),
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
                              SellerProductDetail(
                                productID: productID,
                                product: product,
                              )));
                },
                child: Container(
                  height: 80,
                  width: 80,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 100,
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
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
