import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';
import 'package:mepaga_ai/data/remote/data_source/auth_data_source.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required this.rds,
    required this.cds,
  });

  final AuthRDS rds;
  final OnlineCDS cds;

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
    return cds.logout();
  }

  @override
  Future<void> cacheJWT(String authToken) {
    return cds.cacheJWT(authToken);
  }

  @override
  Future<String?> getJWT() {
    return cds.getJWT();
  }

  @override
  Future<void> registerUser({
    required String name,
    required String userEmail,
    required String password,
  }) {
    return rds.registerUser(
      name: name,
      userEmail: userEmail,
      password: password,
    );
  }

  @override
  Future<String> verifyOTP({
    required String param,
    required String data,
    required String code,
  }) {
    return rds.verifyOTP(
      param: param,
      data: data,
      code: code,
    );
  }
}
