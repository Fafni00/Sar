import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Banner/ProductBottomsheet.dart';
import 'package:ecommerce_app/SellerHomepage/SellerBottomSheet.dart';
import 'package:ecommerce_app/SellerHomepage/SellerProductModel.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:ecommerce_app/category/Firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SellerProductDetail extends StatefulWidget {
  final Product? product;
  final String? productID;

  const SellerProductDetail({Key? key, this.product, this.productID})
      : super(key: key);

  @override
  State<SellerProductDetail> createState() => _SellerProductDetailState();
}

class _SellerProductDetailState extends State<SellerProductDetail> {
  final FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.buttonnavigation,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(widget.product!.productName!),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            SizedBox(height: 10),
            //to show product image
            Container(
              height: 200,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.product!.imageUrls![0],
                    child: PageView(
                      children: widget.product!.imageUrls!.map(
                        (e) {
                          return CachedNetworkImage(
                              imageUrl: e, fit: BoxFit.contain);
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            //to show product Name
            Text(widget.product!.productName!,
                style:
                    TextStyle(fontSize: 19, color: AppColors.buttonnavigation)),
            SizedBox(height: 10),

            //to show product price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Rs: ${_service.formattedNumber(widget.product!.regularPrice)}',
                      style: TextStyle(
                          fontSize: 16, color: AppColors.buttonnavigation))
                ],
              ),
            ),
            SizedBox(height: 5),

            Divider(color: AppColors.buttonnavigation),
            // to show storeName
            Row(
              children: [
                Expanded(
                  child: Text('Store Name :',
                      style: TextStyle(
                          fontSize: 17, color: AppColors.buttonnavigation)),
                ),
                Row(
                  children: [
                    Text(widget.product!.storeName!,
                        style: TextStyle(
                            fontSize: 18, color: AppColors.buttonnavigation)),
                  ],
                ),
              ],
            ),

            Divider(color: AppColors.buttonnavigation),

            SizedBox(height: 10),
            // to show product decsription
            Container(
              alignment: Alignment.topLeft,
              child: Text('Product Description :',
                  style: TextStyle(
                      fontSize: 20, color: AppColors.buttonnavigation)),
            ),
            SizedBox(height: 10),
            Text(widget.product!.description!,
                style: TextStyle(fontSize: 16, color: Colors.black)),

            SizedBox(height: 30),

            // to show size list
            Container(
                color: const Color(0xFFe2efdd),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Size :', style: TextStyle(fontSize: 18)),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                      widget.product!.sizeList!.toString(),
                                      style: TextStyle(fontSize: 18))),
                            ],
                          ),
                        ),
                      ])
                    ]))),

            SizedBox(height: 30),

            // to show specification
            Container(
              height: 40,
              color: const Color(0xFFe2efdd),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SellerBottomSheet(
                          product: widget.product,
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Specifications',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.buttonnavigation,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // to show additional details.
            Container(
              child: Text('Additional Details :',
                  style: TextStyle(
                      fontSize: 20, color: AppColors.buttonnavigation)),
            ),
            SizedBox(height: 10),
            Text(widget.product!.additionalDetail!,
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 20),
          ],
        ))));
  }
}
