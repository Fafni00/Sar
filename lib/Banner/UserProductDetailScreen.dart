import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/Banner/HomeproductModel.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:ecommerce_app/category/Firebase_service.dart';
import 'package:flutter/material.dart';

class UserProductDetail extends StatefulWidget {
  final Product? product;
  final String? productID;

  const UserProductDetail({Key? key, this.product, this.productID})
      : super(key: key);

  @override
  State<UserProductDetail> createState() => _UserProductDetailState();
}

class _UserProductDetailState extends State<UserProductDetail> {
  final FirebaseService _service = FirebaseService();
  int? pageNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.buttonnavigation,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(widget.product!.productName!),
          actions: [
            CircleAvatar(
                backgroundColor: const Color(0xFFe2efdd).withOpacity(0.3),
                radius: 17,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )),
            SizedBox(width: 10),
            CircleAvatar(
                backgroundColor: const Color(0xFFe2efdd).withOpacity(0.3),
                radius: 17,
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                )),
            SizedBox(width: 10),
          ]),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          //to show product image
          Container(
            height: 400,
            child: Stack(
              children: [
                PageView(
                  onPageChanged: ((value) {
                    setState(() {
                      pageNumber = value;
                    });
                  }),
                  children: widget.product!.imageUrls!.map(
                    (e) {
                      return CachedNetworkImage(imageUrl: e, fit: BoxFit.cover);
                    },
                  ).toList(),
                ),
                // Positioned(
                //     bottom: 10,
                //     right: MediaQuery.of(context).size.width / 2.3,
                //     child: CircleAvatar(
                //         radius: 20,
                //         backgroundColor:
                //             AppColors.buttonColor.withOpacity(0.5),
                //         child: Text('${pageNumber! + 1}')))
              ],
            ),
          ),
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
          //to show product Name
          Text(widget.product!.productName!,
              style:
                  TextStyle(fontSize: 19, color: AppColors.buttonnavigation)),
          SizedBox(height: 10),

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

          SizedBox(height: 20),
          // to show product decsription
          Container(
            alignment: Alignment.topLeft,
            child: Text('Product Description :',
                style:
                    TextStyle(fontSize: 20, color: AppColors.buttonnavigation)),
          ),
          SizedBox(height: 10),
          Text(widget.product!.description!,
              style:
                  TextStyle(fontSize: 16, color: AppColors.buttonnavigation)),
          SizedBox(height: 20),
          // to show specification
          Container(
            height: 40,
            color: const Color(0xFFe2efdd),
            child: InkWell(
              onTap: (() {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return Container();
                          });
                    });
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Spefications',
                    style: TextStyle(
                        fontSize: 16, color: AppColors.buttonnavigation),
                  ),
                  Icon(
                    Icons.arrow_right,
                    size: 50,
                    color: AppColors.buttonnavigation,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          // to show product decsription
          Container(
            alignment: Alignment.topLeft,
            child: Text('Additional Details :',
                style:
                    TextStyle(fontSize: 20, color: AppColors.buttonnavigation)),
          ),
          SizedBox(height: 10),
          Text(widget.product!.additionalDetail!,
              style:
                  TextStyle(fontSize: 16, color: AppColors.buttonnavigation)),
          SizedBox(height: 20),
        ],
      )),
      bottomSheet: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: AppColors.buttonnavigation),
          )),
          height: 60,
          child: Row(
            children: [
              Icon(Icons.arrow_back),
            ],
          )),
    );
  }
}
