class UserVM {
  UserVM({
    required this.id,
    required this.email,
    required this.profile,
    this.userAuth,
  });

  final String id;
  final String email;
  final ProfileVM profile;
  final String? userAuth;
}

class ProfileVM {
  ProfileVM({
    required this.name,
    this.picture,
  });

  final String name;
  final String? picture;
}
