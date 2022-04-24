// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:ecommerce_app/category/Category%20Model/Categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfire_ui/firestore.dart';

class CategoryHomepage extends StatefulWidget {
  CategoryHomepage({Key? key}) : super(key: key);

  @override
  State<CategoryHomepage> createState() => _CategoryHomepageState();
}

class _CategoryHomepageState extends State<CategoryHomepage> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFF03C04A),
        child: Column(children: [
          const SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Store For You',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 1)),
            ),
          ),
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
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
                    )
                  ])))
        ]));
  }
}
