import 'package:domain/models/user.dart';

abstract class IAuthRepository {
  Future<User> verifyOTP({
    required String email,
    required String code,
  });
}
