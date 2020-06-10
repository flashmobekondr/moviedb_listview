import 'dart:async';

import 'package:movidblist/pages/moviedb_detail/model/moviedb_detail_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DetailPageLocalDataSource {
  Future<List<DetailPostModel>> getPost(int id);
  Future<void> cachePost(DetailPostModel postToCache);
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
            rating REAL
            )
            '''
        );
      },
      version: _databaseVersion,
    );
  }

  static Database db;

  @override
  Future<void> cachePost(DetailPostModel postToCache) async{
    db = await _getDatabase();
    print('atemption 4');
    await db.insert(
        _table,
        DetailPostModel.toMap(postToCache),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> clearCache() async{
    db = await _getDatabase();
    await db.execute('DELETE FROM $_table');
  }

  @override
  Future<List<DetailPostModel>> getPost(int id) async{
    db = await _getDatabase();
    final List<Map<String, dynamic>> map = await db.query(
        _table,
      where: "id = ?",
      whereArgs: [id]
    );
    if( map.isNotEmpty) {
      return List.generate(
          map.length,
              (index) {
            return DetailPostModel.fromMap(map[index]);
          }
      );
    } else {
      return [DetailPostModel()];
    }
  }

}