part of 'verification_bloc.dart';

@immutable
abstract class VerificationState {}

class InitialState extends VerificationState {}

class ValidEmail extends VerificationState {
  ValidEmail({required this.user});

  final UserVM user;
}

class Loading extends VerificationState {}

class Error extends VerificationState {}

class InvalidEmail extends Error {}

class EmailNotFound extends Error {}

class UnexpectedError extends Error {}
