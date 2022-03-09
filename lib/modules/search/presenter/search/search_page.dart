import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/bloc/search_bloc.dart';

import '../../domain/entities/result_search_entity.dart';
import '../../domain/errors/errors.dart';
import 'bloc/states/search_state.dart';
import 'search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchController> {
  @override
  void initState() {
    controller.searchPagination.setupScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.searchPagination.disposeScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Search"),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: TextField(
            // ,
            onChanged: (newValue) {
              controller.searchBloc.searchedWord = newValue;
              controller.searchBloc.add(newValue);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Type your search...",
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            bloc: controller.searchBloc,
            builder: (context, state) {
              if (state is ErrorState){
                return _buildErrorWidget(state.error);
              }
              if (state is InitialState){
                return _buildInitialWidget();
              } else if (state is LoadingState) {
                return _buildResultListWidget(state.list, false, true, state.isFirstSearch);
              } else if (state is SuccessState) {
                return _buildResultListWidget(state.list, state.hasReachedMax, false, false);
              } else {
                return Container();
              }
            }
          ),
        ),
      ]),
    );
  }

  Widget _buildResultListWidget(List<ResultSearchEntity> resultList, bool hasReachedMax, bool isLoading, bool isFirstSearch) {
    if (isLoading && isFirstSearch) {
      return _buildLoadingWidget();
    }

    if (resultList.isEmpty) {
      return const Center(child: Text('Não há usuários com esse username'));
    }

    return ListView.builder(
      // ListView is Scrollable and so needs size. But i do not know the size, so I use expanded.
      // Furthermore, we can pass our scroll controller to make a pagination mechanism
      itemCount: resultList.length + (isLoading ? 1 : 0),
      controller: controller.searchPagination.scrollController,
      itemBuilder: (_, index) {
        if (index < resultList.length) {
          return _githubUserWidget(resultList[index]);
        } else {
          controller.searchPagination.jumpToMaxBottomScrollPosition();
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildInitialWidget() {
    return const Center(
      child: Text('Digite alguma coisa...'),
    );
  }

  Widget _buildErrorWidget(FailureSearchInterface error) {
    if (error is EmptyList) {
      return const Center(
        child: Text('Nada encontrado'),
      );
    } else if (error is ExternalError) {
      return const Center(
        child: Text('Erro no github'),
      );
    } else if (error is InvalidSearchTextError) {
      return const Center(
        child: Text('Texto digitado é inválido'),
      );
    } else {
      return const Center(
        child: Text('Erro interno'),
      );
    }
  }
}

  Widget _githubUserWidget(ResultSearchEntity resultSearch) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(resultSearch.image),
      ),
      title: Text(resultSearch.title),
      subtitle: Text(resultSearch.description),
    );
  }