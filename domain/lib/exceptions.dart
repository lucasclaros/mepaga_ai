abstract class MPGException implements Exception {
  final String message;

  MPGException({this.message = 'Unexpected error occurred.'});
}

class UnexpectedException extends MPGException {
  UnexpectedException({String message = 'Unexpected error occurred.'})
      : super(message: message);
}

class UserNotFoundException extends MPGException {}

class UserAlreadyExistsException extends MPGException {}

class CacheValueNotFoundException extends MPGException {}
