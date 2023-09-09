abstract class IAuthRepository {
  Future<String> login({
    required String email,
    required String password,
  });

  Future<void> cacheJWT(String jwt);

  Future<String?> getJWT();

  Future<void> logout();
}
