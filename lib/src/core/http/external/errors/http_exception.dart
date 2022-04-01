enum HttpErrorType {
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  serverError,
  timeout,
  noInternetConnection,
  unexpected,
}

class HttpError implements Exception {
  const HttpError({
    this.statusCode,
    this.message,
    this.errorType = HttpErrorType.serverError,
  });

  final int? statusCode;
  final String? message;
  final HttpErrorType errorType;
}
