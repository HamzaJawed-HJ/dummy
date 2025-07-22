class ProductModel {
  final String id;
  final String category;
  final String name;
  final String description;
  final int price;
  final String timePeriod;
  final String location;
  final String image;
  final String ownerID;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.timePeriod,
    required this.location,
    required this.image,
    required this.ownerID,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      category: json['category'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      timePeriod: json['timePeriod'],
      location: json['location'],
      image: json['image'],
      ownerID: json['ownerID'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'category': category,
      'name': name,
      'description': description,
      'price': price,
      'timePeriod': timePeriod,
      'location': location,
      'image': image,
      'ownerID': ownerID,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
