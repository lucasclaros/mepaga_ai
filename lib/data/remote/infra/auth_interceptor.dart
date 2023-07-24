import 'package:dio/dio.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // final accessToken = await onlineCDS.getOnlineAuthToken();
      // final accessToken = '';

      // if (accessToken != null) {
      //   options.headers.addAll(
      //     {
      //       'Authorization': 'Bearer $accessToken',
      //     },
      //   );
      // }
    } catch (_) {}

    handler.next(options);
  }
}
