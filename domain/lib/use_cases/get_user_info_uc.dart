import 'package:domain/models/user.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetUserInfoUC extends UseCase<NoParams, User> {
  GetUserInfoUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<User> rawCall(NoParams params) => repository.getInfo();
}
