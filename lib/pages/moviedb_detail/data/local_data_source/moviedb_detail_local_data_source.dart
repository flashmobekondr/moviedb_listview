import 'dart:async';

import 'package:movidblist/pages/moviedb_detail/model/moviedb_detail_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DetailPageLocalDataSource {
  Future<DetailPostModel> getPost();
  Future<void> cachePost(Map<String, dynamic> postToCache);
  Future<void> clearCache ();
}

class DetailPageLocalDataSourceImpl implements DetailPageLocalDataSource {
  final _databaseName = "detail_database.db";
  final _databaseVersion = 1;
  final _table = 'details';

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
            '''CREATE TABLE $_table(
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterUrl TEXT,
            body TEXT,
            releaseDate TEXT,
            rating DOUBLE
            )
            '''
        );
      },
      version: _databaseVersion,
    );
  }

  static Database db;

  @override
  Future<void> cachePost(Map<String, dynamic> postToCache) {
    // TODO: implement cachePost
    throw UnimplementedError();
  }

  @override
  Future<void> clearCache() {
    // TODO: implement clearCache
    throw UnimplementedError();
  }

  @override
  Future<DetailPostModel> getPost() {
    // TODO: implement getPost
    throw UnimplementedError();
  }

}