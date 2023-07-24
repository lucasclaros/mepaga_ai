class UserMM {
  // Factory constructor to provide access to the singleton instance
  factory UserMM() {
    return _instance;
  }

  // Private constructor
  UserMM._internal();
  String email = '';

  // Static instance variable
  static final UserMM _instance = UserMM._internal();
}
