abstract class RepositoryException implements Exception {
  final String systemError;
  final String userError;

  const RepositoryException({required this.systemError, required this.userError});
}

class DataBaseCreationException extends RepositoryException {
  const DataBaseCreationException({
    required String systemError,
    required String userError,
  }) : super(
          systemError: systemError,
          userError: userError,
        );
}

class DataTransformerException extends RepositoryException {
  const DataTransformerException({
    required String systemError,
    required String userError,
  }) : super(
          systemError: systemError,
          userError: userError,
        );
}

abstract class DataBaseException extends RepositoryException {
  const DataBaseException({
    required String systemError,
    required String userError,
  }) : super(
          systemError: systemError,
          userError: userError,
        );
}

class FetchTableException extends DataBaseException {
  const FetchTableException({
    required String systemError,
    required String userError,
  }) : super(
          systemError: systemError,
          userError: userError,
        );
}

class FetchRowException extends DataBaseException {
  const FetchRowException({
    required String systemError,
    required String userError,
  }) : super(
          systemError: systemError,
          userError: userError,
        );
}

class UpdateDatabaseException extends DataBaseException {
  const UpdateDatabaseException({
    required String systemError,
    required String userError,
  }) : super(
          systemError: systemError,
          userError: userError,
        );
}
