import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class CacheJwtUC extends UseCase<CacheJwtUCParams, void> {
  CacheJwtUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<void> rawCall(CacheJwtUCParams params) => repository.cacheJWT(
        params.jwt,
      );
}

class CacheJwtUCParams {
  CacheJwtUCParams({required this.jwt});

  final String jwt;
}
