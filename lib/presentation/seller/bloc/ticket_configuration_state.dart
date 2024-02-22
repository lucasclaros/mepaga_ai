part of 'ticket_configuration_bloc.dart';

@immutable
abstract class TicketConfigurationState {}

class TicketConfigurationInitial extends TicketConfigurationState {}

class GetTicketInfoLoading extends TicketConfigurationState {}

class GetTicketInfoSuccess extends TicketConfigurationState {
  GetTicketInfoSuccess({required this.ticket});

  final Ticket ticket;
}

class GetTicketInfoError extends TicketConfigurationState {
  GetTicketInfoError(this.error);

  final String error;
}

class TicketAlreadySold extends TicketConfigurationState {}

class RegisterTicketInfoLoading extends TicketConfigurationState {}

class RegisterTicketInfoSuccess extends TicketConfigurationState {}

class RegisterTicketInfoError extends TicketConfigurationState {
  RegisterTicketInfoError(this.error);

  final String error;
}
