class Product {
  int? productId;
  int? quantity;

  Product({this.productId, this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json['productId'] as int?,
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };
}
