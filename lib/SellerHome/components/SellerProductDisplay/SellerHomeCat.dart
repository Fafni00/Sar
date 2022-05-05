// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:ecommerce_app/Model/Categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'SellerHomeProductList.dart';

class SellerHomeCat extends StatefulWidget {
  SellerHomeCat({Key? key}) : super(key: key);

  @override
  State<SellerHomeCat> createState() => _SellerHomeCatState();
}

class _SellerHomeCatState extends State<SellerHomeCat> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFFAF9F6),
        child: Column(children: [
          const SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Products For You',
                    style: TextStyle(
                        color: AppColors.buttonnavigation,
                        fontSize: 20,
                        letterSpacing: 1)),
              ],
            ),
          ),
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width,
            color: AppColors.buttonnavigation,
            margin: EdgeInsets.only(left: 10, right: 220),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 40,
                  child: Row(children: [
                    Expanded(
                      child: FirestoreListView<Category>(
                          scrollDirection: Axis.horizontal,
                          query: categoryCollection,
                          itemBuilder: (context, snapshot) {
                            Category category = snapshot.data();
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: ActionChip(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor:
                                    _selectedCategory == category.categoryName
                                        ? Colors.white
                                        : AppColors.buttonnavigation,
                                label: Text(category.categoryName!,
                                    style: (TextStyle(
                                        fontSize: 12,
                                        color: _selectedCategory ==
                                                category.categoryName
                                            ? Colors.black
                                            : Colors.white))),
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory = category.categoryName;
                                  });
                                },
                              ),
                            );
                          }),
                    ),
                  ]))),
          SellerHomeProductList(
            category: _selectedCategory,
          )
        ]));
  }
}
