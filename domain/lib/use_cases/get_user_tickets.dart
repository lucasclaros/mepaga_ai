import 'package:domain/models/ticket.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetUserTicketsUC extends UseCase<NoParams, List<Ticket>> {
  GetUserTicketsUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<List<Ticket>> rawCall(NoParams params) => repository.getTickets();
}
