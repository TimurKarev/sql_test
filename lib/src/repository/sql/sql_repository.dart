import 'package:sqflite/sqflite.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_repository.dart';
import 'package:sql_test/src/repository/sql/sql_database.dart';

class SqlRepository extends IRepository {
  final _database = SqlDatabase();

  Database? get _db => _database.db;

  @override
  Future<void> open() async => await _database.open();

  @override
  Future<TweetModel?> changeEmoji({
    required int id,
    required Set<AvailableEmojis> emojis,
  }) async {
    //TODO: error handling
    if (_db == null) {
      return null;
    }

    final emojiString = emojis.map((emoji) => emoji.unicode).toList().join('#');

    await _db!.rawUpdate('''
      UPDATE ${SqlDatabase.tableName}
      SET emojis = "$emojiString"
      WHERE id = $id
    ''');

    final tweetList = await _db!.query(SqlDatabase.tableName, where: 'id = $id');

    if (tweetList.isNotEmpty) {
      final tweet = tweetList.first;

      return TweetModel(
        id: tweet['id'] as int,
        name: tweet['name'] as String,
        address: tweet['address'] as String,
        body: tweet['body'] as String,
        emojis: _getEmojis(tweet['emojis'] as String?),
      );
    }

    return null;
  }

  @override
  Future<Map<int, TweetModel>> getTweets() async {
    //TODO: error handling
    if (_db == null) {
      return {};
    }

    //TODO: to RAW quiery
    final tweets = await _db!.query(SqlDatabase.tableName);
    final result = <int, TweetModel>{};
    for (final tweet in tweets) {
      //TODO: create constants file fo tables
      result[tweet['id'] as int] = TweetModel(
        id: tweet['id'] as int,
        name: tweet['name'] as String,
        address: tweet['address'] as String,
        body: tweet['body'] as String,
        emojis: _getEmojis(tweet['emojis'] as String?),
      );
    }
    return result;
  }

  Set<AvailableEmojis> _getEmojis(String? emojisString) {
    if (emojisString == null) {
      return <AvailableEmojis>{};
    }

    final result = <AvailableEmojis>{};
    if (emojisString.isNotEmpty) {
      final emojis = emojisString.split('#');
      for (final emoji in emojis) {
        result.add(AvailableEmojisExtentions.getFromUnicode(emoji));
      }
    }
    return result;
  }

  @override
  Future<void> closeDataBase() async {
    _database.close();
  }
}
