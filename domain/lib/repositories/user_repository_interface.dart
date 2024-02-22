import 'package:domain/models/platform.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/models/user.dart';

abstract class IUserRepositoryInterface {
  Future<User> getInfo();

  Future<List<Ticket>> getTickets();

  Future<List<Platform>> getPlatforms();

  Future<void> registerPlatform({
    required String platform,
    String? email,
  });

  Future<void> checkPlatform({required String platform});

  Future<void> registerPixKey({
    required String pixKey,
    required String keyType,
  });

  Future<Ticket> getTicketInfo({
    required String ticketId,
    bool isBuy = false,
  });

  Future<void> registerTicketPrice({
    required String ticketId,
    required double ticketPrice,
  });
}
