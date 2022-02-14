import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/domain/usecases/search_by_text_interface.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/states/state.dart';

class SearchByTextMock extends Mock implements SearchByTextInterface {}

main() {
  final useCase = SearchByTextMock();
  final bloc = SearchBloc(useCase);

  test("Must return the states in the right order, ignoring initial state", () {
    when(() => useCase.call(any())).thenAnswer((_) async => const Right(<ResultSearchEntity>[]));

    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchSuccess>(),
    ]));

    bloc.add("event");
  });

  test("Must return error", () {
    when(() => useCase.call(any())).thenAnswer((_) async => Left(InvalidSearchTextError()));

    expect(bloc, emitsInOrder([
      isA<SearchLoading>(),
      isA<SearchError>(),
    ]));

    bloc.add("event");
  });
}