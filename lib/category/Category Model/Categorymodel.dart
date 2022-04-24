import 'package:ecommerce_app/category/Firebase_service.dart';

class Category {
  Category({required this.categoryName, required this.image});

  Category.fromJson(Map<String, Object?> json)
      : this(
          categoryName: json['categoryName']! as String,
          image: json['image']! as String,
        );

  final String? categoryName;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'categoryName': categoryName,
      'image': image,
    };
  }
}

FirebaseService _service = FirebaseService();
final categoryCollection = _service.categories
    .where('active', isEqualTo: true)
    .withConverter<Category>(
      fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );
