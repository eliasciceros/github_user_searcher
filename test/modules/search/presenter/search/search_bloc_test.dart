import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/domain/usecases/search_by_text_interface.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/search_bloc.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/states/search_state.dart';

class SearchByTextMock extends Mock implements SearchByTextInterface {}
class MockCounterBloc extends MockBloc<String, SearchState> implements SearchBloc {}

main() {
  final useCase = SearchByTextMock();
  var searchBloc = MockCounterBloc();
  searchBloc.useCase = useCase;

  test("Must return the states in the right order, ignoring initial state", () {
    final result = <ResultSearchEntity>[];
    when(() => useCase.call(any())).thenAnswer((_) async => Right(result));
    whenListen(searchBloc, Stream.fromIterable([LoadingState(), SuccessState(result)]));

    expect(searchBloc.stream, emitsInOrder([
      isA<LoadingState>(),
      isA<SuccessState>(),
    ]));
  });

  test("Must return error", () {
    final error = InvalidSearchTextError();
    when(() => useCase.call(any())).thenAnswer((_) async => Left(error));
    whenListen(searchBloc, Stream.fromIterable([LoadingState(), ErrorState(error)]));

    expect(searchBloc.stream, emitsInOrder([
      isA<LoadingState>(),
      isA<ErrorState>(),
    ]));
  });
}