import 'package:domain/models/user_auth.dart';

abstract class IAuthRepository {
  Future<UserAuth> login({
    required String email,
    required String password,
  });
}
