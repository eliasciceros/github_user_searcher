import 'bloc/search_bloc.dart';
import 'pagination/search_pagination.dart';

class SearchController {
  late final SearchBloc searchBloc;
  late final SearchPagination searchPagination;

  SearchController(this.searchBloc, this.searchPagination);
}