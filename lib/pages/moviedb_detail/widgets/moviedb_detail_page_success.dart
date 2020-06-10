import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movidblist/pages/moviedb_detail/bloc/bloc.dart';

class DetailPageSuccess extends StatelessWidget {
  final DetailPageStateSuccess state;
  DetailPageSuccess({this.state});

  BoxDecoration _buildGradientBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.0, 0.7, 0.7],
        colors: [
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(state.item.title),
                  Text(
                      state.item.releaseDate.year.toString(),
                      style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: state.item.posterUrl,
                    placeholderFadeInDuration: Duration(milliseconds: 400),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: _buildGradientBackground(),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
            <Widget>[
              Row(
                children: <Widget>[
                  RatingBar(
                    itemSize: 16,
                    initialRating: state.item.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 10,
                    itemPadding: EdgeInsets.all(5),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Text(state.item.rating.toString()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Text(
                    state.item.body,
                    style: TextStyle(fontSize: 17),
                ),
              ),
            ],
            )
          )
        ],
      ),
    );
  }
}
