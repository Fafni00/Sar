import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Provider/CartProvider.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String id = 'cart-screen';
  final DocumentSnapshot? document;
  const CartScreen({
    this.document,
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    final mediaQueary = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Container(
          height: 60,
          color: AppColors.buttonColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs.${_cartProvider.subTotal.toStringAsFixed(0)}',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {},
                      child: const Text('Checkout',
                          style: TextStyle(fontSize: 18, color: Colors.white)))
                ],
              ),
            ),
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(userId)
            .collection('products')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
          final cartData = snapshots.data?.docs;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              title: const Text('My Cart'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.only(top: 15),
              itemCount: cartData?.length ?? 0,
              itemBuilder: (ctx, index) {
                final data = cartData?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(10, 10),
                          blurRadius: 50,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: data?['img'] ?? '',
                            height: mediaQueary.height / 6,
                            width: mediaQueary.width / 3,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            cartProductDetail(
                              'Product Name',
                              '${data?['productName']}',
                            ),
                            cartProductDetail(
                              'Product Qty',
                              '${data?['qty']}',
                            ),
                            cartProductDetail(
                              'From Store',
                              '${data?['storeName']}',
                            ),
                            cartProductDetail(
                              'Price Per Product',
                              '${data?['price']}',
                            ),
                            cartProductDetail(
                              'Total NP\'r',
                              '${data?['price']}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
            ),
          );
        },
      ),
    );
  }

  Widget cartProductDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(detail),
        ],
      ),
    );
  }
}
