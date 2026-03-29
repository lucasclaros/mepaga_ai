part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationState {}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {}

class OtpVerificationError extends OtpVerificationState {
  OtpVerificationError({required this.message});

  final String message;
}

class OtpVerificationInvalidOtp extends OtpVerificationError {
  OtpVerificationInvalidOtp({required super.message});
}

class OtpVerificationOTPExpired extends OtpVerificationError {
  OtpVerificationOTPExpired({required super.message});
}
