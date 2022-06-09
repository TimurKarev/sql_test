import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/repository/repository_exeptions.dart';
import 'package:sql_test/src/repository/sql/sql_tweet_database.dart';

///SqlApi class for interacting with SqlDatabase
class SqlApi {
  final String tableName;
  final Database _db;

  const SqlApi({required Database db, required this.tableName}) : _db = db;

  static Future<SqlApi> createTweetApi() async {
    final database = SqlTweetDatabase();
    await database.open();

    return SqlApi(db: database.db, tableName: database.tableName);
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<List<Map<String, Object?>>> getTable() {
    try {
      return _db.query(tableName);
    } catch (error) {
      throw FetchTableException(
        systemError: error.toString(),
        userError: 'getTable -  query error',
      );
    }
  }

  Future<Map<String, Object?>> getRowByID({
    required int id,
  }) async {
    final row = await _db.query(tableName, where: 'id = $id');

    if (row.isEmpty) {
      throw const FetchRowException(
        systemError: '',
        userError: 'getTable -  query error',
      );
    }

    return row.first;
  }

  Future<void> updateTextColumnById({
    required int id,
    required String column,
    required String text,
  }) async {
    try {
      await _db.update(
        tableName,
        {column: text},
        where: 'id = $id',
      );
    } catch (error) {
      throw FetchRowException(
        systemError: error.toString(),
        userError: 'getTable -  query error',
      );
    }
  }
}
