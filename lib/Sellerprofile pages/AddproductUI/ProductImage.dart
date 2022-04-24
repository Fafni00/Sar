// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductImage extends StatefulWidget {
  const AddProductImage({Key? key}) : super(key: key);

  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  final ImagePicker _picker = ImagePicker();

  Future<List<XFile>?> _pickImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    return images;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      return Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              TextButton(
                child: Text('Add Product Image'),
                onPressed: () {
                  _pickImage().then((value) {
                    var List = value!.forEach((image) {
                      setState(() {
                        provider.getImageFile(image);
                      });
                    });
                  });
                },
              ),
              Center(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: provider.imageFiles!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                            onLongPress: () {
                              setState(() {
                                provider.imageFiles!.removeAt(index);
                              });
                            },
                            child: provider.imageFiles == null
                                ? Container(
                                    child: Center(child: Text('No Image Add')))
                                : Image.file(
                                    File(provider.imageFiles![index].path))),
                      );
                    }),
              )
            ],
          ));
    });
  }
}
