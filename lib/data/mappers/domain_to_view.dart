import 'package:domain/models/user.dart';
import 'package:mepaga_ai/data/models/user_vm.dart';

extension UserMappers on User {
  UserVM toVM() => UserVM(
        name: name,
        email: email,
        pixKey: pixKey,
      );
}
