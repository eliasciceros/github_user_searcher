import 'package:dartz/dartz.dart';
import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';
import 'package:searches_clean_arch/modules/search/domain/repositories/search_repository_interface.dart';
import 'package:searches_clean_arch/modules/search/domain/usecases/search_by_text_interface.dart';

class SearchByText implements SearchByTextInterface{
  final SearchRepositoryInterface repository;

  SearchByText(this.repository);

  @override
  Future<Either<FailureSearchInterface, List<ResultSearchEntity>>> call(String searchText, {int page = 1}) async {
    if (searchText.isEmpty){
      return Left(InvalidSearchTextError());
    }

    return repository.search(searchText, page: page);
  }
}