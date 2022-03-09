import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:searches_clean_arch/modules/search/infra/models/result_search_model.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/bloc/states/search_state.dart';

import '../../../domain/entities/result_search_entity.dart';
import '../../../domain/usecases/search_by_text_interface.dart';

// Bloc requires an event and an state. In this case, a string and a SearchState.
class SearchBloc extends Bloc<String, SearchState> {
  late final SearchByTextInterface useCase;
  String searchedWord = '';
  int page = 1;

  SearchBloc(this.useCase) : super(InitialState()) {
    on<String>(
      _onStringSearch,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  FutureOr<void> _onStringSearch(String event, Emitter<SearchState> emit) async {
    // TODO: implement logic for reached max result widget (like fetching more github users).
    // Case empty string event
    if (event.isEmpty) {
      return emit(InitialState());
    }

    // Case loading
    if (state is LoadingState) {
      return;
    }

    // final oldResults = state is SuccessState ? (state as SuccessState).list : <ResultSearchEntity>[];
    final oldResults = <ResultSearchEntity>[];

    if (state is SuccessState) {
      if ((state as SuccessState).searchedString != event) {
        page = 1;
      } else {
        oldResults.addAll((state as SuccessState).list);
      }
    }

    emit(LoadingState(oldResults, isFirstSearch: page == 1));

    // Search
    final resultList = await useCase(event, page: page);

    return emit(resultList.fold(
      (failureResult) => ErrorState(failureResult),
      (successResult) {
        page++;
        if (successResult.isEmpty) {
          return SuccessState(oldResults, event, hasReachedMax: true);
        } else {
          oldResults.addAll(successResult.map((e) => e as ResultSearchModel).toList());
          return SuccessState(oldResults, event);
        }
      },
    ));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
