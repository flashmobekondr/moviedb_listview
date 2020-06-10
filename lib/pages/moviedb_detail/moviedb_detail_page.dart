import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movidblist/pages/moviedb_detail/bloc/bloc.dart';
import 'package:movidblist/pages/moviedb_detail/widgets/moviedb_detail_page_success.dart';


class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<DetailPageBloc, DetailPageState>(
      builder: (context, state){
        if (state is DetailPageStateLoading) {
          return Center(
              child: CircularProgressIndicator()
          );
        }
        if (state is DetailPageStateError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('${state.error}'),
            ),
          );
        }
        if(state is DetailPageStateSuccess) {
          return DetailPageSuccess(
            state: state,
          );
        }
        return Text('');
      },
    );
  }
}