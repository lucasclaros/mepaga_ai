import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mepaga_ai/config/app_config.dart';

class _MockRoute {
  const _MockRoute({
    required this.method,
    required this.pathSuffix,
    required this.assetPath,
    this.delayMs = 700,
  });

  /// HTTP method to match ('GET', 'POST', 'PATCH', etc.) or '*' for any.
  final String method;

  /// Substring matched against the full request URL — order matters (most specific first).
  final String pathSuffix;

  final String assetPath;

  /// Per-route simulated latency. Auth actions use a longer delay so the
  /// loading state is visible in the demo; data fetches use a shorter one.
  final int delayMs;

  bool matches(String requestMethod, String requestPath) {
    final methodMatch = method == '*' || method == requestMethod.toUpperCase();
    final pathMatch = requestPath.contains(pathSuffix);
    return methodMatch && pathMatch;
  }
}

class MockInterceptor extends InterceptorsWrapper {
  // Routes ordered from most specific to least specific.
  static const _routes = [
    _MockRoute(method: 'POST', pathSuffix: '/user/login',             assetPath: 'assets/mock_data/login_success.json',             delayMs: 1400),
    _MockRoute(method: 'POST', pathSuffix: '/user/register',          assetPath: 'assets/mock_data/register_success.json',          delayMs: 1200),
    _MockRoute(method: 'POST', pathSuffix: '/user/validate-code',     assetPath: 'assets/mock_data/otp_success.json',               delayMs: 1200),
    _MockRoute(method: 'GET',  pathSuffix: '/user/tickets',           assetPath: 'assets/mock_data/user_tickets.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/user/platforms',         assetPath: 'assets/mock_data/user_platforms.json'),
    _MockRoute(method: 'POST', pathSuffix: '/user/platform/add',      assetPath: 'assets/mock_data/platform_register_success.json', delayMs: 1200),
    _MockRoute(method: 'POST', pathSuffix: '/user/platform/validate', assetPath: 'assets/mock_data/otp_success.json',               delayMs: 1200),
    _MockRoute(method: 'GET',  pathSuffix: '/user/platform/',         assetPath: 'assets/mock_data/platform_check_success.json'),
    _MockRoute(method: 'PATCH', pathSuffix: '/user/pix-key',          assetPath: 'assets/mock_data/pix_register_success.json',      delayMs: 1200),
    _MockRoute(method: 'GET',  pathSuffix: '/user/ticket/ticket_1',   assetPath: 'assets/mock_data/single_ticket_1.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/user/ticket/ticket_2',   assetPath: 'assets/mock_data/single_ticket_2.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/user/ticket/ticket_3',   assetPath: 'assets/mock_data/single_ticket_3.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/user/ticket/ticket_4',   assetPath: 'assets/mock_data/single_ticket_4.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/user/ticket/ticket_5',   assetPath: 'assets/mock_data/single_ticket_5.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/user/ticket/',           assetPath: 'assets/mock_data/single_ticket_1.json'),
    _MockRoute(method: 'GET',  pathSuffix: '/ticket/',                assetPath: 'assets/mock_data/single_ticket_generic.json'),
    _MockRoute(method: 'PATCH', pathSuffix: '/tickets/',              assetPath: 'assets/mock_data/ticket_price_success.json',      delayMs: 1200),
    _MockRoute(method: 'POST', pathSuffix: '/byma/validate',          assetPath: 'assets/mock_data/byma_validate_success.json',     delayMs: 1000),
    _MockRoute(method: 'POST', pathSuffix: '/payment/charge',         assetPath: 'assets/mock_data/payment_charge.json',            delayMs: 1200),
    _MockRoute(method: 'GET',  pathSuffix: '/user',                   assetPath: 'assets/mock_data/user_info.json'),
  ];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!kMockApiCalls) {
      return handler.next(options);
    }

    final route = _routes.cast<_MockRoute?>().firstWhere(
      (r) => r!.matches(options.method, options.path),
      orElse: () => null,
    );

    if (route == null) {
      return handler.next(options);
    }

    await Future.delayed(Duration(milliseconds: route.delayMs));

    try {
      final body = await rootBundle.loadString(route.assetPath);
      final data = body.trim().isEmpty ? null : json.decode(body);

      return handler.resolve(
        Response(
          requestOptions: options,
          data: data,
          statusCode: 200,
          statusMessage: 'OK (Mocked)',
        ),
      );
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'MockInterceptor: failed to load ${route.assetPath} — $e',
        ),
      );
    }
  }
}
