import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      const _secureStorage = FlutterSecureStorage();
      final accessToken = await _secureStorage.read(key: 'jwt');

      if (accessToken != '') {
        options.headers.addAll(
          {
            'Authorization': accessToken,
          },
        );
      }
    } catch (_) {}

    handler.next(options);
  }
}
