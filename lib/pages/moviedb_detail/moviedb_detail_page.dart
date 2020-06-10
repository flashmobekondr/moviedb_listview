import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movidblist/pages/moviedb_detail/bloc/bloc.dart';


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
            return Scaffold(
                appBar: AppBar(
                  title: Text(state.item.title),
                ),
                body: ListView(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: state.item.posterUrl,
                      placeholderFadeInDuration: Duration(milliseconds: 400),
                    ),
                    Text(state.item.title),
                    Text(state.item.body),
                    Text(state.item.releaseDate.year.toString()),
                    Text(state.item.rating.toString()),
                    RatingBar(
                      itemSize: 16,
                      initialRating: state.item.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 10,
                      //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    )
                  ],
                )
            );
        }
        return Text('');
      },
    );
  }
}