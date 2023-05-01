import 'package:domain/models/user.dart';
import 'package:mepaga_ai/data/models/user_vm.dart';

extension UserMappers on User {
  UserVM toVM() => UserVM(
        id: id,
        email: email,
        profile: profile.toVM(),
      );
}

extension ProfileMappers on Profile {
  ProfileVM toVM() => ProfileVM(
        name: name,
        picture: picture,
      );
}
