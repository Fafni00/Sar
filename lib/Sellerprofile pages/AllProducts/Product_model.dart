import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product(
      {this.productName,
      this.storeName,
      this.regularPrice,
      this.salesPrice,
      this.category,
      this.mainCategory,
      this.description,
      this.saledate,
      this.sku,
      this.manageInventory,
      this.stockonhand,
      this.reOrderLevel,
      this.manageDeliveries,
      this.deliveryCharge,
      this.deliveryLocation,
      this.tags,
      this.sizeList,
      this.additionalDetail,
      this.unit,
      this.imageUrls,
      this.vendor,
      this.approved});

  Product.fromJson(Map<String, Object?> json)
      : this(
            productName: json['productName']! as String,
            storeName: json['storeName']! as String,
            regularPrice: json['regularPrice']! as int,
            salesPrice: json['salesPrice']! as int,
            category: json['category']! as String,
            mainCategory: json['mainCategory']! as String,
            description: json['description']! as String,
            saledate: json['saledate']! as DateTime,
            sku: json['sku']! as String,
            manageInventory: json['manageInventory']! as bool,
            stockonhand: json['stockonhand']! as int,
            reOrderLevel: json['reOrderLevel']! as int,
            manageDeliveries: json['manageDeliveries']! as bool,
            deliveryCharge: json['deliveryCharge']! as int,
            deliveryLocation: json['deliveryLocation']! as String,
            tags: json['tags']! as String,
            sizeList: json['sizeList']! as List,
            additionalDetail: json['additionalDetail']! as String,
            unit: json['unit']! as String,
            imageUrls: json['imageUrls']! as List,
            vendor: json['vendor']! as Map,
            approved: json['approved']! as bool);

  final String? productName;
  final String? storeName;
  final int? regularPrice;
  final int? salesPrice;
  final String? category;
  final String? mainCategory;
  final String? description;
  final DateTime? saledate;
  final String? sku;
  final bool? manageInventory;
  final int? stockonhand;
  final int? reOrderLevel;
  final bool? manageDeliveries;
  final int? deliveryCharge;
  final String? deliveryLocation;
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
      'salesPrice': salesPrice,
      'category': category,
      'mainCategory': mainCategory,
      'description': description,
      'saledate': saledate,
      'sku': sku,
      'manageInventory': manageInventory,
      'stockonhand': stockonhand,
      'reOrderLevel': reOrderLevel,
      'manageDeliveries': manageDeliveries,
      'deliveryCharge': deliveryCharge,
      'deliveryLocation': deliveryLocation,
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

productQuery(approved) {
  FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: approved)
      .orderBy('productName')
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
