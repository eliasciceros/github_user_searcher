import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/search/domain/usecases/search_by_text.dart';
import 'modules/search/external/datasources/github_datasource.dart';
import 'modules/search/infra/repositories/search_repository.dart';
import 'modules/search/presenter/search/search_bloc.dart';

final appBinds = <Bind>[
  Bind((i) => Dio()),
  Bind((i) => GithubDatasource(i())),
  Bind((i) => SearchRepository(i())),
  Bind((i) => SearchByText(i())),
  Bind((i) => SearchBloc(i())),
];