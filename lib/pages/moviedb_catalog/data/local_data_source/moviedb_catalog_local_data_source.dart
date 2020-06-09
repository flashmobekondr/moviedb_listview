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
  static Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'catalog_database.db'),
      onCreate: (db, version) {
          return db.execute(
            '''CREATE TABLE catalog(
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT,
            posterUrl TEXT
            )
            '''
          );
      },
      version: 1,
    );
  }

  @override
  Future<void> cachePost(List<Map<String, dynamic>> postsToCache) async{
     try {
       final Database db = await _getDatabase();
       postsToCache.forEach((post) async{
         await db.insert(
           'catalog',
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
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('catalog');
    return List.generate(
         maps.length,
        (index) {
          return PostModel.fromMap(maps[index]);
        }
    );
  }

  @override
  Future<void> clearCache() async{
    final Database db = await _getDatabase();
    await db.execute('DELETE FROM catalog');
  }

}