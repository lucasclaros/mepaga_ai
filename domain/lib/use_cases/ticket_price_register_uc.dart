import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class TicketPriceRegisterUC extends UseCase<TicketPriceRegisterUCParams, void> {
  TicketPriceRegisterUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<void> rawCall(TicketPriceRegisterUCParams params) =>
      repository.registerTicketPrice(
        ticketId: params.ticketId,
        ticketPrice: params.ticketPrice,
      );
}

class TicketPriceRegisterUCParams {
  final String ticketId;
  final double ticketPrice;

  TicketPriceRegisterUCParams({
    required this.ticketId,
    required this.ticketPrice,
  });
}
