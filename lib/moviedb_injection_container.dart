import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:movidblist/core/network/network_info.dart';

import 'package:movidblist/pages/moviedb_catalog/bloc/bloc.dart';
import 'package:movidblist/pages/moviedb_catalog/repository/moviedb_catalog_repository.dart';
import 'package:movidblist/pages/moviedb_catalog/data/remote_data_source/moviedb_catalog_remote_data_source.dart';
import 'package:movidblist/pages/moviedb_catalog/data/local_data_source/moviedb_catalog_local_data_source.dart';

import 'package:movidblist/pages/moviedb_detail/bloc/bloc.dart';
import 'package:movidblist/pages/moviedb_detail/repository/moviedb_detail_repository.dart';
import 'package:movidblist/pages/moviedb_detail/data/remote_data_source/moviedb_detail_remote_data_source.dart';
import 'package:movidblist/pages/moviedb_detail/data/local_data_source/moviedb_detail_local_data_source.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory(() => CatalogPageBloc(repository: sl()));
  sl.registerFactory(() => DetailPageBloc(repository: sl()));

  //Repository
  sl.registerLazySingleton<CatalogPageRepository>(
          () =>CatalogPageRepositoryImpl(
            networkInfo: sl(),
            remoteDataSource: sl(),
            localDataSource: sl(),
          )
  );
  sl.registerLazySingleton<DetailPageRepository>(
          () => DetailPageRepositoryImpl(
            remoteDataSource: sl(),
            networkInfo: sl()
          )
  );

  //Data sources
  sl.registerLazySingleton<CatalogPageRemoteDataSource>(
          () => CatalogPageRemoteDataSourceImpl(
            client: sl(),
          ) );
  sl.registerLazySingleton<CatalogPageLocalDataSource>(
          () => CatalogPageLocalDataSourceImpl());

  sl.registerLazySingleton<DetailPageRemoteDataSource>(
          () => DetailPageRemoteDataSourceImpl(
            client: sl()
          )
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(
          connectionChecker: sl()
      )
  );

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}