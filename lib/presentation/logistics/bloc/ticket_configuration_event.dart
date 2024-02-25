part of 'ticket_configuration_bloc.dart';

@immutable
abstract class TicketConfigurationEvent {}

class GetTicketInfo extends TicketConfigurationEvent {
  GetTicketInfo({required this.ticketId, this.isBuy = false});

  final String ticketId;
  final bool isBuy;
}

class RegisterTicketInfo extends TicketConfigurationEvent {
  RegisterTicketInfo({
    required this.ticketId,
    required this.ticketPrice,
  });

  final String ticketId;
  final double ticketPrice;
}
