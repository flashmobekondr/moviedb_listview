import 'package:flutter/material.dart';
import 'package:movidblist/pages/moviedb_catalog/bloc/bloc.dart';
import 'package:movidblist/pages/moviedb_catalog/widgets/moviedb_catalog_widgets.dart';


class GridList extends StatelessWidget {
  final CatalogPagePostLoaded state;
  final ScrollController controller;

  GridList({this.state,this.controller});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/3,
      ),
      itemBuilder: (context, index) {
        return index >= state.posts.length
            ? BottomLoader()
            : GridItem(post: state.posts[index]);
      },
      itemCount: state.hasReachedMax
          ? state.posts.length
          : state.posts.length + 1,
    );
  }
}