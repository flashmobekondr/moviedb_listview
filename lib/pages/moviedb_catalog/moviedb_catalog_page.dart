import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movidblist/pages/moviedb_catalog/widgets/moviedb_catalog_widgets.dart';

import 'bloc/bloc.dart';



class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  CatalogPageBloc _catalogPageBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _catalogPageBloc = BlocProvider.of<CatalogPageBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<CatalogPageBloc, CatalogPageState>(
        builder: (context, state) {
          if (state is CatalogPagePostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is CatalogPagePostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return GridList(
              state: state,
              controller: _scrollController,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _catalogPageBloc.add(CatalogPageFetchEvent());
    }
  }
}