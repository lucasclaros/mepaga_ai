import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class CheckPlatformUC extends UseCase<CheckPlatformUCParams, void> {
  CheckPlatformUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<void> rawCall(CheckPlatformUCParams params) =>
      repository.checkPlatform(
        platform: params.platform,
      );
}

class CheckPlatformUCParams {

  CheckPlatformUCParams({
    required this.platform,
  });
  final String platform;
}
