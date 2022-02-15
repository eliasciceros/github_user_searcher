import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';

import '../../../domain/entities/result_search_entity.dart';

abstract class SearchState {}

class InitialState implements SearchState {}

class LoadingState implements SearchState {}

class ErrorState implements SearchState {
  final FailureSearchInterface error;
  const ErrorState(this.error);
}

class SuccessState implements SearchState {
  late final List<ResultSearchEntity> list;
  SuccessState(this.list);
}