import 'package:rxdart/subjects.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_tweet_repository.dart';
import 'package:sql_test/src/repository/sql/sql_api.dart';

class SqlTweetRepository extends ITweetRepository {
  late final SqlApi _api;

  final _todoStreamController = BehaviorSubject<Map<int, TweetModel>>.seeded(const {});

  @override
  Future<void> init() async {
    final api = await SqlApi.createTweetApi();
    _api = api;

    final tweetMap = await _getTweets();
    _todoStreamController.add(tweetMap);
  }

  @override
  Stream<Map<int, TweetModel>> tweetStream() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> closeDataBase() async {
    await _api.close();
  }

  @override
  Future<void> changeEmoji({
    required int id,
    required Set<AvailableEmojis> emojis,
  }) async {
    final tweetMap = _todoStreamController.value;

    final emojiString = emojis.map((emoji) => emoji.unicode).toList().join('#');

    await _api.updateTextColumnById(
      id: id,
      column: 'emojis',
      text: emojiString,
    );

    final tweet = await _api.getRowByID(
      id: id,
    );

    final newTweet = TweetModel(
      id: tweet['id'] as int,
      name: tweet['name'] as String,
      address: tweet['address'] as String,
      body: tweet['body'] as String,
      emojis: _getEmojis(tweet['emojis'] as String?),
    );

    tweetMap[newTweet.id] = newTweet;

    _todoStreamController.add(tweetMap);
  }

  Future<Map<int, TweetModel>> _getTweets() async {
    final tweets = await _api.getTable();
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

  //TODO: move to transform
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
}
