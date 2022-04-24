import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider with ChangeNotifier {
  Map<String, dynamic>? productData = {'approved': false};
  List<XFile>? imageFiles = [];

  getFormData(
      {String? productName,
      String? storeName,
      int? regularPrice,
      int? salesPrice,
      String? category,
      String? mainCategory,
      String? description,
      DateTime? saledate,
      String? sku,
      bool? manageInventory,
      int? stockonhand,
      int? reOrderLevel,
      bool? manageDeliveries,
      int? deliveryCharge,
      String? deliveryLocation,
      String? tags,
      List? sizeList,
      String? additionalDetail,
      String? unit,
      List? imageUrls,
      Map<String, dynamic>? vendor}) {
    if (vendor != null) {
      productData!['vendor'] = vendor;
    }
    if (productName != null) {
      productData!['productName'] = productName;
    }
    if (storeName != null) {
      productData!['storeName'] = storeName;
    }
    if (salesPrice != null) {
      productData!['salesPrice'] = salesPrice;
    }
    if (category != null) {
      productData!['category'] = category;
    }
    if (mainCategory != null) {
      productData!['mainCategory'] = mainCategory;
    }
    if (description != null) {
      productData!['description'] = description;
    }
    if (saledate != null) {
      productData!['saledate'] = saledate;
    }
    if (sku != null) {
      productData!['sku'] = sku;
    }
    if (manageInventory != null) {
      productData!['manageInventory'] = manageInventory;
    }
    if (stockonhand != null) {
      productData!['stockonhand'] = stockonhand;
    }
    if (reOrderLevel != null) {
      productData!['reOrderLevel'] = reOrderLevel;
    }
    if (manageDeliveries != null) {
      productData!['manageDeliveries'] = manageDeliveries;
    }
    if (deliveryCharge != null) {
      productData!['deliveryCharge'] = deliveryCharge;
    }
    if (deliveryLocation != null) {
      productData!['deliveryLocation'] = deliveryLocation;
    }
    if (tags != null) {
      productData!['tags'] = tags;
    }
    if (sizeList != null) {
      productData!['sizeList'] = sizeList;
    }
    if (additionalDetail != null) {
      productData!['additionalDetail'] = additionalDetail;
    }
    if (unit != null) {
      productData!['unit'] = unit;
    }
    if (imageUrls != null) {
      productData!['imageUrls'] = imageUrls;
    }

    notifyListeners();
  }

  getImageFile(image) {
    imageFiles!.add(image);
    notifyListeners();
  }

  clearProductData() {
    productData!.clear();
    imageFiles!.clear();
    productData!['approve'] = false;
    notifyListeners();
  }
}
