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
        throw UnexpectedException(
          message: error.response!.data['message'] ?? 'Something went wrong',
        );
      }
      throw UnexpectedException(message: 'Something went wrong');
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
      if (error is DioException) {
        if (error.response?.statusCode == 409) {
          throw UserAlreadyExistsException();
        }

        if (error.response?.statusCode == 400) {
          throw InvalidInputException();
        }
      }

      rethrow;
    }
  }

  Future<String> verifyOTP({
    required String email,
    required String code,
  }) async {
    try {
      print("TESTE ${email} ${code}");

      final response = await dio.post(
        UrlBuilder.endpointOtpValidation,
        data: {
          'email': email,
          'code': code,
        },
      );
      print("TESTE ${response.data}");
      return response.data['auth'];
    } catch (error) {
      print("TESTE ${error}");
      if (error is DioException && error.response?.statusCode == 404) {
        throw UserNotFoundException();
      }
      rethrow;
    }
  }
}
