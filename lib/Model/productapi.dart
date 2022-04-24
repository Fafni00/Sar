import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Model/addproduct.dart';

uploadProduct(Product product, bool isUpdating) async {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Products');

  if (isUpdating) {
    await productRef.doc(product.id).update(product.toMap());
    print('updated product with id:${product.id}');
  } else {
    DocumentReference documentRef = await productRef.add(product.toMap());

    product.id = documentRef.id;

    print('Product Added Successfully: ${product.toString}');

    await documentRef.set(product.toMap(), SetOptions(merge: true));
  }
}
