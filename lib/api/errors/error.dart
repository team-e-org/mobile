mixin DefaultError implements Exception {
  String getMessage();
}

class NetworkError implements DefaultError {
  @override
  String getMessage() => "No internet connection";
}

class ForbiddenServerError implements DefaultError {
  @override
  String getMessage() => "(403) You dont have access to this content.";
}

class NotFoundError implements DefaultError {
  final String url;
  NotFoundError(this.url);

  @override
  String getMessage() => "(404) not found\n$url";
}

class UnauthorizedError implements DefaultError {
  @override
  String getMessage() => "(401) Unathorized connection";
}

class UnprocessableEntity implements DefaultError {
  @override
  String getMessage() => "(422) Unprocessable Entity";
}

class UnknownClientError implements DefaultError {
  @override
  String getMessage() {
    return "Unknown client error\n$_error";
  }

  final dynamic _error;

  UnknownClientError(this._error);
}

class UnknownServerError implements DefaultError {
  @override
  String getMessage() {
    return "Unknown server error ($statusCode)\n$_error";
  }

  final dynamic _error;
  final int statusCode;

  UnknownServerError(this._error, this.statusCode);
}
