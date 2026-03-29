part of 'payment_charge_bloc.dart';

@immutable
abstract class PaymentChargeEvent {}

class GetPaymentChargeEvent extends PaymentChargeEvent {
  GetPaymentChargeEvent({
    required this.ticketId,
    required this.transferEmail,
  });

  final String ticketId;
  final String transferEmail;
}
