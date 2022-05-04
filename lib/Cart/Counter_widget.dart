// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Cart/Cartservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

import '../Banner/HomeproductModel.dart';

class CounterWidget extends StatefulWidget {
  final String? docId;
  final Product? product;
  final String? productID;
  final int? qty;
  CounterWidget({this.product, this.productID, this.qty, this.docId});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final CartServices _cart = CartServices();
  int? _qty;
  bool _updating = false;
  bool _exists = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _qty = widget.qty;
    });
    return //_exists?
        Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 56,
            child: Center(
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: FittedBox(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _updating = true;
                              });
                              if (_qty == 1) {
                                _cart
                                    .removeFromCart(widget.docId)
                                    .then((value) {
                                  setState(() {
                                    _updating = false;
                                    _exists = false;
                                  });
                                  _cart.checkData();
                                });
                              }
                              if (_qty! > 1) {
                                setState(() {
                                  //_qty--;
                                });
                                // var total = _qty! * widget.product!.regularPrice;
                                _cart
                                    .updateCartQty(
                                  widget.docId,
                                  _qty, /*total*/
                                )
                                    .then((value) {
                                  setState(() {
                                    _updating = false;
                                  });
                                });
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.buttonnavigation)),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(_qty == 1
                                        ? Icons.delete_outlined
                                        : Icons.remove))),
                          ),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 8),
                                  child: _updating
                                      ? Container(
                                          child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context)
                                                      .backgroundColor),
                                        ))
                                      : Text(_qty.toString(),
                                          style: TextStyle(
                                              color: AppColors
                                                  .buttonnavigation)))),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _updating = true;
                                //_qty! ++;
                              });
                              //var total = _qty! * widget.product!.regularPrice;
                              _cart
                                  .updateCartQty(
                                widget.docId,
                                _qty, /*total*/
                              )
                                  .then((value) {
                                setState(() {
                                  _updating = false;
                                });
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.buttonnavigation)),
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.add))),
                          )
                        ],
                      ),
                    ))));
    // : addToCart(widget.product, widget.productID);
  }
}
