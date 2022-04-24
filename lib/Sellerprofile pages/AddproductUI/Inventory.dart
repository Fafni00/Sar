import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/Firebaseservice.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/product_provider.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inventorytab extends StatefulWidget {
  const Inventorytab({Key? key}) : super(key: key);

  @override
  State<Inventorytab> createState() => _InventorytabState();
}

class _InventorytabState extends State<Inventorytab>
    with AutomaticKeepAliveClientMixin {
  final FirebaseService _service = FirebaseService();
  bool? _manageInventory = false;
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(builder: ((context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _service.formField(
                label: 'SKU',
                type: TextInputType.text,
                onChanged: (value) {
                  provider.getFormData(sku: value);
                }),
            CheckboxListTile(
                activeColor: AppColors.buttonColor.withOpacity(0.9),
                contentPadding: EdgeInsets.zero,
                title: Text('manage Store Inventory',
                    style: TextStyle(
                        color: AppColors.buttonColor.withOpacity(0.9),
                        fontSize: 14)),
                value: _manageInventory,
                onChanged: (value) {
                  setState(() {
                    _manageInventory = value;
                    provider.getFormData(manageInventory: value);
                  });
                }),
            if (_manageInventory == true)
              Column(
                children: [
                  _service.formField(
                      label: 'Stock on hand',
                      type: TextInputType.number,
                      onChanged: (value) {
                        provider.getFormData(
                          stockonhand: int.parse(value),
                        );
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  _service.formField(
                      label: 'Re-Order Level ',
                      type: TextInputType.number,
                      onChanged: (value) {
                        provider.getFormData(
                          reOrderLevel: int.parse(value),
                        );
                      }),
                ],
              )
          ],
        ),
      );
    }));
  }
}
