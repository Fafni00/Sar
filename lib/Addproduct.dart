// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:io';

import 'package:ecommerce_app/Model/addproduct.dart';
import 'package:ecommerce_app/Model/productapi.dart';
import 'package:ecommerce_app/Model/productnotifier.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Sellerprofile pages/Drawer.dart';

class AddProductpage extends StatefulWidget {
  final bool isUpdating;
  AddProductpage({required this.isUpdating});

  @override
  State<AddProductpage> createState() => _AddProductpageState();
}

class _AddProductpageState extends State<AddProductpage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _tags = [];
  late Product _currentProduct;
  TextEditingController tagController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    _currentProduct = Product();
  }

  //to create the textformfield
  Widget _buildNameField() {
    return TextFormField(
        autofocus: false,
        initialValue: _currentProduct.name,
        keyboardType: TextInputType.name,
        //validator
        validator: (value) {
          if (value!.isEmpty) {
            return ("Product name is required");
          }
          return null;
        },
        onSaved: (value) {
          _currentProduct.name = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          //for focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
        ));
  }

  //to create the textformfield
  Widget _buildDescriptionField() {
    return TextFormField(
        autofocus: false,
        initialValue: _currentProduct.description,
        keyboardType: TextInputType.text,
        maxLines: null,

        //validator
        validator: (value) {
          if (value!.isEmpty) {
            return ("Product description id required");
          }
          return null;
        },
        onSaved: (value) {
          _currentProduct.description = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          //for focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
        ));
  }

  //to create the textformfield
  Widget _buildProducttypeField() {
    return TextFormField(
        autofocus: false,
        initialValue: _currentProduct.producttype,
        keyboardType: TextInputType.text,

        //validator
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please specify a product type");
          }
          return null;
        },
        onSaved: (value) {
          _currentProduct.producttype = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          //for focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
        ));
  }

  //to create the textformfield
  Widget _buildManufacturerField() {
    return TextFormField(
        autofocus: false,
        initialValue: _currentProduct.manufacturer,
        keyboardType: TextInputType.text,

        //validator
        validator: (value) {
          if (value!.isEmpty) {
            return ("Manufacturer name id required");
          }
          return null;
        },
        onSaved: (value) {
          _currentProduct.manufacturer = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          //for focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
        ));
  }

  //to create the textformfield
  Widget _buildPriceField() {
    return TextFormField(
        autofocus: false,
        initialValue: _currentProduct.price,
        keyboardType: TextInputType.text,

        //validator
        validator: (value) {
          if (value!.isEmpty) {
            return ("price is required");
          }
          return null;
        },
        onSaved: (value) {
          _currentProduct.price = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          //for focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
        ));
  }

  //to create the textformfield for tag
  _buildTagField() {
    return SizedBox(
      width: 200,
      child: TextField(
        keyboardType: TextInputType.text,
        controller: tagController,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          border: InputBorder.none,
          fillColor: Colors.white,
          filled: true,
          //for focused border
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(),
              borderSide: BorderSide(
                width: 3.0,
                color: AppColors.textboxColor,
              )),
        ),
      ),
    );
  }

  //to add tags
  _addTag(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _tags.add(text);
      });
      tagController.clear();
    }
  }

  //to save the form
  _saveProduct() {
    print('saveProduct Called');
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    print('form saved');

    _currentProduct.tags = _tags;

    uploadProduct(_currentProduct, widget.isUpdating);

    print(" name ${_currentProduct.name}");
    print(" description ${_currentProduct.description}");
    print(" producttype ${_currentProduct.producttype}");
    print(" manufacturer ${_currentProduct.manufacturer}");
    print(" price ${_currentProduct.price}");
    print(" tag ${_currentProduct.tags.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SellerDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //to create the app bar back button and title
            AppBar(
              title: Text("Sār",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              backgroundColor: Color(0xFF056608),
            ),

            SizedBox(height: 20),
            // to create the page title
            Text('Add Product',
                style: TextStyle(
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  color: AppColors.buttonColor,
                )),

            SizedBox(height: 10),

            //to create the form n the page
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                color: AppColors.breadcrumbColor.withOpacity(0.1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 250,
                padding: EdgeInsets.only(left: 10, right: 10),
                //to create the title section
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    //to create title
                    Container(
                      margin: EdgeInsets.only(right: 260, left: 10),
                      child: Text(' Product Title',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.buttonColor,
                          )),
                    ),
                    // to create a line under the title
                    Container(
                      margin: EdgeInsets.only(right: 260, left: 10),
                      height: 3,
                      width: 140,
                      color: AppColors.buttonbackgroundColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buildNameField(),
                    SizedBox(
                      height: 20,
                    ),

                    //to create title
                    Container(
                      margin: EdgeInsets.only(right: 210, left: 10),
                      child: Text(' Product Description',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.buttonColor,
                          )),
                    ),
                    // to create a line under the title
                    Container(
                      margin: EdgeInsets.only(right: 210, left: 10),
                      height: 3,
                      width: 180,
                      color: AppColors.buttonbackgroundColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buildDescriptionField(),
                    SizedBox(
                      height: 20,
                    ),

                    //to create title
                    Container(
                      margin: EdgeInsets.only(right: 250, left: 10),
                      child: Text('Product Type',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.buttonColor,
                          )),
                    ),
                    // to create a line under the title
                    Container(
                      margin: EdgeInsets.only(right: 255, left: 10),
                      height: 3,
                      width: 140,
                      color: AppColors.buttonbackgroundColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buildProducttypeField(),
                    SizedBox(
                      height: 20,
                    ),

                    //to create title
                    Container(
                      margin: EdgeInsets.only(right: 250, left: 10),
                      child: Text('Manufacturer',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.buttonColor,
                          )),
                    ),
                    // to create a line under the title
                    Container(
                      margin: EdgeInsets.only(right: 250, left: 10),
                      height: 3,
                      width: 140,
                      color: AppColors.buttonbackgroundColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buildManufacturerField(),
                    SizedBox(
                      height: 20,
                    ),

                    //to create title
                    Container(
                      margin: EdgeInsets.only(right: 310, left: 10),
                      child: Text(' Price',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.buttonColor,
                          )),
                    ),
                    // to create a line under the title
                    Container(
                      margin: EdgeInsets.only(right: 310, left: 10),
                      height: 3,
                      width: 140,
                      color: AppColors.buttonbackgroundColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buildPriceField(),
                    SizedBox(
                      height: 20,
                    ),

                    //to create the row for tag section
                    Container(
                      margin: EdgeInsets.only(right: 320, left: 10),
                      child: Text('Tags',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.buttonColor,
                          )),
                    ),
                    // to create a line under the title
                    Container(
                      margin: EdgeInsets.only(right: 320, left: 10),
                      height: 3,
                      width: 120,
                      color: AppColors.buttonbackgroundColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //to create title
                        _buildTagField(),
                        ButtonTheme(
                            child: RaisedButton(
                                child: Text('Add'),
                                color: AppColors.buttonColor,
                                onPressed: () => _addTag(tagController.text))),
                      ],
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(8),
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: _tags
                          .map((tag) => Card(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),

                    // to create add product button
                    ButtonTheme(
                        child: RaisedButton(
                            child: Text('Add Product'),
                            color: AppColors.buttonColor,
                            onPressed: () => _saveProduct())),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
