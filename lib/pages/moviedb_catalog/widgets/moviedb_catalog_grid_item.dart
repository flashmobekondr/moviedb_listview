import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movidblist/pages/moviedb_catalog/model/moviedb_catalog_model.dart';
import 'package:movidblist/pages/moviedb_detail/bloc/bloc.dart';
import 'package:movidblist/pages/moviedb_detail/moviedb_detail_page.dart';
import 'package:transparent_image/transparent_image.dart';


class GridItem extends StatelessWidget {
  final PostModel post;
  GridItem({this.post});

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
    return Material(
      child: InkWell(
        onTap: () {
          Navigator
              .of(context)
              .push(MaterialPageRoute(
            builder:(context){
              BlocProvider.of<DetailPageBloc>(context).add(DetailPageGetDetail(id: post.id));
              return DetailPage();
            },
          )
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: post.posterUrl,
              placeholderFadeInDuration: Duration(milliseconds: 400),
            ),
//            FadeInImage.memoryNetwork(
//              placeholder: kTransparentImage,
//              image: post.posterUrl,
//            ),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: _buildGradientBackground(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}