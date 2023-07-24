import 'package:domain/models/user.dart';
import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class OTPVerificationUC extends UseCase<OTPVerificationUCParams, User> {
  final IAuthRepository repository;

  OTPVerificationUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<User> rawCall(OTPVerificationUCParams params) =>
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
