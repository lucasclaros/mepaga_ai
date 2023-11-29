import 'package:domain/models/user.dart';
import 'package:mepaga_ai/data/remote/models/user_rm.dart';

extension UserRMMappers on UserRM {
  User toDM() => User(
        name: name,
        email: email,
        pixKey: pixKey,
      );
}
