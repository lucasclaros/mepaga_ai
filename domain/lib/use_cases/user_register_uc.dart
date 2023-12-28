import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class UserRegisterUC extends UseCase<UserRegisterUCParams, void> {
  UserRegisterUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<void> rawCall(UserRegisterUCParams params) => repository.registerUser(
        userEmail: params.email,
        password: params.password,
        name: params.name,
      );
}

class UserRegisterUCParams {
  UserRegisterUCParams({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;
}
