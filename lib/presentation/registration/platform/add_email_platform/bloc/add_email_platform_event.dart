part of 'add_email_platform_bloc.dart';

@immutable
abstract class AddEmailPlatformEvent {}

class SendEmailPlatformOtp extends AddEmailPlatformEvent {
  SendEmailPlatformOtp({
    required this.platform,
    required this.email,
  });

  final String platform;
  final String email;
}
