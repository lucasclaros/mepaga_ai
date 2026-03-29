import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class ValidateBymaEmailUC extends UseCase<ValidateBymaEmailUCParams, void> {
  ValidateBymaEmailUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<void> rawCall(ValidateBymaEmailUCParams params) =>
      repository.checkBymaEmail(
        email: params.email,
      );
}

class ValidateBymaEmailUCParams {

  ValidateBymaEmailUCParams({
    required this.email,
  });
  final String email;
}
