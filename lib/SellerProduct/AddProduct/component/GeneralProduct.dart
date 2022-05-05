// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Services/AddProductService.dart';
import 'package:ecommerce_app/Provider/ProductProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Colors.dart';
//import 'package:ecommerce_app/utils/colors.dart';

class GeneralProduct extends StatefulWidget {
  const GeneralProduct({Key? key}) : super(key: key);

  @override
  State<GeneralProduct> createState() => _GeneralProductState();
}

class _GeneralProductState extends State<GeneralProduct>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final AddProductService _service = AddProductService();
  final List<String> _categories = [];
  String? selectedCategory;

//to craete the dropdown button
  Widget _categoryDropDown(ProductProvider provider) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      hint: Text('Select Category',
          style: TextStyle(
              color: AppColors.buttonColor.withOpacity(0.5), fontSize: 14)),
      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF056608)),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        //for focused border
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.textboxColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.textboxColor,
            )),
      ),
      elevation: 16,
      style: const TextStyle(color: Color(0xFF056608)),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue;
          provider.getFormData(category: newValue);
        });
      },
      items: _categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value!.isEmpty) return 'Select Category';
      },
    );
  }

  getCategories() {
    _service.categories.get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          _categories.add(element['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(children: [
              SizedBox(height: 30),
              //text form for product name
              _service.formField(
                  label: 'Enter Product Name',
                  type: TextInputType.name,
                  inputaction: TextInputAction.next,
                  onChanged: (value) {
                    provider.getFormData(productName: value);
                  }),

              SizedBox(height: 30),

              //text form for storeName
              _service.formField(
                  label: 'Enter StoreName',
                  type: TextInputType.multiline,
                  inputaction: TextInputAction.next,
                  onChanged: (value) {
                    provider.getFormData(storeName: value);
                  }),

              SizedBox(height: 30),

              //text form for description
              _service.formField(
                  label: 'Enter Product Description',
                  type: TextInputType.multiline,
                  inputaction: TextInputAction.next,
                  minLine: 2,
                  maxLine: 5,
                  onChanged: (value) {
                    provider.getFormData(description: value);
                  }),

              SizedBox(height: 30),

              //for product Category
              _categoryDropDown(provider),
              SizedBox(height: 8),
              //for main Category
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.productData!['mainCategory'] ??
                          'Select Main Category',
                      style: TextStyle(
                          color: AppColors.buttonColor.withOpacity(0.5),
                          fontSize: 14),
                    ),
                    if (selectedCategory != null)
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return MainCategoryList(
                                      selectedCategory: selectedCategory,
                                      provider: provider);
                                }).whenComplete(() {
                              setState(() {});
                            });
                          },
                          child: const Icon(Icons.arrow_drop_down,
                              color: Color(0xFF056608)))
                  ],
                ),
              ),
              Divider(
                height: 30,
                color: Color(0xFF056608),
              ),
              SizedBox(height: 30),
              //for subcategroies
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.productData!['subCategory'] ??
                          'Select Sub Category',
                      style: TextStyle(
                          color: AppColors.buttonColor.withOpacity(0.5),
                          fontSize: 14),
                    ),
                    if (selectedCategory != null)
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SubCategoryList(
                                      selectedMainCategory:
                                          provider.productData!['mainCategory'],
                                      provider: provider);
                                }).whenComplete(() {
                              setState(() {});
                            });
                          },
                          child: const Icon(Icons.arrow_drop_down,
                              color: Color(0xFF056608)))
                  ],
                ),
              ),
              Divider(
                color: Color(0xFF056608),
              ),
              SizedBox(height: 30),

              // for regular price
              _service.formField(
                  label: 'Enter Regular Price(\$)',
                  type: TextInputType.name,
                  inputaction: TextInputAction.next,
                  onChanged: (value) {
                    provider.getFormData(regularPrice: int.parse(value));
                  }),
              SizedBox(height: 30),
            ])),
      );
    });
  }
}

//create the page for maincategories
class MainCategoryList extends StatelessWidget {
  final String? selectedCategory;
  final ProductProvider? provider;
  const MainCategoryList({this.selectedCategory, this.provider, Key? key})
      : super(key: key);

  // to add the subcategories after main category has been selecetd in the form
  @override
  Widget build(BuildContext context) {
    final AddProductService _service = AddProductService();
    return Dialog(
      child: FutureBuilder<QuerySnapshot>(
          future: _service.mainCategories
              .where('category', isEqualTo: selectedCategory)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.size == 0) {
              return Center(
                child: Text('No Main Categories'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      provider!.getFormData(
                          mainCategory: snapshot.data!.docs[index]
                              ['mainCategory']);
                      Navigator.pop(context);
                    },
                    title: Text(snapshot.data!.docs[index]['mainCategory']),
                  );
                });
          }),
    );
  }
}

//create the page for maincategories
class SubCategoryList extends StatelessWidget {
  final String? selectedMainCategory;
  final ProductProvider? provider;
  const SubCategoryList(
      {this.selectedMainCategory,
      this.provider,
      Key? key,
      String? selectedSubCategory})
      : super(key: key);

  // to add the subcategories after main category has been selecetd in the form
  @override
  Widget build(BuildContext context) {
    final AddProductService _service = AddProductService();
    return Dialog(
      child: FutureBuilder<QuerySnapshot>(
          future: _service.subCategories
              .where('mainCategory', isEqualTo: selectedMainCategory)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.size == 0) {
              return Center(
                child: Text('No Sub Categories'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      provider!.getFormData(
                          subCategory: snapshot.data!.docs[index]
                              ['subCategoryName']);
                      Navigator.pop(context);
                    },
                    title: Text(snapshot.data!.docs[index]['subCategoryName']),
                  );
                });
          }),
    );
  }
}
