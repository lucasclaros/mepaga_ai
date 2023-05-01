import 'package:domain/models/user.dart';
import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:mepaga_ai/data/mappers/remote_to_domain.dart';
import 'package:mepaga_ai/data/remote/data_source/auth_data_source.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({required this.rds});

  final AuthRDS rds;

  @override
  Future<User> verifyUserEmail(String userEmail) async {
    final user = await rds.validateEmailUser(userEmail: userEmail);
    return user.toDM();
  }

  @override
  Future<bool> verifyUserOtp(User user) {
    throw UnimplementedError();
  }
}
