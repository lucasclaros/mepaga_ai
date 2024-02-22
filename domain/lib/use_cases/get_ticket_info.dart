import 'package:domain/models/ticket.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetTicketInfoUC extends UseCase<GetTicketInfoUCParams, Ticket> {
  GetTicketInfoUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<Ticket> rawCall(GetTicketInfoUCParams params) =>
      repository.getTicketInfo(
        isBuy: params.isBuy,
        ticketId: params.ticketId,
      );
}

class GetTicketInfoUCParams {
  GetTicketInfoUCParams({
    required this.ticketId,
    this.isBuy = false,
  });

  final String ticketId;
  final bool isBuy;
}
