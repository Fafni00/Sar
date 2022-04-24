import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/AddProduct/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Utils/Colors.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference mainCategories =
      FirebaseFirestore.instance.collection('mainCategories');
  CollectionReference subCategories =
      FirebaseFirestore.instance.collection('subCategories');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

//to upload image
  Future<List> uploadFiles(
      {List<XFile>? images, String? ref, ProductProvider? provider}) async {
    var imageUrls = await Future.wait(images!
        .map((_image) => uploadFile(image: File(_image.path), reference: ref)));
    provider!.getFormData(imageUrls: imageUrls);

    return imageUrls;
  }

//to upload file to database
  Future uploadFile({
    File? image,
    String? reference,
  }) async {
    firebase_storage.Reference storageReference = storage
        .ref()
        .child('$reference/${DateTime.now().microsecondsSinceEpoch}');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;

    return storageReference.getDownloadURL();
  }

//save data to db

  Future<void> saveTodb(
      {CollectionReference? collection,
      Map<String, dynamic>? data,
      BuildContext? context}) {
    return products.add(data).then((value) => scaffold(context, "Product Added")
        .catchError(
            (error) => scaffold(context, "failed to add product :$error")));
  }

  //to show messages
  scaffold(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        )));
  }

//to create datetime format
  formattedDate(date) {
    var outputFormat = DateFormat('dd/mm/yyyy hh:mm:aa');
    var outputdate = outputFormat.format(date);
    return outputdate;
  }

//to use the formfield widget everywhere
  Widget formField(
      {String? label,
      TextInputType? type,
      TextInputAction? inputaction,
      String? Function(String?)? validator,
      int? minLine,
      int? maxLine,
      void Function(String)? onChanged}) {
    return TextFormField(
      key: Key(label.toString()),
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label!),
        labelStyle: TextStyle(
            color: AppColors.buttonColor.withOpacity(0.5), fontSize: 14),
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
      validator: (value) {
        if (value!.isEmpty) {
          return label;
        }
      },
      onChanged: onChanged,
      minLines: minLine,
      maxLines: maxLine,
      textInputAction: inputaction,
    );
  }
}
