import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/initial_data/initial_data.dart';

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

  factory SqlDatabase() {
    return _instance;
  }

  SqlDatabase._internal();

  Database? get db => _db;

  Future<void> open() async {
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/$_databaseName',
      version: 1,
      onCreate: _onCreate,
      onOpen: _onOpen,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
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
    final table = await db.rawQuery('SELECT * from $tableName');
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
