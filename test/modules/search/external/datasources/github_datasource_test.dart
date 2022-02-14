import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:searches_clean_arch/modules/search/external/utils/github/github_consts.dart';

// Internet access can overcharge the pipeline CI/CD server, so we mock the internet data retrieve
class DioMock extends Mock implements Dio{}

main() {
  final dio = DioMock();

  final datasource = GithubDatasource(dio);

  test("Must return a ResultSearchModel list", () {
    when(() => dio.get(any())).thenAnswer((_) async => Response(data: jsonDecode(githubResultExample), statusCode: 200, requestOptions: RequestOptions(path: '')));
    final future = datasource.getSearch("searchText");
    expect(future, completes); // If Future completes, then we have something
  });

  test("Must return a DatasourceError list", () {
    when(() => dio.get(any())).thenAnswer((_) async => Response(data: {}, statusCode: 401, requestOptions: RequestOptions(path: '')));
    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("Must return a Dio error", () {
    when(() => dio.get(any())).thenThrow(Exception());
    final future = datasource.getSearch("searchText");
    expect(future, throwsA(isA<Exception>()));
  });
}