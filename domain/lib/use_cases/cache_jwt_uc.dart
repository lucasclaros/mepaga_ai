import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class CacheJwtUC extends UseCase<CacheJwtUCParams, void> {
  final IAuthRepository repository;

  CacheJwtUC({
    required super.logger,
    required this.repository,
  });

  @override
  Future<void> rawCall(CacheJwtUCParams params) => repository.cacheJWT(
        params.jwt,
      );
}

class CacheJwtUCParams {
  final String jwt;

  CacheJwtUCParams({required this.jwt});
}
