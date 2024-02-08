part of 'platform_registration_bloc.dart';

@immutable
abstract class PlatformRegistrationState {}

class PlatformRegistrationInitial extends PlatformRegistrationState {}

class ListPlatformsSuccess extends PlatformRegistrationState {
  ListPlatformsSuccess({required this.platforms});

  final List<Platform> platforms;
}

class ListPlatformsLoading extends PlatformRegistrationState {}

class ListPlatformsError extends PlatformRegistrationState {
  ListPlatformsError({required this.message});

  final String message;
}

class RegisterPlatformSuccess extends PlatformRegistrationState {
  RegisterPlatformSuccess({required this.platform});

  final String platform;
}

class RegisterPlatformLoading extends PlatformRegistrationState {}

class RegisterPlatformError extends PlatformRegistrationState {
  RegisterPlatformError({required this.message});

  final String message;
}

class CheckUserPlatformSuccess extends PlatformRegistrationState {}

class CheckUserPlatformSuccessNoAssociation extends PlatformRegistrationState {}

class CheckUserPlatformSuccessNoAccount extends PlatformRegistrationState {}

class CheckUserPlatformLoading extends PlatformRegistrationState {}

class CheckUserPlatformError extends PlatformRegistrationState {
  CheckUserPlatformError({required this.message});

  final String message;
}

class SendEmailPlatformOtpSuccess extends PlatformRegistrationState {}

class SendEmailPlatformOtpLoading extends PlatformRegistrationState {}

class SendEmailPlatformOtpError extends PlatformRegistrationState {
  SendEmailPlatformOtpError({required this.message});

  final String message;
}
