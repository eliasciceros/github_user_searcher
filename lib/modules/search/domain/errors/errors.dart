abstract class FailureSearchInterface implements Exception {}

class InvalidSearchTextError implements FailureSearchInterface {}

class DatasourceError implements FailureSearchInterface {
  // add possibility to external database implementation send a message
  late final String message;

  DatasourceError({this.message = ''});
}