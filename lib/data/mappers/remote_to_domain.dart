import 'package:domain/models/user_auth.dart';
import 'package:mepaga_ai/data/remote/models/user_auth_rm.dart';

extension UserAuthRMMappers on UserAuthRM {
  UserAuth toDM() => UserAuth(
        auth: auth,
        name: name ?? '',
      );
}
