import 'dart:collection';

import 'package:ecommerce_app/Model/addproduct.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier with ChangeNotifier {
  List<Product> _productList = [];
  late Product _currentProduct;

  UnmodifiableListView<Product> get productList =>
      UnmodifiableListView(_productList);

  Product get currentProduct => _currentProduct;

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  set currentProduct(Product product) {
    _productList = product as List<Product>;
    notifyListeners();
  }
}
