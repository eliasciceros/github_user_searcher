abstract class FailureSearchInterface implements Exception {}

class InvalidSearchTextError extends FailureSearchInterface {}

class ExternalError extends FailureSearchInterface {}

class EmptyList extends FailureSearchInterface {}

class DatasourceError extends FailureSearchInterface {
  // add possibility to external database implementation send a message
  late final String message;

  DatasourceError({this.message = ''});
}