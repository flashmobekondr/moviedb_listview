import 'package:movidblist/core/network/network_info.dart';
import 'package:movidblist/pages/moviedb_detail/data/remote_data_source/moviedb_detail_remote_data_source.dart';
import 'package:movidblist/pages/moviedb_detail/model/moviedb_detail_model.dart';

abstract class DetailPageRepository {
  Future<DetailPostModel> fetchPost (int id);
}

class DetailPageRepositoryImpl implements DetailPageRepository {
  final DetailPageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  DetailPageRepositoryImpl({
    this.remoteDataSource,
    this.networkInfo
  });
  @override
  Future<DetailPostModel> fetchPost(int id) async{
    if(await networkInfo.isConnected) {
      return remoteDataSource.fetchDetail(id);
    } else throw Exception();
  }
}