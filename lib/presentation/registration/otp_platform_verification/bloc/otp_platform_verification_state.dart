part of 'otp_platform_verification_bloc.dart';

@immutable
abstract class OtpPlatformVerificationState {}

class OtpPlatformVerificationInitial extends OtpPlatformVerificationState {}

class OtpPlatformVerificationLoading extends OtpPlatformVerificationState {}

class OtpPlatformVerificationSuccess extends OtpPlatformVerificationState {}

class OtpPlatformVerificationError extends OtpPlatformVerificationState {
  OtpPlatformVerificationError({required this.message});

  final String message;
}
