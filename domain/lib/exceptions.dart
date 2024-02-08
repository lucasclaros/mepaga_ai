abstract class MPGException implements Exception {
  MPGException({this.message = 'Unexpected error occurred.'});

  final String message;
}

class UnexpectedException extends MPGException {
  UnexpectedException({super.message});
}

class UserNotFoundException extends MPGException {}

class UserAlreadyExistsException extends MPGException {}

class CacheValueNotFoundException extends MPGException {}

class InvalidInputException extends MPGException {}

class PlatformNotFoundException extends MPGException {
  PlatformNotFoundException({super.message = 'Platform not found.'});
}
