class User {
  final String email;
  final String phoneNumber;
  final String fullName;
  final String cnic;
  final String area;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String accessToken;

  User({
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
     email: user['email'],
      phoneNumber: user['phoneNumber'],
      fullName: user['fullName'],
      cnic: user['cnic'],
      area: user['area'],
      role: user['role'],
      createdAt: user['createdAt'],
      updatedAt: user['updatedAt'],
      accessToken: json['token'],    );
  }

  // Convert a User object to JSON for saving purposes (e.g., for SharedPreferences or API request)
  Map<String, dynamic> toJson() {
    return {
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
