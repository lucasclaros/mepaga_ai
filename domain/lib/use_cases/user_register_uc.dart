import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class UserRegisterUC extends UseCase<UserRegisterUCParams, void> {
  final IAuthRepository repository;

  UserRegisterUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<void> rawCall(UserRegisterUCParams params) => repository.registerUser(
        userEmail: params.email,
        password: params.password,
        name: params.name,
      );
}

class UserRegisterUCParams {
  final String email;
  final String password;
  final String name;

  UserRegisterUCParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
