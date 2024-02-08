// ignore_for_file: avoid_dynamic_calls, unnecessary_lambdas

import 'package:dio/dio.dart';
import 'package:domain/exceptions.dart';
import 'package:mepaga_ai/data/remote/infra/url_builder.dart';
import 'package:mepaga_ai/data/remote/models/platform_rm.dart';
import 'package:mepaga_ai/data/remote/models/ticket_rm.dart';
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

  Future<List<TicketRM>> getTickets() async {
    try {
      final response = await dio.get(UrlBuilder.endpointUserTickets);
      final tickets =
          (response.data as List).map((e) => TicketRM.fromJson(e)).toList();
      return tickets;
    } catch (error) {
      if (error is DioException && error.response != null) {
        throw UnexpectedException(
          message: error.response!.data['message'] ?? 'Something went wrong',
        );
      }
      throw UnexpectedException(message: 'Something went wrong');
    }
  }

  Future<List<PlatformRM>> getPlatforms() async {
    try {
      final response = await dio.get(UrlBuilder.endpointUserPlatforms);
      final platforms = (response.data as List).map((e) {
        return PlatformRM.fromJson(e);
      }).toList();
      return platforms;
    } catch (error) {
      if (error is DioException && error.response != null) {
        throw UnexpectedException(
          message: error.response!.data['message'] ?? 'Something went wrong',
        );
      }
      throw UnexpectedException(message: 'Something went wrong');
    }
  }

  Future<void> registerPlatform({
    required String platform,
    String? email,
  }) async {
    try {
      await dio.post(
        UrlBuilder.endpointPlatformRegister,
        data: {
          'platform': platform,
          'email': email,
        },
      );
    } catch (error) {
      if (error is DioException && error.response != null) {
        throw PlatformNotFoundException(
          message: error.response!.data['message'] ?? 'Something went wrong',
        );
      }
      throw UnexpectedException(message: 'Something went wrong');
    }
  }

  Future<void> checkPlatform({required String platform}) async {
    try {
      print('Checking platform: $platform');
      final response = await dio.get(
        UrlBuilder.endpointPlatformCheck(platform),
        data: {
          'platform': platform,
        },
      );

      if (response.statusCode == 202) {
        throw FoundAccountNoAssociation();
      }
    } catch (error) {
      if (error is DioException &&
          error.response != null &&
          error.response!.statusCode != 404) {
        throw PlatformNotFoundException(
          message: error.response!.data['message'] ?? 'Something went wrong',
        );
      }
    }
  }
}
