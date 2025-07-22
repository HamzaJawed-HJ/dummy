class RequestModel {
  final String? id;
  final ProductRequestModel? product;
  final UserRequestModel? owner;
  final UserRequestModel? renter;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RequestModel({
    this.id,
    this.product,
    this.owner,
    this.renter,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['_id'] as String?,
      product: json['productID'] != null ? ProductRequestModel.fromJson(json['productID']) : null,
      owner: json['ownerID'] != null ? UserRequestModel.fromJson(json['ownerID']) : null,
      renter: json['renterID'] != null ? UserRequestModel.fromJson(json['renterID']) : null,
      status: json['status'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
class ProductRequestModel {
  final String? id;
  final String? category;
  final String? name;
  final String? description;
  final int? price;
  final String? timePeriod;
  final String? location;
  final String? image;
  final String? ownerID;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductRequestModel({
    this.id,
    this.category,
    this.name,
    this.description,
    this.price,
    this.timePeriod,
    this.location,
    this.image,
    this.ownerID,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) {
    return ProductRequestModel(
      id: json['_id'] as String?,
      category: json['category'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: json['price'] as int?,
      timePeriod: json['timePeriod'] as String?,
      location: json['location'] as String?,
      image: json['image'] as String?,
      ownerID: json['ownerID'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
class UserRequestModel {
  final String? id;
  final String? email;
  final String? phoneNumber;
  final String? fullName;
  final String? password;
  final String? cnic;
  final String? area;
  final String? role;
  final String? shopName;
  final String? shopAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserRequestModel({
    this.id,
    this.email,
    this.phoneNumber,
    this.fullName,
    this.password,
    this.cnic,
    this.area,
    this.role,
    this.shopName,
    this.shopAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) {
    return UserRequestModel(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      password: json['password'] as String?,
      cnic: json['cnic'] as String?,
      area: json['area'] as String?,
      role: json['role'] as String?,
      shopName: json['shopName'] as String?,
      shopAddress: json['shopAddress'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
