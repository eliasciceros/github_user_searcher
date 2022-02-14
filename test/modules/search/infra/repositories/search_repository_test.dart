import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/infra/datasources/search_datasource_interface.dart';
import 'package:searches_clean_arch/modules/search/infra/models/result_search_model.dart';
import 'package:searches_clean_arch/modules/search/infra/repositories/search_repository.dart';

// Mock by hand for practice
class SearchDatasourceMock implements SearchDatasourceInterface{
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    return <ResultSearchModel>[];
  }
}

class SearchDatasourceErrorMock implements SearchDatasourceInterface{
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) {
    throw Exception();
  }
}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepository(datasource);

  test("Must return a ResultSearchEntity list", () async {
    final result = await repository.search("searchText");
    expect(result | <ResultSearchEntity>[], isA<List<ResultSearchEntity>>());
  });

  test("Must return a FailureSearchInterface error if datasource fails for some unexpected reason (that means, a generic Exception())", () async {
    final datasource = SearchDatasourceErrorMock();
    final errorRepository = SearchRepository(datasource);
    final result = await errorRepository.search("searchText");
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}