import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product(
      {this.productName,
      this.storeName,
      this.regularPrice,
      this.salesPrice,
      this.category,
      this.mainCategory,
      this.subCategory,
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
      this.selleruid,
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
            salesPrice:
                json['salesPrice'] == null ? null : json['salesPrice']! as int,
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
            saledate: json['saledate'] == null
                ? null
                : json['saledate']! as Timestamp,
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
            manageDeliveries: json['manageDeliveries'] == null
                ? null
                : json['manageDeliveries']! as bool,
            deliveryCharge: json['deliveryCharge'] == null
                ? null
                : json['deliveryCharge']! as int,
            deliveryLocation: json['deliveryLocation'] == null
                ? null
                : json['deliveryLocation']! as String,
            tags: json['tags'] == null ? null : json['tags']! as String,
            sizeList:
                json['sizeList'] == null ? null : json['sizeList']! as List,
            additionalDetail: json['additionalDetail'] == null
                ? null
                : json['additionalDetail']! as String,
            unit: json['unit'] == null ? null : json['unit']! as String,
            imageUrls: json['imageUrls']! as List,
            selleruid: json['selleruid']! as String,
            approved: json['approved']! as bool);

  final String? productName;
  final String? storeName;
  final int? regularPrice;
  final int? salesPrice;
  final String? category;
  final String? mainCategory;
  final String? subCategory;
  final String? description;
  final Timestamp? saledate;
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
  final String? selleruid;
  final bool? approved;

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'storeName': storeName,
      'regularPrice': regularPrice,
      'salesPrice': salesPrice,
      'category': category,
      'mainCategory': mainCategory,
      'subcategory': subCategory,
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
      'selleruid': selleruid,
      'approved': approved,
    };
  }
}

productQuery({category, String? subCategory}) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('approved', isEqualTo: true)
      .where('category', isEqualTo: category)
      .withConverter<Product>(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
