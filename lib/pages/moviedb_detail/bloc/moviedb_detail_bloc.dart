import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movidblist/pages/moviedb_detail/model/moviedb_detail_model.dart';
import 'package:movidblist/pages/moviedb_detail/repository/moviedb_detail_repository.dart';
import './bloc.dart';

class DetailPageBloc extends Bloc<DetailPageEvent, DetailPageState> {
  final DetailPageRepository repository;
  DetailPageBloc({this.repository});
  @override
  DetailPageState get initialState => DetailPageStateEmpty();

  @override
  Stream<DetailPageState> mapEventToState(DetailPageEvent event) async* {
    if(event is DetailPageGetDetail) {
      yield DetailPageStateLoading();
      try {
        final result = await repository.fetchPost(event.id);
        yield DetailPageStateSuccess(item: result);
      }
      catch(error) {
        yield DetailPageStateError(error);
      }
    }
  }
}

