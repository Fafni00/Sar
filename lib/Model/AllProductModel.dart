import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Product {
  Product(
      {this.productName,
      this.storeName,
      this.regularPrice,
      this.category,
      this.mainCategory,
      this.subCategory,
      this.description,
      this.sku,
      this.manageInventory,
      this.stockonhand,
      this.reOrderLevel,
      this.tags,
      this.sizeList,
      this.additionalDetail,
      this.unit,
      this.imageUrls,
      this.vendor,
      this.approved});

  Product.fromJson(Map<String, Object?> json)
      : this(
            productName: json['productName'] == null
                ? null
                : json['productName']! as String,
            storeName:
                json['storeName'] == null ? null : json['storeName']! as String,
            regularPrice: json['regularPrice'] == null
                ? null
                : json['regularPrice']! as int,
            category:
                json['category'] == null ? null : json['category']! as String,
            mainCategory: json['mainCategory'] == null
                ? null
                : json['mainCategory']! as String,
            subCategory: json['subCategory'] == null
                ? null
                : json['mainCategory']! as String,
            description: json['description'] == null
                ? null
                : json['description']! as String,
            sku: json['sku'] == null ? null : json['sku']! as String,
            manageInventory: json['manageInventory'] == null
                ? null
                : json['manageInventory']! as bool,
            stockonhand: json['stockonhand'] == null
                ? null
                : json['stockonhand']! as int,
            reOrderLevel: json['reOrderLevel'] == null
                ? null
                : json['reOrderLevel']! as int,
            sizeList:
                json['sizeList'] == null ? null : json['sizeList']! as List,
            additionalDetail: json['additionalDetail'] == null
                ? null
                : json['additionalDetail']! as String,
            unit: json['unit'] == null ? null : json['unit']! as String,
            imageUrls: json['imageUrls']! as List,
            vendor: json['vendor']! as Map,
            approved: json['approved']! as bool);

  final String? productName;
  final String? storeName;
  final int? regularPrice;
  final String? category;
  final String? mainCategory;
  final String? subCategory;
  final String? description;
  final String? sku;
  final bool? manageInventory;
  final int? stockonhand;
  final int? reOrderLevel;
  final String? tags;
  final List? sizeList;
  final String? additionalDetail;
  final String? unit;
  final List? imageUrls;
  final Map? vendor;
  final bool? approved;

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'storeName': storeName,
      'regularPrice': regularPrice,
      'category': category,
      'mainCategory': mainCategory,
      'subcategory': subCategory,
      'description': description,
      'sku': sku,
      'manageInventory': manageInventory,
      'stockonhand': stockonhand,
      'reOrderLevel': reOrderLevel,
      'tags': tags,
      'sizeList': sizeList,
      'additionalDetail': additionalDetail,
      'unit': unit,
      'imageUrls': imageUrls,
      'vendor': vendor,
      'approved': approved,
    };
  }
}

User? user = FirebaseAuth.instance.currentUser;
productQuery(approved) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .orderBy('productName')
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
