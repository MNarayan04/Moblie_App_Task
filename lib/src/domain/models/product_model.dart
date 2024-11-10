class Product {
  String imageLink;
  String productName;
  String productPrice;
  bool isAvailable;

  Product({
    required this.imageLink,
    required this.productName,
    required this.productPrice,
    required this.isAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imageLink: json['imageLink'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageLink': imageLink,
      'productName': productName,
      'productPrice': productPrice,
      'isAvailable': isAvailable,
    };
  }
}
