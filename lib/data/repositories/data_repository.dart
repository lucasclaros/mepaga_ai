import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:mepaga_ai/data/remote/data_source/auth_data_source.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({required this.rds});

  final AuthRDS rds;

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final userAuth = await rds.login(email: email, password: password);
    return userAuth;
  }

  @override
  Future<void> logout() {
    return rds.logout();
  }

  @override
  Future<void> cacheValue({required String key, required String value}) {
    return rds.cacheValue(key, value);
  }

  @override
  Future<String?> getValueFromCache({required String key}) {
    return rds.getValueFromCache(key);
  }

  // @override
  // Future<dynamic> verifyOTP({
  //   required String email,
  //   required String code,
  // }) async {
  //   final user = await rds.validateOTP(userEmail: email, code: code);
  //   return user.toDM();
  // }
}
