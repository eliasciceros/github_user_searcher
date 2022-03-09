import 'package:dio/dio.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/infra/datasources/search_datasource_interface.dart';
import 'package:searches_clean_arch/modules/search/infra/models/result_search_model.dart';

import '../utils/github/github_consts.dart';

extension on String {
  // Now, string variables can use normalize method
  normalize () {
    return this.replaceAll(" ", "+"); // can be "%20" too
  }
}

class GithubDatasource implements SearchDatasourceInterface{
  late final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText, {int page = 1}) async {
    final response = await dio.get("$githubBaseUrl${searchText.normalize()}&per_page=$githubPerPageLimit&page=$page");

    if (response.statusCode == 200){
      return (response.data["items"] as List).map((e) => ResultSearchModel.fromMap(e)).toList();
    }
    // We already uses try catch on Repository implementation, so we don't need it here.
    else {
      throw DatasourceError(message: "Datasource retrieve error. StatusCode = ${response.statusCode}. StatusMessage = ${response.statusMessage}");
    }
  }
}