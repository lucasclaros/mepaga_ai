import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mepaga_ai/data/cache/data_source/online_cds.dart';

class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor({required this.onlineCDS});

  final OnlineCDS onlineCDS;
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await onlineCDS.getJWT();
      print('TESTE interc: $accessToken');

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
