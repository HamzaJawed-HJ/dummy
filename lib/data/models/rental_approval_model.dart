class RentalApprovalModel {
  String? sId;
  RenterRequestID? renterRequestID;
  String? userID;
  String? message;
  bool? seen;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RentalApprovalModel(
      {this.sId,
      this.renterRequestID,
      this.userID,
      this.message,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RentalApprovalModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    renterRequestID = json['renterRequestID'] != null
        ? new RenterRequestID.fromJson(json['renterRequestID'])
        : null;
    userID = json['userID'];
    message = json['message'];
    seen = json['seen'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.renterRequestID != null) {
      data['renterRequestID'] = this.renterRequestID!.toJson();
    }
    data['userID'] = this.userID;
    data['message'] = this.message;
    data['seen'] = this.seen;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class RenterRequestID {
  String? sId;
  ProductID? productID;
  OwnerID? ownerID;
  RenterID? renterID;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RenterRequestID(
      {this.sId,
      this.productID,
      this.ownerID,
      this.renterID,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RenterRequestID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productID = json['productID'] != null
        ? new ProductID.fromJson(json['productID'])
        : null;
    ownerID =
        json['ownerID'] != null ? new OwnerID.fromJson(json['ownerID']) : null;
    renterID = json['renterID'] != null
        ? new RenterID.fromJson(json['renterID'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.productID != null) {
      data['productID'] = this.productID!.toJson();
    }
    if (this.ownerID != null) {
      data['ownerID'] = this.ownerID!.toJson();
    }
    if (this.renterID != null) {
      data['renterID'] = this.renterID!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductID {
  String? sId;
  String? category;
  String? name;
  String? description;
  int? price;
  String? timePeriod;
  String? location;
  String? image;
  String? ownerID;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductID(
      {this.sId,
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
      this.iV});

  ProductID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    timePeriod = json['timePeriod'];
    location = json['location'];
    image = json['image'];
    ownerID = json['ownerID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['timePeriod'] = this.timePeriod;
    data['location'] = this.location;
    data['image'] = this.image;
    data['ownerID'] = this.ownerID;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class OwnerID {
  String? sId;
  String? email;
  String? phoneNumber;
  String? fullName;
  String? password;
  String? shopName;
  String? shopAddress;
  String? cnic;
  String? area;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OwnerID(
      {this.sId,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.password,
      this.shopName,
      this.shopAddress,
      this.cnic,
      this.area,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OwnerID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    password = json['password'];
    shopName = json['shopName'];
    shopAddress = json['shopAddress'];
    cnic = json['cnic'];
    area = json['area'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['password'] = this.password;
    data['shopName'] = this.shopName;
    data['shopAddress'] = this.shopAddress;
    data['cnic'] = this.cnic;
    data['area'] = this.area;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class RenterID {
  String? sId;
  String? email;
  String? phoneNumber;
  String? fullName;
  String? password;
  String? cnic;
  String? area;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RenterID(
      {this.sId,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.password,
      this.cnic,
      this.area,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV});

  RenterID.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    password = json['password'];
    cnic = json['cnic'];
    area = json['area'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['password'] = this.password;
    data['cnic'] = this.cnic;
    data['area'] = this.area;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
