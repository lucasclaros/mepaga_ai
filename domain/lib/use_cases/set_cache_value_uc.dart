import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class SetCacheValueUC extends UseCase<SetCacheValueUCParams, void> {
  final IAuthRepository repository;

  SetCacheValueUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<void> rawCall(SetCacheValueUCParams params) => repository.cacheValue(
        key: params.key,
        value: params.value,
      );
}

class SetCacheValueUCParams {
  final String key;
  final String value;

  SetCacheValueUCParams({
    required this.key,
    required this.value,
  });
}
