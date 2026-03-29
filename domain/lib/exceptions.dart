abstract class MPGException implements Exception {
  MPGException({this.message = 'Unexpected error occurred.'});

  final String message;
}

class UnexpectedException extends MPGException {
  UnexpectedException({super.message});
}

class UserNotFoundException extends MPGException {}

class UserAlreadyExistsException implements MPGException {
  UserAlreadyExistsException(this.message);

  @override
  final String message;
}

class CacheValueNotFoundException extends MPGException {}

class InvalidEmailException implements MPGException {
  InvalidEmailException(this.message);

  @override
  final String message;
}

class InvalidCredentialsException implements MPGException {
  InvalidCredentialsException(this.message);

  @override
  final String message;
}

class OTPNotVerifiedException implements MPGException {
  OTPNotVerifiedException(this.message);

  @override
  final String message;
}

class PlatformNotFoundException extends MPGException {
  PlatformNotFoundException({super.message = 'Platform not found.'});
}

class FoundAccountNoAssociation extends MPGException {}

class NoAccountFound extends MPGException {}

class OTPWrongCode implements MPGException {
  OTPWrongCode(this.message);

  @override
  final String message;
}

class OTPExpired implements MPGException {
  OTPExpired(this.message);

  @override
  final String message;
}

class InvalidToken implements MPGException {
  InvalidToken(this.message);

  @override
  final String message;
}

class EmailAlreadyExistsException extends MPGException {}

class TicketAlreadySoldException extends MPGException {}
