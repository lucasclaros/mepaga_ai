import 'package:domain/use_cases/use_case.dart';
import 'package:email_validator/email_validator.dart';

class EmailValidationUC extends UseCase<EmailVerifciationUCParams, bool> {
  EmailValidationUC({
    required super.logger,
  });

  @override
  Future<bool> rawCall(EmailVerifciationUCParams params) {
    final email = params.text;
    final isEmailValid = EmailValidator.validate(email);

    if (isEmailValid) {
      return Future.value(true);
    }

    return Future.value(false);
  }
}

class EmailVerifciationUCParams {
  EmailVerifciationUCParams({required this.text});

  final String text;
}
