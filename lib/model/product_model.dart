class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final Rating rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,  // Default value for id
      title: json['title'] ?? 'No title',  // Default value for title
      description: json['description'] ?? 'No description',  // Default value for description
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] ?? 0.0),  // Default value for price
      category: json['category'] ?? '',  // Default value for image
      image: json['image'] ?? '',  // Default value for image
      rating: Rating.fromJson(json['rating']),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] is int) ? (json['rate'] as int).toDouble() : (json['rate'] ?? 0.0),  // Default value for rate
      count: json['count'] ?? 0,  // Default value for count
    );
  }
}
