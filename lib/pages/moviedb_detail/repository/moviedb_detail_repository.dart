import 'package:movidblist/core/network/network_info.dart';
import 'package:movidblist/pages/moviedb_detail/data/local_data_source/moviedb_detail_local_data_source.dart';
import 'package:movidblist/pages/moviedb_detail/data/remote_data_source/moviedb_detail_remote_data_source.dart';
import 'package:movidblist/pages/moviedb_detail/model/moviedb_detail_model.dart';

abstract class DetailPageRepository {
  Future<DetailPostModel> fetchPost (int id);
}

class DetailPageRepositoryImpl implements DetailPageRepository {
  final DetailPageRemoteDataSource remoteDataSource;
  final DetailPageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  DetailPageRepositoryImpl({
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo
  });
  @override
  Future<DetailPostModel> fetchPost(int id) async{
    if(await networkInfo.isConnected) {
      return _fetchIfConnectionIsOn(id);
    } else return _fetchIfConnectionIsOff(id);
  }

  Future<DetailPostModel> _fetchIfConnectionIsOn(int id) async {
    final post = await remoteDataSource.fetchDetail(id);
    await localDataSource.cachePost(post);
    return post;
  }

  Future<DetailPostModel> _fetchIfConnectionIsOff(int id) async {
      final cachedPost = await localDataSource.getPost(id);
        return cachedPost.first;
  }
}