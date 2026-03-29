import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class UserLogoutUC extends UseCase<NoParams, void> {
  UserLogoutUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<void> rawCall(NoParams _) => repository.logout();
}
