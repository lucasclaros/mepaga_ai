import 'package:domain/exceptions.dart';
import 'package:domain/logger.dart';

abstract class UseCase<P, R> {
  UseCase({
    required this.logger,
  });

  final ErrorLogger logger;

  Future<R> rawCall(P params);

  Future<R> call(P params) async {
    try {
      return await rawCall(params);
    } catch (error, stacktrace) {
      await logger('UseCase Error', error, stacktrace);

      if (error is MPGException) {
        rethrow;
      } else {
        throw UnexpectedException();
      }
    }
  }
}

class NoParams {}
