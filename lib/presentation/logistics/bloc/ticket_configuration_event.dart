part of 'ticket_configuration_bloc.dart';

@immutable
abstract class TicketConfigurationEvent {}

class GetTicketInfo extends TicketConfigurationEvent {
  GetTicketInfo({required this.ticketId});

  final String ticketId;
}

class RegisterTicketInfo extends TicketConfigurationEvent {
  RegisterTicketInfo({
    required this.ticketId,
    required this.ticketPrice,
  });

  final String ticketId;
  final double ticketPrice;
}
