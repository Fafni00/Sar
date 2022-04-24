import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? name;
  String? description;
  String? producttype;
  String? manufacturer;
  String? price;
  List? tags = [];

  Product();

  // getting data from the server
  Product.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    description = data['description'];
    producttype = data['producttype'];
    manufacturer = data['manufacturer'];
    price = data['price'];
    tags = data['tags'];
  }

  // sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'producttype': producttype,
      'manufacturer': manufacturer,
      'price': price,
      'tags': tags,
    };
  }
}
