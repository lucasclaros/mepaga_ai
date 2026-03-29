import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnlineCDS {
  OnlineCDS({
    required this.secureStorage,
  });

  final _onlineAuthTokenKey = 'online_jwt_auth';
  final FlutterSecureStorage secureStorage;

  bool _jwtLoaded = false;
  String? _cachedJwt;

  bool get isJwtLoaded => _jwtLoaded;
  String? get cachedJwt => _cachedJwt;

  Future<String?> getJWT() async {
    if (_jwtLoaded) return _cachedJwt;
    try {
      _cachedJwt = await secureStorage.read(key: _onlineAuthTokenKey);
      _jwtLoaded = true;
      return _cachedJwt;
    } catch (e) {
      // ignore: avoid_print
      print('Error reading JWT: $e');
      return null;
    }
  }

  Future<void> cacheJWT(String authToken) async {
    _cachedJwt = authToken;
    _jwtLoaded = true;
    return secureStorage.write(
      key: _onlineAuthTokenKey,
      value: authToken,
    );
  }

  Future<void> logout() async {
    _cachedJwt = null;
    _jwtLoaded = false;
    return secureStorage.delete(key: _onlineAuthTokenKey);
  }
}
