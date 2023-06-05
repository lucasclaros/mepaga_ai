import 'package:dio/dio.dart';
import 'package:domain/exceptions.dart';
import 'package:mepaga_ai/data/remote/infra/url_builder.dart';
import 'package:mepaga_ai/data/remote/models/user_rm.dart';

class AuthRDS {
  AuthRDS({
    required this.dio,
  });

  final Dio dio;

  Future<UserRM> validateEmailUser({required String userEmail}) async {
    try {
      final response = await dio.post(
        UrlBuilder.endpointEmailValidation,
        data: {
          'email': userEmail,
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
}
