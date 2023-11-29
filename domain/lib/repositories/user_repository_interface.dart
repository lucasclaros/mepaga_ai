import 'package:domain/models/user.dart';

abstract class IUserRepositoryInterface {
  Future<User> getInfo();

  // Future<List<Ticket>> getTickets();
}
