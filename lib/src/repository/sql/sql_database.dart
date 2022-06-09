import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/initial_data/initial_data.dart';

//TODO: Error handling
//TODO: New Api Layer
//TODO: Const file

class SqlDatabase {
  static const _databaseName = 'database.db';
  static const tableName = 'tweets';
  static const _id = 'id';
  static const _name = 'name';
  static const _address = 'address';
  static const _body = 'body';
  static const _emojis = 'emojis';
  static const _emojiSeparator = '#';

  Database? _db;

  static final SqlDatabase _instance = SqlDatabase._internal();

  Database get db {
    final Database database;
    try {
      database = _db!;
    } catch (e) {
      throw 'db getter: _db == null or something';
    }

    return database;
  }

  factory SqlDatabase() {
    return _instance;
  }

  SqlDatabase._internal();

  Future<void> open() async {
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/$_databaseName',
      version: 1,
      onCreate: (db, _) => _onCreate(db),
      onOpen: _onOpen,
    );
  }

  Future<List<Map<String, Object?>>> getTable(String table) {
    try {
      return db.query(table);
    } catch (error) {
      throw 'getTable -  query error';
    }
  }

  Future<Map<String, Object?>> getRowByID({
    required String tableName,
    required int id,
  }) async {
    final row = await db.query(tableName, where: 'id = $id');

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
      await db.update(
        tableName,
        {column: "'$text'"},
        where: 'id = $id',
      );
    } catch (e) {
      throw 'updateTextColumnById - update error';
    }
  }

  Future<void> _onCreate(Database db) async {
    await db.execute('''
    CREATE TABLE $tableName (
    $_id INTEGER PRIMARY KEY AUTOINCREMENT,
    $_name TEXT NOT NULL,
    $_address TEXT NOT NULL,
    $_body TEXT NOT NULL,
    $_emojis TEXT)
    ''');
  }

  Future<void> _onOpen(Database db) async {
    final table = await getTable(tableName);
    if (table.isEmpty) {
      for (var tweet in InitialData.data) {
        final emojis = _getEmojis(tweet['emojis'] as List<dynamic>);
        db.rawInsert('''
        INSERT INTO $tableName ($_id, $_name, $_address, $_body, $_emojis)
        VALUES (${tweet['id']}, "${tweet['name']}", "${tweet['address']}", "${tweet['body']}", "$emojis")
        ''');
      }
    }
  }

  Future<void> close() async {
    await _db?.close();
  }

  //TODO: move to data transfers
  String _getEmojis(List<dynamic> emojisList) {
    if (emojisList.isEmpty) {
      return '';
    }
    return emojisList.join(SqlDatabase._emojiSeparator);
  }
}
