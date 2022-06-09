import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/initial_data/initial_data.dart';

//TODO: Error handling
//TODO: New Api Layer
//TODO: Const file

class SqlTweetDatabase {
  static const _databaseName = 'database.db';
  static const tableName = 'tweets';
  static const _id = 'id';
  static const _name = 'name';
  static const _address = 'address';
  static const _body = 'body';
  static const _emojis = 'emojis';
  static const _emojiSeparator = '#';

  Database? _db;

  Database get db {
    final Database database;
    try {
      database = _db!;
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
    await _db?.close();
  }

  //TODO: move to data transfers
  String _getEmojis(List<dynamic> emojisList) {
    if (emojisList.isEmpty) {
      return '';
    }

    return emojisList.join(SqlTweetDatabase._emojiSeparator);
  }

  Future<void> _onCreate(Database database) async {
    await database.execute('''
    CREATE TABLE $tableName (
    $_id INTEGER PRIMARY KEY AUTOINCREMENT,
    $_name TEXT NOT NULL,
    $_address TEXT NOT NULL,
    $_body TEXT NOT NULL,
    $_emojis TEXT)
    ''');
  }

  Future<void> _onOpen(Database database) async {
    final table = await database.query(tableName);
    if (table.isEmpty) {
      //TODO: to layer
      for (var tweet in InitialData.data) {
        final emojis = _getEmojis(tweet['emojis'] as List<dynamic>);
        database.rawInsert('''
        INSERT INTO $tableName ($_id, $_name, $_address, $_body, $_emojis)
        VALUES (${tweet['id']}, "${tweet['name']}", "${tweet['address']}", "${tweet['body']}", "$emojis")
        ''');
      }
    }
  }
}
