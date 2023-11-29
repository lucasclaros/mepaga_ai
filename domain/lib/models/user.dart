class User {
  User({
    required this.name,
    required this.email,
    this.pixKey,
  });

  final String name;
  final String email;
  final String? pixKey;
}
