import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:movidblist/core/network/network_info.dart';

import 'package:movidblist/pages/moviedb_catalog/bloc/moviedb_catalog_bloc.dart';
import 'package:movidblist/pages/moviedb_catalog/repository/moviedb_catalog_repository.dart';
import 'package:movidblist/pages/moviedb_catalog/data/remote_data_source/moviedb_catalog_remote_data_source.dart';
import 'package:movidblist/pages/moviedb_catalog/data/local_data_source/moviedb_catalog_local_data_source.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory(() => CatalogPageBloc(repository: sl()));

  //Repository
  sl.registerLazySingleton<CatalogPageRepository>(
          () =>CatalogPageRepositoryImpl(
            networkInfo: sl(),
            remoteDataSource: sl(),
            localDataSource: sl(),
          )
  );

  //Data sources
  sl.registerLazySingleton<CatalogPageRemoteDataSource>(
          () => CatalogPageRemoteDataSourceImpl(
            client: sl(),
          ) );
  sl.registerLazySingleton<CatalogPageLocalDataSource>(
          () => CatalogPageLocalDataSourceImpl());

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