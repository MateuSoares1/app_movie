abstract class AppError implements Exception {
  String? message;

  @override
  String toString() {
    return message!;
  }
}

class RepositoryError extends AppError {
  RepositoryError(String message) {
    this.message = message;
  }
}
