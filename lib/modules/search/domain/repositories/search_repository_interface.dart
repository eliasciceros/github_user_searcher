import 'package:dartz/dartz.dart';

import '../entities/result_search_entity.dart';
import '../errors/errors.dart';

// Only interface of repositories comes to Domain layer
abstract class SearchRepositoryInterface{
  Future<Either<FailureSearchInterface, List<ResultSearchEntity>>> search(String searchText, {int page = 1});
}