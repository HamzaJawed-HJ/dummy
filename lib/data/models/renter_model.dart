class RenterModel {
  final String id;

  final String email;
  final String phoneNumber;
  final String fullName;
  final String cnic;
  final String area;
  final String role;
  final String shopName;
  final String shopAddress;
  final String createdAt;
  final String updatedAt;
  final String accessToken;
  final String profilePicture;
  final String cnicPicture;
  
  

  RenterModel( {
   required this.profilePicture,required this.cnicPicture,
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.cnic,
    required this.area,
    required this.role,
    required this.shopName,
    required this.shopAddress,
    required this.createdAt,

    required this.updatedAt,
    required this.accessToken,
  });

  // Updated factory constructor
  factory RenterModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return RenterModel(
      profilePicture: user['profilePicture'],
      cnicPicture: user['cnicPicture'],

      id: user['_id'],
      email: user['email'],
      phoneNumber: user['phoneNumber'],
      fullName: user['fullName'],
      cnic: user['cnic'],
      area: user['area'],
      role: user['role'],
      shopName: user['shopName'],
      shopAddress: user['shopAddress'],
      createdAt: user['createdAt'],
      updatedAt: user['updatedAt'],
      accessToken: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profilePicture': profilePicture,
      'cnicPicture': cnicPicture,

      '_id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'cnic': cnic,
      'area': area,
      'role': role,
      'shopName': shopName,
      'shopAddress': shopAddress,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'accessToken': accessToken,
    };
  }
}
