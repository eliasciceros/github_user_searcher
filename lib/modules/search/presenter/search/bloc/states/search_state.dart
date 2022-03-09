import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';

import '../../../../domain/entities/result_search_entity.dart';

abstract class SearchState {}

class InitialState implements SearchState {}

class LoadingState implements SearchState {
  late final List<ResultSearchEntity> list;
  late final bool isFirstSearch;

  LoadingState(this.list, {this.isFirstSearch = false});
}

class SuccessState implements SearchState {
  late final List<ResultSearchEntity> list;
  late final String searchedString;
  bool hasReachedMax;

  SuccessState(this.list, this.searchedString, {this.hasReachedMax = false});
}

class ErrorState implements SearchState {
  final FailureSearchInterface error;

  const ErrorState(this.error);
}