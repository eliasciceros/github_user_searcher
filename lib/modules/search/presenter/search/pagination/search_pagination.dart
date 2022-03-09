import 'dart:async';

import 'package:flutter/material.dart';

import '../bloc/search_bloc.dart';

class SearchPagination {
  late final SearchBloc searchBloc;
  var scrollController = ScrollController();

  SearchPagination(this.searchBloc);

  void setupScrollController() {
    // Fetch more result at the end of the scrolling
    scrollController.addListener(_onScrollListener);
  }

  void disposeScrollController(){
    // Remove the listener and dispose
    scrollController
      ..removeListener(_onScrollListener)
      ..dispose();
  }

  void _onScrollListener () {
    if (isBottomPosition) {
      searchBloc.add(searchBloc.searchedWord);
    }
  }

  bool get isBottomPosition {
    // scrollController has clients and the current position is >= then max position
    if (!scrollController.hasClients) {
      return false;
    }
    // return scrollController.offset >= (scrollController.position.maxScrollExtent * 0.9);
    return ((scrollController.position.atEdge) && (scrollController.position.pixels != 0));
  }

  void jumpToMaxBottomScrollPosition(){
    Timer(const Duration(milliseconds: 30), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}