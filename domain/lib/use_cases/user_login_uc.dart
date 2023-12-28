import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class UserLoginUC extends UseCase<UserLoginUCParams, String> {
  UserLoginUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<String> rawCall(UserLoginUCParams params) => repository.login(
        email: params.email,
        password: params.password,
      );
}

class UserLoginUCParams {
  UserLoginUCParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
