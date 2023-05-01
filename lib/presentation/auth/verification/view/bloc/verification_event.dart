part of 'verification_bloc.dart';

@immutable
abstract class VerificationEvent {}

class EmailVerificationRequest extends VerificationEvent {
  EmailVerificationRequest({
    required this.userEmail,
  });

  final String userEmail;
}
