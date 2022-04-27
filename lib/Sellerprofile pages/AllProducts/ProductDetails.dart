import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/Product_model.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Product? product;
  final String? productId;

  const ProductDetail({this.product, this.productId, Key? key})
      : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _productName = TextEditingController();
  final _regularPrice = TextEditingController();
  final _salesPrice = TextEditingController();
  final _description = TextEditingController();
  final _stockonhand = TextEditingController();
  final _reOrderLevel = TextEditingController();
  final _deliveryCharge = TextEditingController();
  final _deliveryLocation = TextEditingController();

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

  @override
  void initState() {
    setState(() {
      _productName.text = widget.product!.productName!;
      _regularPrice.text = widget.product!.regularPrice.toString();
      _salesPrice.text = widget.product!.salesPrice.toString();
      _description.text = widget.product!.description!;
      _stockonhand.text = widget.product!.stockonhand.toString();
      _reOrderLevel.text = widget.product!.reOrderLevel.toString();
      _deliveryCharge.text = widget.product!.deliveryCharge.toString();
      _deliveryLocation.text = widget.product!.deliveryLocation!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAF9F6),
        appBar: AppBar(
          elevation: 3,
          title: Text(widget.product!.productName!),
          backgroundColor: Color(0xFF056608),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          offset: const Offset(5, 5),
                          color: Color(0xFFe0f0e3).withOpacity(0.5),
                        ),
                        BoxShadow(
                          blurRadius: 3,
                          offset: const Offset(-5, -5),
                          color: Color(0xFFe0f0e3).withOpacity(0.5),
                        ),
                      ]),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: widget.product!.imageUrls!.map((e) {
                      return Padding(
                        // to show product image
                        padding: const EdgeInsets.all(3.0),
                        child: CachedNetworkImage(imageUrl: e),
                      );
                    }).toList(),
                  )),
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
              // to show product price and sakes price
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
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Text('Sale Price :'),
                        SizedBox(width: 10),
                        Expanded(
                          child: _textField(
                              label: 'Sales Price',
                              inputType: TextInputType.text,
                              controller: _salesPrice),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Container(
                height: 3,
                color: Color(0xFF056608),
              ),
              Text('Product Description :', style: TextStyle(fontSize: 22)),
              // to show product decsription
              _textField(
                  label: 'Product Description',
                  inputType: TextInputType.text,
                  controller: _description,
                  maxLine: 5),

              //to show the unit
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text('Unit :', style: TextStyle(fontSize: 18)),
                    SizedBox(width: 10),
                    Text(widget.product!.unit!, style: TextStyle(fontSize: 15))
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

              Container(
                height: 3,
                color: Color(0xFF056608),
              ),
              SizedBox(height: 10),

              if (widget.product!.manageInventory == true)
                // to show the sku
                Row(
                  children: [
                    Text('SKU :', style: TextStyle(fontSize: 17)),
                    Text(widget.product!.sku!, style: TextStyle(fontSize: 22)),
                  ],
                ),
              // to show the stock on hand
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text('SOH :', style: TextStyle(fontSize: 17)),
                        Expanded(
                          child: _textField(
                              controller: _stockonhand,
                              inputType: TextInputType.number,
                              label: 'SOH'),
                        )
                      ],
                    ),
                  ),
                  // to show the reorder level
                  Expanded(
                    child: Row(
                      children: [
                        Text('Re-order Level :',
                            style: TextStyle(fontSize: 17)),
                        Expanded(
                          child: _textField(
                              controller: _reOrderLevel,
                              inputType: TextInputType.number,
                              label: 'Re-order level'),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // to show the delivery
              if (widget.product!.manageDeliveries == true)
                Row(
                  children: [
                    Text('Delivery Charge :', style: TextStyle(fontSize: 17)),
                    SizedBox(width: 10),
                    Expanded(
                      child: _textField(
                          controller: _deliveryCharge,
                          inputType: TextInputType.number,
                          label: 'Delivery Charge'),
                    )
                  ],
                ),

              Row(
                children: [
                  Text('Delivery Location :', style: TextStyle(fontSize: 17)),
                  SizedBox(width: 10),
                  Expanded(
                    child: _textField(
                        controller: _deliveryLocation,
                        inputType: TextInputType.number,
                        label: 'Delivery Location'),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
