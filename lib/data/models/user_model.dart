class User {
  final String id;
  final String email;
  final String phoneNumber;
  final String fullName;
  final String cnic;
  final String area;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String accessToken;
  final String profilePicture;
  final String cnicPicture;

  User({
    required this.profilePicture,
    required this.cnicPicture,
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.cnic,
    required this.area,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.accessToken,
  });

  // Factory constructor to create a User object from a JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return User(
      profilePicture: user['profilePicture'],
      cnicPicture: user['cnicPicture'],
      id: user['_id'],
      email: user['email'],
      phoneNumber: user['phoneNumber'],
      fullName: user['fullName'],
      cnic: user['cnic'],
      area: user['area'],
      role: user['role'],
      createdAt: user['createdAt'],
      updatedAt: user['updatedAt'],
      accessToken: json['token'],
    );
  }

  // Convert a User object to JSON for saving purposes (e.g., for SharedPreferences or API request)
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
      'accessToken': accessToken,
    };
  }
}
