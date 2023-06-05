import 'package:domain/models/user.dart';
import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class EmailVerificationUC extends UseCase<EmailVerificationUCParams, User> {
  final IAuthRepository repository;

  EmailVerificationUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<User> rawCall(EmailVerificationUCParams params) =>
      repository.verifyUserEmail(
        params.userEmail,
      );
}

class EmailVerificationUCParams {
  EmailVerificationUCParams({required this.userEmail});

  final String userEmail;
}
