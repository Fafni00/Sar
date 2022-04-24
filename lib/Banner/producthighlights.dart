// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/Banner/banner_widge_page.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class ProductHighlights extends StatefulWidget {
  const ProductHighlights({Key? key}) : super(key: key);

  @override
  State<ProductHighlights> createState() => _ProductHighlightsState();
}

class _ProductHighlightsState extends State<ProductHighlights> {
  double scrollPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.textboxColor.withOpacity(0.5),
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        const SizedBox(height: 18),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text('Product Highlights',
                  style: TextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 16,
                      letterSpacing: 1))),
        ),
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          color: AppColors.textboxColor.withOpacity(0.2),
          child: PageView(
            onPageChanged: (val) {
              setState(() {
                scrollPosition = val.toDouble();
              });
            },
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 4, 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                height: 100,
                                color: Colors.amber,
                                child: Center(
                                  child: Text('Ad About Product',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: Container(
                                      height: 50,
                                      color: Colors.cyan,
                                      child: Center(
                                        child: Text('Ad',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: Container(
                                      height: 50,
                                      color: Colors.cyan,
                                      child: Center(
                                        child: Text('Ad',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              height: 160,
                              color: Colors.indigo,
                              child: Center(
                                child: Text('Ad',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                    )),
                              ),
                            ),
                          )))
                ],
              ),
              //second page view
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 4, 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                height: 100,
                                color: Colors.amber,
                                child: Center(
                                  child: Text('Ad About Product',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: Container(
                                      height: 50,
                                      color: Colors.cyan,
                                      child: Center(
                                        child: Text('Ad',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: Container(
                                      height: 50,
                                      color: Colors.cyan,
                                      child: Center(
                                        child: Text('Ad',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              height: 160,
                              color: Colors.indigo,
                              child: Center(
                                child: Text('Ad',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                    )),
                              ),
                            ),
                          )))
                ],
              ),
              //third page view
              Row(children: [
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 4, 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              height: 100,
                              color: Colors.amber,
                              child: Center(
                                child: Text('Ad About Product',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Container(
                                    height: 50,
                                    color: Colors.cyan,
                                    child: Center(
                                      child: Text('Ad',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 4, 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Container(
                                    height: 50,
                                    color: Colors.cyan,
                                    child: Center(
                                      child: Text('Ad',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Container(
                            height: 160,
                            color: Colors.indigo,
                            child: Center(
                              child: Text('Ad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                  )),
                            ),
                          ),
                        )))
              ])
            ],
          ),
        ),
        DotsiniWidget(scrollPosition: scrollPosition),
      ]),
    );
  }
}
