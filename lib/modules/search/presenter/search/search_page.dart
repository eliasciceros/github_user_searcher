import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:searches_clean_arch/modules/search/presenter/search/search_bloc.dart';

import '../../domain/entities/result_search_entity.dart';
import '../../domain/errors/errors.dart';
import 'states/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchBloc> {
  Widget _buildResultList(List<ResultSearchEntity> resultList) {
    return ListView.builder(
      // ListView is Scrollable and so needs size. But i do not know the size, so I use expanded.
      itemCount: resultList.length,
      itemBuilder: (_, index) {
        final item = resultList[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(item.title),
          subtitle: Text(item.description),
        );
      },
    );
  }

  Widget _buildError(FailureSearchInterface error) {
    if (error is EmptyList) {
      return const Center(
        child: Text('Nada encontrado'),
      );
    } else if (error is ExternalError) {
      return const Center(
        child: Text('Erro no github'),
      );
    } else {
      return const Center(
        child: Text('Erro interno'),
      );
    }
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
            onChanged: controller.add,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Type your search...",
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            bloc: controller,
            builder: (context, state) {
              if (state is ErrorState){
                return _buildError(state.error);
              }

              if (state is InitialState){
                return const Center(
                  child: Text('Digite alguma coisa...'),
                );
              } else if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessState) {
                return _buildResultList(state.list);
              } else {
                return Container();
              }
            }
          ),
        ),
      ]),
    );
  }
}
