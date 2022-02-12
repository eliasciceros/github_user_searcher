import 'package:dartz/dartz.dart';

import '../../domain/entities/result_search_entity.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/search_repository_interface.dart';
import '../datasources/search_datasource.dart';

class SearchRepository implements SearchRepositoryInterface{
  final SearchDatasource datasource;

  SearchRepository(this.datasource);

  @override
  Future<Either<FailureSearchInterface, List<ResultSearchEntity>>> search(String searchText) async {
    try{
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}