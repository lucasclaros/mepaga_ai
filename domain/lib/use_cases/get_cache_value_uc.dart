import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetCacheValueUC extends UseCase<GetCacheValueUCParams, String?> {
  final IAuthRepository repository;

  GetCacheValueUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<String?> rawCall(GetCacheValueUCParams params) =>
      repository.getValueFromCache(
        key: params.key,
      );
}

class GetCacheValueUCParams {
  final String key;

  GetCacheValueUCParams({
    required this.key,
  });
}
