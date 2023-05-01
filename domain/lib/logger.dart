typedef ErrorLogger = Future<void> Function(
  String errorType,
  dynamic error, [
  StackTrace? stackTrace,
]);
