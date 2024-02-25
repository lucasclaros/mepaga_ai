part of 'payment_charge_bloc.dart';

@immutable
abstract class PaymentChargeState {}

class PaymentChargeInitial extends PaymentChargeState {}

class GetPaymentChargeLoading extends PaymentChargeState {}

class GetPaymentChargeSuccess extends PaymentChargeState {
  GetPaymentChargeSuccess({
    required this.paymentCharge,
  });

  final PaymentCharge paymentCharge;
}

class GetPaymentChargeFailure extends PaymentChargeState {
  GetPaymentChargeFailure({
    required this.error,
  });

  final String error;
}
