// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:ecommerce_app/Provider/ProductProvider.dart';
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
              // text button to pick the images from gallery
              TextButton(
                child: Text('Add Product Image'),
                onPressed: () {
                  _pickImage().then((value) {
                    var List = value!.forEach((image) {
                      setState(() {
                        provider.getImageFile(
                            image); // to save the picked image to the product provider
                      });
                    });
                  });
                },
              ),

              // to display the selected images
              Center(
                child: GridView.builder(
                    shrinkWrap: true, // to avoid the size error
                    physics: ScrollPhysics(), // to allow the scrolling
                    itemCount: provider.imageFiles!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2), // to decide the number of picture to display in the row
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: InkWell(
                            // to make the images clickable

                            onLongPress: () {
                              // to remove the image on longpress
                              setState(() {
                                provider.imageFiles!.removeAt(index);
                              });
                            },
                            child: provider.imageFiles ==
                                    null // condition to check whether the image has bee picked
                                ? Container(
                                    child: Center(
                                        child: Text(
                                            'No Image Add'))) // message to display incase of image not picked
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
