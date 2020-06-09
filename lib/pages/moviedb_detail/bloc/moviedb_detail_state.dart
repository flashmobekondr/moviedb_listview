import 'package:equatable/equatable.dart';

abstract class MoviedbDetailState extends Equatable {
  const MoviedbDetailState();
}

class InitialMoviedbDetailState extends MoviedbDetailState {
  @override
  List<Object> get props => [];
}
