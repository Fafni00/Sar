import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/Firebaseservice.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/product_provider.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryTab extends StatefulWidget {
  const DeliveryTab({Key? key}) : super(key: key);

  @override
  State<DeliveryTab> createState() => _DeliveryTabState();
}

class _DeliveryTabState extends State<DeliveryTab>
    with AutomaticKeepAliveClientMixin {
  final FirebaseService _service = FirebaseService();
  bool? _manageDeliveries = false;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(builder: ((context, provider, child) {
      return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            CheckboxListTile(
                activeColor: AppColors.buttonColor.withOpacity(0.9),
                contentPadding: EdgeInsets.zero,
                title: Text('Manage Delieveries',
                    style: TextStyle(
                        color: AppColors.buttonColor.withOpacity(0.9),
                        fontSize: 14)),
                value: _manageDeliveries,
                onChanged: (value) async {
                  setState(() {
                    _manageDeliveries = value;
                    provider.getFormData(manageDeliveries: value);
                  });
                }),
            if (_manageDeliveries == true)
              Column(children: [
                _service.formField(
                    label: 'Delivery Charge',
                    type: TextInputType.text,
                    inputaction: TextInputAction.next,
                    onChanged: (value) {
                      provider.getFormData(
                        deliveryCharge: int.parse(value),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                _service.formField(
                    label: 'Delivery Locations',
                    type: TextInputType.text,
                    inputaction: TextInputAction.done,
                    onChanged: (value) {
                      provider.getFormData(deliveryLocation: value);
                    }),
              ])
          ]));
    }));
  }
}
