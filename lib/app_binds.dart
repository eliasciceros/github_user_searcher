import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:searches_clean_arch/modules/search/domain/usecases/search_by_text.dart';
import 'package:searches_clean_arch/modules/search/external/datasources/github_datasource.dart';
import 'package:searches_clean_arch/modules/search/infra/repositories/search_repository.dart';

final appBinds = <Bind>[
  Bind((i) => Dio()),
  Bind((i) => GithubDatasource(i())),
  Bind((i) => SearchRepository(i())),
  Bind((i) => SearchByText(i())),
];