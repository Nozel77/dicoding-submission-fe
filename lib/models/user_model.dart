class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String avatar;
  final String? emailVerifiedAt;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatar,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      avatar: json['avatar'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }
}
