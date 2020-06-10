import 'package:equatable/equatable.dart';
import 'package:movidblist/pages/moviedb_catalog/model/moviedb_catalog_model.dart';

class DetailPostModel extends Equatable {
  final int id;
  final String title;
  final String posterUrl;
  final String body;
  final DateTime releaseDate;
  final double rating;

  DetailPostModel({
    this.id,
    this.title,
    this.posterUrl,
    this.body,
    this.releaseDate,
    this.rating
  });


  factory DetailPostModel.fromJson(Map<String, dynamic> json) {
    final String _posterBodyUrl = 'https://image.tmdb.org/t/p/w500';
    return DetailPostModel(
        id: json['id'],
        title: json['title'],
        posterUrl: _posterBodyUrl+ json['poster_path'],
        body: json['overview'],
        releaseDate: DateTime.parse(json['release_date']),
        rating: json['vote_average']
    );
  }

  static Map<String, dynamic> toMap (DetailPostModel post) {
    return {
      'id': post.id,
      'title': post.title,
      'posterUrl': post.posterUrl,
      'body': post.body,
      'releaseDate': post.releaseDate.toString(),
      'rating': post.rating
    };
  }

  static DetailPostModel fromMap (Map<String, dynamic> map) {
    return DetailPostModel(
        id: map['id'],
        title: map['title'],
        posterUrl: map['posterUrl'],
        body: map['body'],
        releaseDate: DateTime.parse(map['releaseDate']),
        rating: map['rating']
    );
  }

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'DetailPostModel: id: $id';
}