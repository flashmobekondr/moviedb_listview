import 'package:equatable/equatable.dart';
import 'package:movidblist/pages/moviedb_detail/model/moviedb_detail_model.dart';

abstract class DetailPageState extends Equatable {
  const DetailPageState();
  @override
  List<Object> get props => [];
}

class DetailPageStateEmpty extends DetailPageState {}

class DetailPageStateLoading extends DetailPageState {}

class DetailPageStateSuccess extends DetailPageState {
  final DetailPostModel item;

  DetailPageStateSuccess({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'DetailPageStateSuccess: {items: $item';
}

class DetailPageStateError extends DetailPageState {
  final String error;

  const DetailPageStateError(this.error);

  @override
  List<Object> get props => [error];
}
