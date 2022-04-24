// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/product_provider.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/Deliveries.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/Firebaseservice.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/General.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/Inventory.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/ProductAttribute.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/ProductImage.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/SellerProfileSection.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/Sellerprovider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = 'aproduct';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductProvider>(context);
    final _seller = Provider.of<SellerProvider>(context);
    FirebaseService _service = FirebaseService();
    return Form(
        key: _formkey,
        child: DefaultTabController(
            length: 5,
            initialIndex: 0,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF056608),
                  elevation: 0,
                  title: const Text('Add New Products'),
                  bottom: TabBar(
                      isScrollable: true,
                      indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(width: 4, color: Colors.white)),
                      tabs: [
                        Tab(
                          child: Text('General'),
                        ),
                        Tab(
                          child: Text('Inventory'),
                        ),
                        Tab(
                          child: Text('Deliveries'),
                        ),
                        Tab(
                          child: Text('Product Attributes'),
                        ),
                        Tab(
                          child: Text('Add Product Image'),
                        ),
                      ]),
                ),
                drawer: SellerProfileSection(),
                body: TabBarView(
                  children: [
                    GeneralProduct(),
                    Inventorytab(),
                    DeliveryTab(),
                    ProductAttributes(),
                    AddProductImage()
                  ],
                ),
                persistentFooterButtons: [
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                          child: Text('Save Product'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF056608))),
                          onPressed: () {
                            if (_provider.imageFiles!.isEmpty) {
                              _service.scaffold(context, 'Images not Selected');
                              return;
                            }
                            if (_formkey.currentState!.validate()) {
                              EasyLoading.show(status: 'Please Wait...');
                              //to get the formdata save in productprovider
                              _provider.getFormData(vendor: {
                                'name': _seller.seller!.storeName,
                                'uid': _service.user!.uid,
                              });
                              //to upload the image files to the firestore
                              _service
                                  .uploadFiles(
                                      images: _provider.imageFiles,
                                      ref:
                                          'products/${_seller.seller!.storeName}',
                                      provider: _provider)
                                  .then(
                                (value) {
                                  // to save files in the database
                                  if (value.isNotEmpty) {
                                    _service
                                        .saveTodb(
                                            data: _provider.productData,
                                            context: context)
                                        .then((value) {
                                      setState(() {
                                        //to dismiss the easyloading sign after saving data
                                        EasyLoading.dismiss();
                                        //to clear the form after data is submitted
                                        // _provider.clearProductData();
                                      });
                                    });
                                  }
                                },
                              );
                            }
                          }))
                ])));
  }
}
