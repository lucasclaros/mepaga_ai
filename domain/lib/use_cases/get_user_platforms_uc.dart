import 'package:domain/models/platform.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetUserPlatformsUC extends UseCase<NoParams, List<Platform>> {
  GetUserPlatformsUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<List<Platform>> rawCall(NoParams params) => repository.getPlatforms();
}
