import 'package:domain/models/user.dart';

abstract class IAuthRepository {
  Future<User> verifyUserEmail(String userEmail);

  Future<bool> verifyUserOtp(User user);
}
