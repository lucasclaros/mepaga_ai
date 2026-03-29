part of 'payment_registration_bloc.dart';

@immutable
abstract class PaymentRegistrationEvent {}

class RegisterPix extends PaymentRegistrationEvent {
  RegisterPix({
    required this.pixKey,
    required this.keyType,
  });

  final String pixKey;
  final String keyType;
}
