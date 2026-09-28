class UserModel {
  final String id;
  final String username;
  final String email;
  final String role;
  final String token;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.token,
  });

  // Backend ke JSON response ko Flutter Model me convert karne ke liye
  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['_id'] ?? json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      token: token,
    );
  }
}