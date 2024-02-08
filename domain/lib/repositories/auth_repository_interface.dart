abstract class IAuthRepository {
  Future<String> login({
    required String email,
    required String password,
  });

  Future<void> cacheJWT(String jwt);

  Future<String?> getJWT();

  Future<void> logout();

  Future<void> registerUser({
    required String name,
    required String userEmail,
    required String password,
  });

  Future<String> verifyOTP({
    required String param,
    required String data,
    required String code,
  });
}
