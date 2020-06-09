import 'package:http/http.dart';
import 'package:movidblist/core/network/network_info.dart';
import 'package:movidblist/pages/moviedb_catalog/data/local_data_source/moviedb_catalog_local_data_source.dart';
import 'package:movidblist/pages/moviedb_catalog/data/remote_data_source/moviedb_catalog_remote_data_source.dart';
import 'package:movidblist/pages/moviedb_catalog/model/moviedb_catalog_model.dart';
import 'package:tuple/tuple.dart';

abstract class CatalogPageRepository {
  Future<Tuple2<int,List<PostModel>>> fetchPost(int page);
}

class CatalogPageRepositoryImpl implements CatalogPageRepository {
  final NetworkInfo networkInfo;
  final CatalogPageRemoteDataSource remoteDataSource;
  final CatalogPageLocalDataSource localDataSource;

  CatalogPageRepositoryImpl({
    this.networkInfo,
    this.remoteDataSource,
    this.localDataSource
  });

  @override
  Future<Tuple2<int,List<PostModel>>> fetchPost(int page) async {
    if (await networkInfo.isConnected) {                       // Если есть интернет соединение ТО
      try {
        final posts = await remoteDataSource.fetchPosts(page); // Загрузка данных ТО
        if(page == 1) {                                        // Если загрузка первой страницы - очистка старого кэша ТО
          await localDataSource.clearCache();
        }
        final postsToCache = List.generate(
            posts.item2.length,
            (index) => PostModel.toMap(posts.item2[index]),
        );
      await localDataSource.cachePost(postsToCache);            // Кэширование !
        return posts;                                           // Отправка загруженных данных !
      }
      catch(_) {
        throw Exception('error fetching data');
      }
    } else {                                                     // Если нет интернет соединения И
      if (page == 1) {                                           // Если загрузка первой страницы ТО
          final cachedPosts = await localDataSource.getPost();    // Загрузка данных из кэша ->

          if( cachedPosts.isNotEmpty) {
            return Tuple2(page,cachedPosts);                      // Отправка кэшированных данных !
          } else {
            return Tuple2(page,[]);                               // Если  пустой кэш ТО
          }                                                       // Отправка пустого массива
      } else {
        return Tuple2(page,[]);                                   // Если нет интернет соединения И
      }                                                           // Запрос страницы с номером 2 и выше ТО
    }                                                             // Отправка пустого массива !
  }
}