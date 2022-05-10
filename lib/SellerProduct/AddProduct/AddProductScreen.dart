// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ecommerce_app/Provider/ProductProvider.dart';
import 'package:ecommerce_app/SellerProduct/AddProduct/component/AddProductImage.dart';
import 'package:ecommerce_app/SellerProduct/AddProduct/component/GeneralProduct.dart';
import 'package:ecommerce_app/SellerProduct/AddProduct/component/Inventorytab.dart';
import 'package:ecommerce_app/SellerProduct/AddProduct/component/ProductAttributes.dart';

import 'package:ecommerce_app/SellerProfile/SellerProfileSection.dart';
import 'package:ecommerce_app/Services/AddProductService.dart';

import 'package:ecommerce_app/Provider/SellerProvider.dart';

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
    AddProductService _service = AddProductService();
    return Form(
        key: _formkey,
        child: DefaultTabController(
            length: 4,
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
                              EasyLoading.show(status: 'Please wait...');
                              //to get the formdata save in productprovider
                              _provider.getFormData(
                                selleruid: _service.user!.uid,
                              );
                              //to upload the image files to the firestore
                              _service
                                  .uploadFiles(
                                      images: _provider.imageFiles,
                                      ref:
                                          'products/${_seller.seller!.storeName}/${_provider.productData!['productName']}',
                                      provider: _provider)
                                  .then(
                                (value) {
                                  // to save files in the database
                                  if (value.isNotEmpty) {
                                    _service.saveTodb(
                                        data: _provider.productData,
                                        context: context);
                                    EasyLoading.dismiss();
                                    _provider.clearProductData();
                                  }
                                },
                              );
                            }
                          }))
                ])));
  }
}
