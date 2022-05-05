// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Services/AddProductService.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../Model/AllProductModel.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;
  final String? productId;

  const ProductDetail({this.product, this.productId, Key? key})
      : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final AddProductService _service = AddProductService();
  bool _editable = true;
  final _formKey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _regularPrice = TextEditingController();
  final _description = TextEditingController();
  final _stockonhand = TextEditingController();
  final _reOrderLevel = TextEditingController();
  final _deliveryCharge = TextEditingController();
  final _deliveryLocation = TextEditingController();
  final _additionalDetail = TextEditingController();
  DateTime? saledate;
  bool? manageInventory;
  bool? manageDeliveries;

  Widget _textField({
    TextEditingController? controller,
    String? label,
    TextInputType? inputType,
    int? maxLine,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLine,
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter $label';
        }
      },
    );
  }

  updateProduct() {
    EasyLoading.show();
    _service.products.doc(widget.productId).update({
      'productName': _productName.text,
      'description': _description.text,
      'regularPrice': int.parse(_regularPrice.text),
      'manageInventory': manageInventory,
      'stockonhand': int.parse(_stockonhand.text),
      'reOrderLevel': int.parse(_reOrderLevel.text),
      'manageDeliveries': manageDeliveries,
      'deliveryCharge': int.parse(_deliveryCharge.text),
      'deliveryLocation': _deliveryLocation.text,
      'additionalDetail': _additionalDetail.text
    }).then((value) {
      setState(() {
        _editable = true;
      });

      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    setState(() {
      _productName.text = widget.product?.productName != null
          ? widget.product!.productName.toString()
          : ' ';
      _regularPrice.text = widget.product?.regularPrice != null
          ? widget.product!.regularPrice.toString()
          : ' ';
      _description.text = widget.product?.description != null
          ? widget.product!.description.toString()
          : ' ';
      _stockonhand.text = widget.product?.stockonhand != null
          ? widget.product!.stockonhand.toString()
          : ' ';
      _reOrderLevel.text = widget.product?.reOrderLevel != null
          ? widget.product!.reOrderLevel.toString()
          : ' ';
      _deliveryCharge.text = widget.product?.deliveryCharge != null
          ? widget.product!.deliveryCharge.toString()
          : ' ';
      _deliveryLocation.text = widget.product?.deliveryLocation != null
          ? widget.product!.deliveryLocation.toString()
          : ' ';
      _additionalDetail.text = widget.product?.additionalDetail != null
          ? widget.product!.additionalDetail.toString()
          : ' ';
      manageInventory = widget.product!.manageInventory;
      manageDeliveries = widget.product!.manageDeliveries;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: Color(0xFFFAF9F6),
          appBar: AppBar(
            actions: [
              _editable
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          _editable = false;
                        });
                      })
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateProduct();
                            }
                          }),
                    )
            ],
            elevation: 3,
            title: Text(widget.product!.productName!),
            backgroundColor: Color(0xFF056608),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                AbsorbPointer(
                  absorbing: _editable,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: widget.product!.imageUrls!.map((e) {
                            return Padding(
                              // to show product image
                              padding: const EdgeInsets.all(3.0),
                              child: CachedNetworkImage(imageUrl: e),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // to show product name
                      _textField(
                          label: 'Product Name',
                          inputType: TextInputType.text,
                          controller: _productName),
                      SizedBox(height: 10),

                      // to show product category
                      Row(children: [
                        Text('Category :'),
                        SizedBox(width: 20),
                        Text(
                          widget.product!.category!,
                          style: TextStyle(fontSize: 19),
                        ),
                      ]),
                      SizedBox(height: 10),

                      SizedBox(height: 10),
                      // to show product decsription
                      Container(
                        height: 3,
                        color: Color(0xFF056608),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('Product Description :',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),

                      _textField(
                          label: 'Product Description',
                          inputType: TextInputType.text,
                          controller: _description,
                          maxLine: 5),

                      SizedBox(height: 10),
                      // to show product price and sales price
                      Container(
                        color: const Color(0xFFe2efdd),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('Price :'),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: _textField(
                                              label: 'Price',
                                              inputType: TextInputType.text,
                                              controller: _regularPrice),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('Sale Until: '),
                                  SizedBox(width: 10),
                                  Text(_service.formattedDate(saledate))
                                ],
                              ),
                              SizedBox(height: 10),
                              if (_editable == false)
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF056608)),
                                    child: Text('Change date'),
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: saledate!,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(5000))
                                          .then((value) {
                                        setState(() {
                                          saledate = value;
                                        });
                                      });
                                    })
                            ],
                          ),
                        ),
                      ),

                      //to show the unit
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Text('Unit :', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 10),
                            Text(widget.product!.unit!,
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Row(
                        children: [
                          Text('Size : ', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 10),
                          Text(widget.product!.sizeList.toString(),
                              style: TextStyle(fontSize: 15))
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 3,
                        color: Color(0xFF056608),
                      ),
                      SizedBox(height: 10),

                      // to show the sku
                      Row(
                        children: [
                          Text('SKU :', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 10),
                          Text(widget.product!.sku!,
                              style: TextStyle(fontSize: 22)),
                        ],
                      ),

                      // to show the stock on hand
                      Container(
                        color: const Color(0xFFe2efdd),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                  title: Text('Manage Inventory',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  activeColor: Color(0xFF056608),
                                  value: manageInventory,
                                  onChanged: (value) {
                                    setState(() {
                                      manageInventory = value;
                                      if (value == false) {
                                        _stockonhand.clear();
                                        _reOrderLevel.clear();
                                      }
                                    });
                                  }),
                              if (manageInventory == true)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text('SOH :'),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: _textField(
                                                label: 'SOH',
                                                inputType: TextInputType.text,
                                                controller: _stockonhand),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text('Reorder Level:'),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: _textField(
                                                label: 'ReorderLevel',
                                                inputType: TextInputType.text,
                                                controller: _reOrderLevel),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 3,
                        color: Color(0xFF056608),
                      ),
                      SizedBox(height: 10),

                      // to show the delivery
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('Deliveries :',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),

                      Container(
                        color: const Color(0xFFe2efdd),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('Location:'),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: _textField(
                                          label: 'Location',
                                          inputType: TextInputType.text,
                                          controller: _deliveryLocation),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('Charge:'),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: _textField(
                                          label: 'Charge',
                                          inputType: TextInputType.text,
                                          controller: _deliveryCharge),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // to show the additional detail
                      SizedBox(height: 10),
                      Container(
                        height: 3,
                        color: Color(0xFF056608),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('Additional Details :',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      // to show product decsription
                      _textField(
                          label: 'Additional Details ',
                          inputType: TextInputType.text,
                          controller: _additionalDetail,
                          maxLine: 5),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
