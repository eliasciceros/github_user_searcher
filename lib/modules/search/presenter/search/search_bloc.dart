import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/states/search_state.dart';

import '../../domain/usecases/search_by_text_interface.dart';

// Bloc requires an event and an state. In this case, a string and a SearchState.
class SearchBloc extends Bloc<String, SearchState> {
  late final SearchByTextInterface useCase;

  SearchBloc(this.useCase) : super(InitialState()) {
    on<String>(
      (event, emit) async {
        if (event.isEmpty) {
          return emit(InitialState());
        }

        emit(LoadingState());

        final result = await useCase(event);
        return emit(result.fold(
          (failure) => ErrorState(failure),
          (success) => SuccessState(success),
        ));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
