import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class UserLoginUC extends UseCase<UserLoginUCParams, String> {
  final IAuthRepository repository;

  UserLoginUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<String> rawCall(UserLoginUCParams params) => repository.login(
        email: params.email,
        password: params.password,
      );
}

class UserLoginUCParams {
  final String email;
  final String password;

  UserLoginUCParams({
    required this.email,
    required this.password,
  });
}
