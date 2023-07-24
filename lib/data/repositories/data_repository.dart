import 'package:domain/models/user.dart';
import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:mepaga_ai/data/mappers/remote_to_domain.dart';
import 'package:mepaga_ai/data/remote/data_source/auth_data_source.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({required this.rds});

  final AuthRDS rds;

  @override
  Future<User> verifyOTP({
    required String email,
    required String code,
  }) async {
    final user = await rds.validateOTP(userEmail: email, code: code);
    return user.toDM();
  }
}
