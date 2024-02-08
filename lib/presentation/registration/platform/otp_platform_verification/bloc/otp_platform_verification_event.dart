part of 'otp_platform_verification_bloc.dart';

@immutable
abstract class OtpPlatformVerificationEvent {}

class OtpPlatformVerificationSend extends OtpPlatformVerificationEvent {
  OtpPlatformVerificationSend({
    required this.code,
    required this.platform,
  });

  final String platform;
  final String code;
}
