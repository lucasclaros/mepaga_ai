part of 'platform_registration_bloc.dart';

@immutable
abstract class PlatformRegistrationEvent {}

class PlatformRegistrationStarted extends PlatformRegistrationEvent {
  PlatformRegistrationStarted(this.platformName);

  final String platformName;
}

class ListUserPlatforms extends PlatformRegistrationEvent {}

class RegisterPlatform extends PlatformRegistrationEvent {
  RegisterPlatform({
    required this.platform,
    this.email,
  });

  final String platform;
  final String? email;
}
