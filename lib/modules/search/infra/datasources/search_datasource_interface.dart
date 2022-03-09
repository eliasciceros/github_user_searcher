import '../models/result_search_model.dart';

abstract class SearchDatasourceInterface {
  Future<List<ResultSearchModel>> getSearch(String searchText, {int page = 1});
}