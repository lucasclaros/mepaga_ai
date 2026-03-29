part of 'profile_settings_bloc.dart';

@immutable
abstract class ProfileSettingsState {}

class ProfileSettingsInitial extends ProfileSettingsState {}

class ProfileSettingsLoading extends ProfileSettingsState {}

class ProfileSettingsSuccess extends ProfileSettingsState {}

class ProfileSettingsError extends ProfileSettingsState {
  ProfileSettingsError({required this.message});

  final String message;
}

class ProfileSettingsLogoutLoading extends ProfileSettingsState {}

class ProfileSettingsLogoutSuccess extends ProfileSettingsState {}

class ProfileSettingsLogoutError extends ProfileSettingsState {
  ProfileSettingsLogoutError({required this.message});

  final String message;
}
