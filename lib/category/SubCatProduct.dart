import 'package:ecommerce_app/category/SubCategories.dart';
import 'package:ecommerce_app/category/subcatgorylist.dart';
import 'package:flutter/material.dart';

class SubCatProduct extends StatelessWidget {
  const SubCatProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: SubProductList(),
    );
  }
}
