part of 'add_email_platform_bloc.dart';

@immutable
abstract class AddEmailPlatformState {}

class AddEmailPlatformInitial extends AddEmailPlatformState {}

class SendEmailPlatformOtpSuccess extends AddEmailPlatformState {}

class SendEmailPlatformOtpLoading extends AddEmailPlatformState {}

class SendEmailPlatformOtpError extends AddEmailPlatformState {
  SendEmailPlatformOtpError({required this.message});

  final String message;
}
