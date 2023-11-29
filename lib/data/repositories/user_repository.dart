import 'package:domain/models/user.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:mepaga_ai/data/mappers/remote_to_domain.dart';
import 'package:mepaga_ai/data/remote/data_source/user_data_source.dart';

class UserRepository implements IUserRepositoryInterface {
  UserRepository({
    required this.rds,
  });
  final UserRDS rds;

  @override
  Future<User> getInfo() async {
    final user = await rds.getInfo();
    return user.toDM();
  }
}
