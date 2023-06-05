class User {
  User({
    required this.id,
    required this.email,
    required this.profile,
    this.userAuth,
  });

  final String id;
  final String email;
  final Profile profile;
  final String? userAuth;
}

class Profile {
  final String name;
  final String? picture;

  Profile({
    required this.name,
    this.picture,
  });
}
