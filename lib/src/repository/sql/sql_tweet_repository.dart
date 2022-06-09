import 'package:rxdart/subjects.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/domain/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_tweet_repository.dart';
import 'package:sql_test/src/repository/sql/data_transformer.dart';
import 'package:sql_test/src/repository/sql/sql_api.dart';

///Concrete implementation of Repository Interface
///Using SqlApi object for interacting with Database
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
    required Set<EmojisModel> emojis,
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

    final newTweet = DataTransformer.fromSqlToTweet(tweet);
    tweetMap[newTweet.id] = newTweet;

    _todoStreamController.add(tweetMap);
  }

  Future<Map<int, TweetModel>> _getTweets() async {
    final tweets = await _api.getTable();
    final result = <int, TweetModel>{};
    for (final tweet in tweets) {
      result[tweet['id'] as int] = DataTransformer.fromSqlToTweet(tweet);
    }

    return result;
  }
}
