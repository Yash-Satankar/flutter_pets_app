class UserDetails {
  final String name;
  final String email;
  final String phone;
  final String userId;

  UserDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'userId': userId,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
