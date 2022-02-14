import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:searches_clean_arch/app_module.dart';
import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:searches_clean_arch/modules/search/domain/usecases/search_by_text_interface.dart';
import 'package:searches_clean_arch/modules/search/external/utils/github/github_consts.dart';

class DioMock extends Mock implements Dio{}

main() {
  final dio = DioMock();

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test("Must retrieve the userCase to test the Dependency Injection System flow", (){
    final useCase = Modular.get<SearchByTextInterface>(); // pick the interface
    expect(useCase, isA<SearchByTextInterface>());
  });
  
  test("Integration test - Must recover a ResultSearch list", () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(data: jsonDecode(githubResultExample), statusCode: 200, requestOptions: RequestOptions(path: '')));

    final useCase = Modular.get<SearchByTextInterface>();
    final result = await useCase("searchText");

    expect (result | <ResultSearchEntity>[], isA<List<ResultSearchEntity>>());
  });
}