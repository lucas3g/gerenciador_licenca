abstract class ILicencaException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ILicencaException({
    required this.message,
    this.stackTrace,
  });
}

class LicencaException extends ILicencaException {
  const LicencaException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
