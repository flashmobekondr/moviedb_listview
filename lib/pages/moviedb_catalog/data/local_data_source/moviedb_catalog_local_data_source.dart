import 'dart:async';

import 'package:movidblist/pages/moviedb_catalog/model/moviedb_catalog_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class CatalogPageLocalDataSource {
  Future<List<PostModel>> getPost();
  Future<void> cachePost(List<Map<String, dynamic>> postsToCache);
  Future<void> clearCache ();
}

class CatalogPageLocalDataSourceImpl implements CatalogPageLocalDataSource {
   final _databaseName = "catalog_database.db";
   final _databaseVersion = 1;
   final _table = 'catalog';

     Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
          return db.execute(
            '''CREATE TABLE $_table(
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT,
            posterUrl TEXT
            )
            '''
          );
      },
      version: _databaseVersion,
    );
  }

  static Database db;

  @override
  Future<void> cachePost(List<Map<String, dynamic>> postsToCache) async{
     try {
        db = await _getDatabase();
       postsToCache.forEach((post) async{
         await db.insert(
           _table,
           post,
           conflictAlgorithm: ConflictAlgorithm.replace,
         );
       });
     } catch (_) {
       throw Exception('error');
     }
  }

  @override
  Future<List<PostModel>> getPost() async{
    db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_table);
    return List.generate(
         maps.length,
        (index) {
          return PostModel.fromMap(maps[index]);
        }
    );
  }

  @override
  Future<void> clearCache() async{
    db = await _getDatabase();
    await db.execute('DELETE FROM $_table');
  }

}