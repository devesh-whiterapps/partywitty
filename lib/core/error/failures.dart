// core/error/failures.dart
abstract class Failure {
  final String message;
  Failure(this.message);
}
class ServerFailure extends Failure {
  ServerFailure(super.message);
}

// core/error/exceptions.dart
class ServerException implements Exception {}