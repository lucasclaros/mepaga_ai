import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class OTPVerificationUC extends UseCase<OTPVerificationUCParams, String> {
  OTPVerificationUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<String> rawCall(OTPVerificationUCParams params) =>
      repository.verifyOTP(email: params.email, code: params.code);
}

class OTPVerificationUCParams {
  OTPVerificationUCParams({
    required this.email,
    required this.code,
  });

  final String email;
  final String code;
}
