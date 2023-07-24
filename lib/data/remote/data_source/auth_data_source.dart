import 'package:dio/dio.dart';
import 'package:domain/exceptions.dart';
import 'package:mepaga_ai/data/remote/infra/url_builder.dart';
import 'package:mepaga_ai/data/remote/models/user_rm.dart';

class AuthRDS {
  AuthRDS({
    required this.dio,
  });

  final Dio dio;

  Future<UserRM> validateOTP({
    required String userEmail,
    required String code,
  }) async {
    try {
      final response = await dio.post(
        UrlBuilder.endpointOtpValidation,
        data: {
          'email': userEmail,
          'code': code,
        },
      );
      final user = UserRM.fromJson(response.data);
      return UserRM(
        id: user.id,
        profile: user.profile,
        email: userEmail,
      );
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 404) {
        throw UserNotFoundException();
      }
      rethrow;
    }
  }

  Future<void> registerUser({
    required String userEmail,
    required String password,
  }) async {
    try {
      await dio.post(
        UrlBuilder.endpointUserRegistration,
        data: {
          'email': userEmail,
          'password': password,
        },
      );
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 404) {
        throw UserAlreadyExistsException();
      }
      rethrow;
    }
  }
}
