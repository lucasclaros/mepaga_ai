part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationEvent {}

class OtpVerificationSend extends OtpVerificationEvent {
  OtpVerificationSend({
    required this.code,
    required this.email,
  });

  final String email;
  final String code;
}
