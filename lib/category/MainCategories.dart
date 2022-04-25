import 'package:ecommerce_app/category/Category%20Model/MainCategorymodel.dart';
import 'package:ecommerce_app/category/Productscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/route_manager.dart';

class MainCategories extends StatefulWidget {
  final String? selectedCat;
  const MainCategories({Key? key, this.selectedCat}) : super(key: key);

  @override
  State<MainCategories> createState() => _MainCategoriesState();
}

class _MainCategoriesState extends State<MainCategories> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<MainCategory>(
          query: mainCategoryCollection(widget.selectedCat),
          itemBuilder: (context, snapshot) {
            MainCategory mainCategory = snapshot.data();
            return ExpansionTile(
              title: Text(mainCategory.mainCategory!),
              
            );
          }),
    );
  }
}
