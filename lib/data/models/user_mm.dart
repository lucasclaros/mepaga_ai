class UserMM {
  factory UserMM() {
    return _instance;
  }

  UserMM._internal();
  String email = '';
  String name = '';
  String? pixKey;

  static final UserMM _instance = UserMM._internal();
}
