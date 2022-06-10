import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/repository/repository_exeptions.dart';
import 'package:sql_test/src/repository/sql/initial_data.dart';

///Concrete implementation of database with hardcoded name tables and columns
///realise open/creation and close operations
///provide Database object
class SqlTweetDatabase {
  static const _databaseName = 'database.db';
  static const _tableName = 'tweets';
  static const _id = 'id';
  static const _name = 'name';
  static const _address = 'address';
  static const _body = 'body';
  static const _emojis = 'emojis';

  late final Database _db;

  String get tableName => _tableName;

  Database get db {
    final Database database;
    try {
      database = _db;
    } catch (error) {
      throw FetchTableException(
        systemError: error.toString(),
        userError: 'SqlTweetDatabase: get db - database not initialized',
      );
    }

    return database;
  }

  Future<void> open() async {
    try {
      final path = await getDatabasesPath();
      _db = await openDatabase(
        '$path/$_databaseName',
        version: 1,
        onCreate: (db, _) => _onCreate(db),
        onOpen: _onOpen,
      );
    } catch (error) {
      throw FetchTableException(
        systemError: error.toString(),
        userError: 'SqlTweetDatabase: open - open error',
      );
    }
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<void> _onCreate(Database database) async {
    try {
      await database.execute('''
          CREATE TABLE $_tableName (
          $_id INTEGER PRIMARY KEY AUTOINCREMENT,
          $_name TEXT NOT NULL,
          $_address TEXT NOT NULL,
          $_body TEXT NOT NULL,
          $_emojis TEXT)
          ''');
    } catch (error) {
      throw FetchTableException(
        systemError: error.toString(),
        userError: 'SqlTweetDatabase: _onCreate - create error',
      );
    }
  }

  Future<void> _onOpen(Database database) async {
    try {
      final table = await database.query(_tableName);
      if (table.isEmpty) {
        for (var tweet in InitialData.data) {
          database.rawInsert('''
              INSERT INTO $_tableName ($_id, $_name, $_address, $_body, $_emojis)
              VALUES (${tweet['id']}, "${tweet['name']}", "${tweet['address']}", "${tweet['body']}", "${tweet['emojis']}")
              ''');
        }
      }
    } catch (error) {
      throw FetchTableException(
        systemError: error.toString(),
        userError: 'SqlTweetDatabase: _onOpen - open error',
      );
    }
  }
}
