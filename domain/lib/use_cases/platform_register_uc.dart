import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class PlatformRegisterUC extends UseCase<PlatformRegisterUCParams, void> {
  PlatformRegisterUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<void> rawCall(PlatformRegisterUCParams params) =>
      repository.registerPlatform(
        platform: params.platform,
        email: params.email,
      );
}

class PlatformRegisterUCParams {
  final String platform;
  final String? email;

  PlatformRegisterUCParams({
    required this.platform,
    this.email,
  });
}
