import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entities/result_search_entity.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/search_repository_interface.dart';
import '../datasources/search_datasource_interface.dart';

class SearchRepository implements SearchRepositoryInterface{
  final SearchDatasourceInterface datasource;

  SearchRepository(this.datasource);

  @override
  Future<Either<FailureSearchInterface, List<ResultSearchEntity>>> search(String searchText, {int page = 1}) async {
    try{
      final result = await datasource.getSearch(searchText, page:page);
      return Right(result);
    } on DatasourceError catch (e) {
      debugPrint("[DATASOURCE ERROR] - ${e.message}");
      return Left(e);
    } on InvalidSearchTextError catch (e) {
      debugPrint("[INVALID SEARCH TEXT ERROR]");
      return Left(e);
    } on EmptyList catch (e) {
      debugPrint("[EMPTY LIST ERROR]");
      return Left(e);
    } on Exception catch (e) {
      //TODO: Erro 403 for "internal error"
      debugPrint("[UNEXPECTED ERROR] - ${e.toString()}");
      return Left(DatasourceError());
    } catch (e) {
      debugPrint("[UNEXPECTED ERROR] - ${e.toString()}");
      return Left(DatasourceError());
    }
  }
}