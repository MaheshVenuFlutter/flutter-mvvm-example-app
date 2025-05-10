// Base exception class that implements Dart's built-in Exception class.
// This allows for creating custom exceptions with a message and prefix.
class AppException implements Exception {
  // Optional error message describing what went wrong.
  final String? message;

  // Optional prefix to categorize or describe the type of exception.
  final String? prefix;

  // Constructor with optional named parameters.
  // You can pass a message and a prefix when creating the exception.
  AppException([this.message, this.prefix]);

  // Override the default toString() method to return a readable error message.
  @override
  String toString() {
    return '${prefix ?? ''}: ${message ?? ''}';
  }
}

// Exception for network errors or server communication failures.
class FetchDataException extends AppException {
  // Passes a specific message and a fixed prefix to the base class.
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

// Exception for bad or invalid requests (usually 400-level HTTP errors).
class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message, 'Invalid Request');
}

// Exception for unauthorized access (like HTTP 401/403).
class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request');
}

// Exception for invalid input given by the user.
class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, 'Invalid Input');
}
// Exception for when a requested resource is not found (HTTP 404).
class NotFoundException extends AppException {
  NotFoundException([String? message])
      : super(message, 'Resource Not Found');
}
// Exception for when a request takes too long and times out.
class RequestTimeoutException extends AppException {
  RequestTimeoutException([String? message])
      : super(message, 'Request Timed Out');
}
// Exception for server-side errors (HTTP 500 series).
class ServerErrorException extends AppException {
  ServerErrorException([String? message])
      : super(message, 'Server Error');
}

