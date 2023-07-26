class UserVM {
  UserVM({
    required this.email,
    required this.name,
    this.pixKey,
  });

  final String name;
  final String email;
  final String? pixKey;
}
