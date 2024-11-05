class Failure {
  final String error;
  final String? statusCode;

  Failure({
    required this.error,
    this.statusCode,
  });
}

class ServerFailure extends Failure {
  ServerFailure({String error = 'Server Failure'}) : super(error: error);
}
