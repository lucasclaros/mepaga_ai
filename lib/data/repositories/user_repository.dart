import 'package:domain/models/platform.dart';
import 'package:domain/models/ticket.dart';
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

  @override
  Future<List<Ticket>> getTickets() async {
    final tickets = await rds.getTickets();
    return tickets.map((e) => e.toDM()).toList();
  }

  @override
  Future<List<Platform>> getPlatforms() async {
    final platforms = await rds.getPlatforms();
    return platforms.map((e) => e.toDM()).toList();
  }

  @override
  Future<void> registerPlatform({
    required String platform,
    String? email,
  }) async {
    await rds.registerPlatform(
      platform: platform,
      email: email,
    );
  }

  @override
  Future<void> checkPlatform({required String platform}) async {
    await rds.checkPlatform(platform: platform);
  }
}
