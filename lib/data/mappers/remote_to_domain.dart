import 'package:domain/models/user.dart';
import 'package:mepaga_ai/data/remote/models/user_rm.dart';

extension UserRMMappers on UserRM {
  User toDM() => User(
        id: id,
        email: email ?? '',
        profile: profile.toDM(),
      );
}

extension UserProfileRMMappres on ProfileRM {
  Profile toDM() => Profile(
        name: name,
        picture: picture,
      );
}
