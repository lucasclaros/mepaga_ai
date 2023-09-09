import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnlineCDS {
  OnlineCDS({
    required this.secureStorage,
  });

  final _onlineAuthTokenKey = 'online_jwt_auth';

  final FlutterSecureStorage secureStorage;

  Future<String?> getJWT() async =>
      secureStorage.read(key: _onlineAuthTokenKey);

  Future<void> cacheJWT(String authToken) async {
    print('TESTE cds $authToken');
    return secureStorage.write(
      key: _onlineAuthTokenKey,
      value: authToken,
    );
  }

  Future<void> logout() async => secureStorage.delete(key: _onlineAuthTokenKey);
}
