import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class OTPVerificationUC extends UseCase<OTPVerificationUCParams, String?> {
  OTPVerificationUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<String?> rawCall(OTPVerificationUCParams params) =>
      repository.verifyOTP(
        param: params.param,
        data: params.data,
        code: params.code,
      );
}

class OTPVerificationUCParams {
  OTPVerificationUCParams({
    required this.param,
    required this.data,
    required this.code,
  });

  final String param;
  final String data;
  final String code;
}
