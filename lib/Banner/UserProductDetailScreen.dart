import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Banner/HomeproductModel.dart';
import 'package:ecommerce_app/Banner/ProductBottomsheet.dart';
import 'package:ecommerce_app/Cart/Cart.dart';
import 'package:ecommerce_app/Navigationpages/Homepagenavigation.dart';
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
  String? _selectedSize;

  @override
  void initState() {
    getSize();
    super.initState();
  }

  getSize() {
    if (widget.product!.sizeList != null) {
      setState(() {
        _selectedSize = widget.product!.sizeList![0];
      });
    }
  }

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

            SizedBox(height: 10),

            // to show size list
            if (widget.product!.sizeList != null &&
                widget.product!.sizeList!.isNotEmpty)
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 340),
                    child: Text('Size :',
                        style: TextStyle(
                            fontSize: 20, color: AppColors.buttonnavigation)),
                  ),
                  Container(
                    height: 40,
                    color: const Color(0xFFe2efdd),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: widget.product!.sizeList!.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: _selectedSize == e
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  _selectedSize == e
                                      ? AppColors.buttonnavigation
                                      : Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedSize = e;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 10),
            // to show specification
            Container(
              height: 40,
              color: const Color(0xFFe2efdd),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ProductBottomSheet(
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
            SizedBox(height: 10),

            // to show additional details.
            Container(
              alignment: Alignment.topLeft,
              child: Text('Additional Details :',
                  style: TextStyle(
                      fontSize: 20, color: AppColors.buttonnavigation)),
            ),
            SizedBox(height: 10),
            Text(widget.product!.additionalDetail!,
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 20),
          ],
        )),
      ),
      // to create the are that hold home, query and add to cart button
      bottomSheet: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: AppColors.buttonnavigation),
          )),
          height: 50,
          child: Row(
            children: [
              SizedBox(width: 10),
              //to go to homepage
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Homepagenavigation()));
                },
                child: Column(
                  children: [
                    Icon(Icons.home_filled, color: AppColors.buttonnavigation),
                    Text('Home',
                        style: TextStyle(color: AppColors.buttonnavigation)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VerticalDivider(color: AppColors.buttonnavigation),
              ),
              SizedBox(width: 20),

              //to add Queries
              InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Icon(Icons.chat, color: AppColors.buttonnavigation),
                    Text('Query',
                        style: TextStyle(color: AppColors.buttonnavigation)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VerticalDivider(color: AppColors.buttonnavigation),
              ),
              SizedBox(width: 20),
              //Cartpage(),
            ],
          )),
    );
  }
}
