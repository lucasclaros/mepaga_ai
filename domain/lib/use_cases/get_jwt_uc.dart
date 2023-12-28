import 'package:domain/repositories/auth_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetJwtUC extends UseCase<NoParams, String?> {
  GetJwtUC({
    required super.logger,
    required this.repository,
  });

  final IAuthRepository repository;

  @override
  Future<String?> rawCall(NoParams params) => repository.getJWT();
}
