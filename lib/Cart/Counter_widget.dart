import 'package:ecommerce_app/Cart/Cartservices.dart';
import 'package:flutter/material.dart';

import '../Banner/HomeproductModel.dart';

class CounterWidget extends StatefulWidget {
  final Product? product;
  final String? productID;
  CounterWidget(this.product, this.productID);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
