class UserModel {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String subscription;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phone = '+91 9871125588',
    this.subscription = 'Calley Personal',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '+91 9871125588',
      subscription: json['subscription'] ?? 'Calley Personal',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'subscription': subscription,
    };
  }
}
