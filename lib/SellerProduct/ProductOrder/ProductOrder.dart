import 'package:flutter/material.dart';

class ProductOrder extends StatelessWidget {
  static const String id = 'product order';
  const ProductOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Order Screen')),
    );
  }
}
