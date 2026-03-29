part of 'login_bloc.dart';

@immutable
abstract class LoginBlocState {}

class LoginBlocInitial extends LoginBlocState {}

class LoginBlocLoading extends LoginBlocState {}

class LoginBlocSuccess extends LoginBlocState {}

class LoginBlocError extends LoginBlocState {
  LoginBlocError({required this.message});

  final String message;
}

class LoginBlocInvalidCredentials extends LoginBlocError {
  LoginBlocInvalidCredentials({required super.message});
}

class LoginBlocOTPNotVerified extends LoginBlocError {
  LoginBlocOTPNotVerified({required super.message});
}
