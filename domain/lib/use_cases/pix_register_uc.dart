import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class PixRegisterUC extends UseCase<PixRegisterUCParams, void> {
  PixRegisterUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<void> rawCall(PixRegisterUCParams params) => repository.registerPixKey(
        pixKey: params.pixKey,
        keyType: params.keyType,
      );
}

class PixRegisterUCParams {

  PixRegisterUCParams({
    required this.pixKey,
    required this.keyType,
  });
  final String pixKey;
  final String keyType;
}
