import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MoviedbDetailBloc extends Bloc<MoviedbDetailEvent, MoviedbDetailState> {
  @override
  MoviedbDetailState get initialState => InitialMoviedbDetailState();

  @override
  Stream<MoviedbDetailState> mapEventToState(
    MoviedbDetailEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
