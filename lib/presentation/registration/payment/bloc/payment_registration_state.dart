part of 'payment_registration_bloc.dart';

@immutable
abstract class PaymentRegistrationState {}

class PaymentRegistrationInitial extends PaymentRegistrationState {}

class RegisterPixLoading extends PaymentRegistrationInitial {}

class RegisterPixSuccess extends PaymentRegistrationInitial {}

class RegisterPixError extends PaymentRegistrationInitial {
  RegisterPixError({required this.message});

  final String message;
}
