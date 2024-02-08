part of 'platform_registration_bloc.dart';

@immutable
abstract class PlatformRegistrationEvent {}

class PlatformRegistrationStarted extends PlatformRegistrationEvent {
  PlatformRegistrationStarted(this.platformName);

  final String platformName;
}

class ListUserPlatforms extends PlatformRegistrationEvent {
  ListUserPlatforms({this.initialLoading = true});

  final bool initialLoading;
}

class RegisterPlatform extends PlatformRegistrationEvent {
  RegisterPlatform({
    required this.platform,
    this.email,
  });

  final String platform;
  final String? email;
}

class CheckUserPlatform extends PlatformRegistrationEvent {
  CheckUserPlatform({required this.platform});

  final String platform;
}
