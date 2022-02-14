import 'package:bloc/bloc.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/states/state.dart';

import '../../domain/usecases/search_by_text_interface.dart';

// Bloc requires an input and an output. In this case, a string and a state.
class SearchBloc extends Bloc<String, SearchState> {
  final SearchByTextInterface useCase;

  SearchBloc(this.useCase) : super(SearchStart());

  Stream<SearchState> mapEventToState(String searchText) async* {
    // TODO: map events to states
  }
}