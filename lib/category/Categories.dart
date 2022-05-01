// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:ecommerce_app/category/Category%20Model/Categorymodel.dart';
import 'package:ecommerce_app/category/MainCategories.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String _title = 'Categories';
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFe2efdd),
        appBar: AppBar(
          backgroundColor: AppColors.buttonColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Sar',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Row(
          children: [
            Container(
                width: 120,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        offset: Offset(5, 5),
                        color: AppColors.breadcrumbColor.withOpacity(0.3),
                      ),
                      BoxShadow(
                        blurRadius: 3,
                        offset: Offset(-3, -3),
                        color: AppColors.breadcrumbColor.withOpacity(0.3),
                      ),
                    ]),
                child: FirestoreListView<Category>(
                    query: categoryCollection,
                    itemBuilder: (context, snapshot) {
                      Category category = snapshot.data();
                      // to get to the selected maincategory after clicking on the corresponding category
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _title = category.categoryName!;
                            _selectedCategory = category.categoryName;
                          });
                        },
                        child: SizedBox(
                            height: 120,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: CachedNetworkImage(
                                        imageUrl: category.image!,
                                      ),
                                    ),
                                    Text(category.categoryName!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          //to choose the color for the selected Category
                                          color: _selectedCategory ==
                                                  category.categoryName
                                              ? AppColors.buttonbackgroundColor
                                              : Colors.black,
                                        ))
                                  ]),
                            ))),
                      );
                    })),
            MainCategories(
              selectedCat: _selectedCategory,
            )
          ],
        ));
  }
}
