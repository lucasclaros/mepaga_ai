import 'package:domain/models/user.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetCacheValueUC extends UseCase<NoParams, User> {
  final IUserRepositoryInterface repository;

  GetCacheValueUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<User> rawCall(NoParams params) => repository.getInfo();
}
