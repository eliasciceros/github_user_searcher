import 'package:searches_clean_arch/modules/search/domain/entities/result_search_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:searches_clean_arch/modules/search/domain/errors/errors.dart';

abstract class SearchByTextInterface{
  Future<Either<FailureSearchInterface, List<ResultSearchEntity>>> call(String searchText, {int page = 1});
}