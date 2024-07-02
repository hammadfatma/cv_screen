class ProductModel {
  final dynamic id;
  final String title;
  final dynamic price;
  final String description;
  final String image;
  final RatingModel rating;
  final String category;
  int? quantity;
  ProductModel(
    this.quantity, {
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
    required this.category,
  });
  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      jsonData['quantity'] ?? 0,
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price'],
      description: jsonData['description'],
      image: jsonData['image'],
      rating: RatingModel.fromJson(jsonData['rating']),
      category: jsonData['category'],
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
    if (quantity != null) {
      data['quantity'] = quantity;
    }
    return data;
  }
}

class RatingModel {
  final num rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(jsonData) {
    return RatingModel(
      rate: jsonData['rate'],
      count: jsonData['count'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
