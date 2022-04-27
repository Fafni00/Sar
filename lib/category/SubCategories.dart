import 'package:ecommerce_app/category/Category%20Model/MainCategorymodel.dart';
import 'package:ecommerce_app/category/Category%20Model/SubCategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../Utils/Colors.dart';

class SubCategories extends StatelessWidget {
  final String? selectedSubCat;
  const SubCategories({Key? key, this.selectedSubCat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<SubCategory>(
        query: subCategoryCollection(selectedSubCat: selectedSubCat),
        builder: (context, snapshot, _) {
          if (snapshot.isFetching) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('error${snapshot.error}');
          }

          return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1 / 1.1),
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                final subcat = snapshot.docs[index].data();
                return Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              offset: Offset(5, 5),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            BoxShadow(
                              blurRadius: 3,
                              offset: Offset(-5, -5),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ]),
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(subcat.image!)),
                    ),
                    Text(subcat.subCategoryName!),
                  ],
                );
              });
        });
  }
}
