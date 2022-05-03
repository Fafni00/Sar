import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class FirebaseServices {
  User? user = FirebaseAuth.instance.currentUser;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final CollectionReference seller =
      FirebaseFirestore.instance.collection('seller');

  Future<String?> uploadImage(XFile? file, String? reference) async {
    File _file = File(file!.path);
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(reference);
    await ref.putFile(_file);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> addSeller({Map<String, dynamic>? data}) {
    print('Before adding seller');
    print(data?['uid']);
    return seller.doc(data?['uid']).set(data);
  }
}
