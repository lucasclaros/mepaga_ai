// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:domain/exceptions.dart';
import 'package:mepaga_ai/data/remote/infra/url_builder.dart';
import 'package:mepaga_ai/data/remote/models/user_rm.dart';

class UserRDS {
  UserRDS({
    required this.dio,
  });

  final Dio dio;

  Future<UserRM> getInfo() async {
    try {
      final response = await dio.get(
        UrlBuilder.endpointUserInfo,
      );
      final user = UserRM.fromJson(response.data);
      return user;
    } catch (error) {
      if (error is DioException && error.response != null) {
        throw UnexpectedException(
          message: error.response!.data['message'] ?? 'Something went wrong',
        );
      }
      throw UnexpectedException(message: 'Something went wrong');
    }
  }
}
