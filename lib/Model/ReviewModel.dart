class Review {
  Review({
    this.productName,
    this.storeName,
    this.userName,
    this.review,
  });

  Review.fromJson(Map<String, Object?> json)
      : this(
          productName: json['productName']! as String,
          storeName: json['storeName']! as String,
          userName: json['userName']! as String,
          review: json['review']! as String,
        );

  final String? productName;
  final String? storeName;
  final String? userName;
  final String? review;

  Map<String, Object?> toJson() {
    return {
      'productName': productName,
      'storeName': storeName,
      'userName': userName,
      'Review': review,
    };
  }
}
