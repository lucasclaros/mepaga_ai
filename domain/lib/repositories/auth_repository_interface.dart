abstract class IAuthRepository {
  Future<String> login({
    required String email,
    required String password,
  });

  Future<void> cacheValue({required String key, required String value});

  Future<String?> getValueFromCache({required String key});

  Future<void> logout();
}
