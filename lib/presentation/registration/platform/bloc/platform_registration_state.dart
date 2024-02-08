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

class RegisterPlatformSuccess extends PlatformRegistrationState {}

class RegisterPlatformError extends PlatformRegistrationState {
  RegisterPlatformError({required this.message});

  final String message;
}
