import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/repository/sql/sql_database.dart';

class SqlSimpleRepository {
  final Database _db;

  const SqlSimpleRepository(Database db) : _db = db;

  static Future<SqlSimpleRepository> createTweetApi() async {
    final database = SqlTweetDatabase();
    await database.open();

    return SqlSimpleRepository(database.db);
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<List<Map<String, Object?>>> getTable(String table) {
    try {
      return _db.query(table);
    } catch (error) {
      throw 'getTable -  query error';
    }
  }

  Future<Map<String, Object?>> getRowByID({
    required String tableName,
    required int id,
  }) async {
    final row = await _db.query(tableName, where: 'id = $id');

    if (row.isEmpty) {
      throw 'getRowByID - row is empty';
    }

    return row.first;
  }

  Future<void> updateTextColumnById({
    required String tableName,
    required int id,
    required String column,
    required String text,
  }) async {
    try {
      await _db.update(
        tableName,
        {column: "'$text'"},
        where: 'id = $id',
      );
    } catch (e) {
      throw 'updateTextColumnById - update error';
    }
  }
}
