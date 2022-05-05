import 'package:ecommerce_app/Model/SellerProductModel.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class SellerBottomSheet extends StatelessWidget {
  final Product? product;
  const SellerBottomSheet({this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _customContainer({String? head, String? details}) {
      return Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(head!,
              style:
                  TextStyle(fontSize: 20, color: AppColors.buttonnavigation)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.circle, color: AppColors.buttonnavigation, size: 17),
                SizedBox(width: 10),
                Text(details!, style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
        ],
      ));
    }

    return Container(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: AppColors.buttonnavigation,
              automaticallyImplyLeading: false,
              title: Text('Specifications', style: TextStyle(fontSize: 20)),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product!.sku != null) SizedBox(width: 10),
                  _customContainer(head: 'SKU', details: product!.sku),
                  SizedBox(height: 16),
                  if (product!.unit != null)
                    _customContainer(head: 'Unit', details: product!.unit),
                ],
              ),
            ),
          ],
        ));
  }
}
