import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnlineCDS {
  OnlineCDS({
    required this.secureStorage,
  });

  final _onlineAuthTokenKey = 'online_jwt_auth';

  final FlutterSecureStorage secureStorage;

  Future<String?> getJWT() async {
    try {
      return secureStorage.read(key: _onlineAuthTokenKey);
    } catch (e) {
      print('Error reading JWT: $e');
      return null;
    }
  }

  Future<void> cacheJWT(String authToken) async {
    return secureStorage.write(
      key: _onlineAuthTokenKey,
      value: authToken,
    );
  }

  Future<void> logout() async => secureStorage.delete(key: _onlineAuthTokenKey);
}
