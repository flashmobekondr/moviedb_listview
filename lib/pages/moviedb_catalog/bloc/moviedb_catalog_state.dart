import 'package:equatable/equatable.dart';
import 'package:movidblist/pages/moviedb_catalog/model/moviedb_catalog_model.dart';

abstract class CatalogPageState extends Equatable {
  const CatalogPageState();

  @override
  List<Object> get props => [];
}

class CatalogPagePostUninitialized extends CatalogPageState {}
class CatalogPagePostRefreshLoading extends CatalogPageState {}
class CatalogPagePostError extends CatalogPageState {}

class CatalogPagePostLoaded extends CatalogPageState {
  final List<PostModel> posts;
  final bool hasReachedMax;
  final int page;

  const CatalogPagePostLoaded({
    this.posts,
    this.hasReachedMax,
    this.page,
  });

  CatalogPagePostLoaded copyWith({
    List<PostModel> posts,
    bool hasReachedMax,
  }) {
    return CatalogPagePostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax, page];

  @override
  String toString() =>
      'CatalogPagePostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax, page: $page}';
}