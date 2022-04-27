import 'package:ecommerce_app/category/Firebase_service.dart';

class SubCategory {
  SubCategory(
      {this.mainCategory,
      this.subCategoryName,
      this.image,
      String? selectedSubCat});
  SubCategory.fromJson(Map<String, Object?> json)
      : this(
          mainCategory: json['mainCategory']! as String,
          subCategoryName: json['subCategoryName']! as String,
          image: json['image']! as String,
        );

  final String? mainCategory;
  final String? subCategoryName;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'mainCategory': mainCategory,
      'subCategoryName': subCategoryName,
      'image': image,
    };
  }
}

FirebaseService _service = FirebaseService();
subCategoryCollection({selectedSubCat}) {
  return _service.subCategories
      .where('active', isEqualTo: true)
      .where('mainCategory', isEqualTo: selectedSubCat)
      .withConverter<SubCategory>(
        fromFirestore: (snapshot, _) => SubCategory.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
