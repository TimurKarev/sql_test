import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/repository/sql/data_transformer.dart';
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
    } catch (e) {
      throw 'db getter: _db == null or something';
    }

    return database;
  }

  Future<void> open() async {
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/$_databaseName',
      version: 1,
      onCreate: (db, _) => _onCreate(db),
      onOpen: _onOpen,
    );
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<void> _onCreate(Database database) async {
    await database.execute('''
    CREATE TABLE $_tableName (
    $_id INTEGER PRIMARY KEY AUTOINCREMENT,
    $_name TEXT NOT NULL,
    $_address TEXT NOT NULL,
    $_body TEXT NOT NULL,
    $_emojis TEXT)
    ''');
  }

  Future<void> _onOpen(Database database) async {
    final table = await database.query(_tableName);
    if (table.isEmpty) {
      for (var tweet in InitialData.data) {
        final emojis = DataTransformer.fromEmojisToString(tweet['emojis'] as List<dynamic>);
        database.rawInsert('''
        INSERT INTO $_tableName ($_id, $_name, $_address, $_body, $_emojis)
        VALUES (${tweet['id']}, "${tweet['name']}", "${tweet['address']}", "${tweet['body']}", "$emojis")
        ''');
      }
    }
  }
}
