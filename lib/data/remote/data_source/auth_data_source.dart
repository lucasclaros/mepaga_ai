// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:domain/exceptions.dart';
import 'package:mepaga_ai/data/remote/infra/url_builder.dart';

class AuthRDS {
  AuthRDS({
    required this.dio,
  });

  final Dio dio;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        UrlBuilder.endpointUserLogin,
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data['auth'];
    } catch (error) {
      if (error is DioException && error.response != null) {
        final errorMessage = error.response!.data['message'];
        if (error.response!.statusCode == 401) {
          throw InvalidCredentialsException(errorMessage);
        }

        if (error.response!.statusCode == 412) {
          throw OTPNotVerifiedException(errorMessage);
        }
      }
      rethrow;
    }
  }

  Future<void> registerUser({
    required String name,
    required String userEmail,
    required String password,
  }) async {
    try {
      await dio.post(
        UrlBuilder.endpointUserRegistration,
        data: {
          'name': name,
          'email': userEmail,
          'password': password,
        },
      );
    } catch (error) {
      if (error is DioException && error.response != null) {
        final errorMessage = error.response!.data['message'];
        if (error.response!.statusCode == 409) {
          throw UserAlreadyExistsException(errorMessage);
        }

        if (error.response!.statusCode == 400) {
          throw InvalidEmailException(errorMessage);
        }
      }
      rethrow;
    }
  }

  Future<String?> verifyOTP({
    required String param,
    required String data,
    required String code,
  }) async {
    final isEmailOtp = param == 'email';
    try {
      final response = await dio.post(
        isEmailOtp
            ? UrlBuilder.endpointOtpRegisterEmailValidation
            : UrlBuilder.endpointPlatformEmailValidation,
        data: {
          param: data,
          'code': code,
        },
      );

      return response.data['auth'];
    } catch (error) {
      if (error is DioException && error.response != null) {
        final statusCode = error.response!.statusCode;
        final errorMessage = error.response!.data['message'];

        if (statusCode == 404) {
          OTPWrongCode(errorMessage);
        }

        if (statusCode == 410) {
          OTPExpired(errorMessage);
        }

        if (statusCode == 401) {
          throw InvalidToken(errorMessage);
        }
      }
      rethrow;
    }
  }
}
