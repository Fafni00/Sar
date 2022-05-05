import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/SellerProduct/AllProduct/Components/ProductDetail.dart';

import 'package:ecommerce_app/Services/AddProductService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../Model/AllProductModel.dart';
import '../../../Services/AddProductService.dart';
import '../../../Utils/Colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.snapshot}) : super(key: key);

  final FirestoreQueryBuilderSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    AddProductService _service = AddProductService();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              Product product = snapshot.docs[index].data();
              String id = snapshot.docs[index].id;
              return Slidable(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext) => ProductDetail(
                                  product: product,
                                  productId: id,
                                )));
                  },
                  child: Card(
                      shadowColor: AppColors.breadcrumbColor,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 80,
                                width: 80,
                                child: CachedNetworkImage(
                                  imageUrl: product.imageUrls![0],
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.productName!),
                                SizedBox(height: 5),
                                Text(_service
                                    .formattedNumber(product.regularPrice))
                              ],
                            ),
                          ])),
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 1,
                      onPressed: (context) {},
                      backgroundColor: Colors.red.withOpacity(0.8),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      flex: 1,
                      onPressed: (context) {
                        _service.products.doc(id).update({
                          'approved': product.approved == false ? true : false
                        });
                      },
                      backgroundColor: AppColors.breadcrumbColor,
                      foregroundColor: Colors.white,
                      icon: Icons.approval_rounded,
                      label: product.approved == false ? 'Approve' : 'Inactive',
                    ),
                  ],
                ),
              );
            }));
  }
}
