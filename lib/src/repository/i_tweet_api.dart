import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';

abstract class ITweetApi {
  Future<void> init();
  Future<Map<int, TweetModel>> getTweets();

  Future<TweetModel?> changeEmoji({
    required int id,
    required Set<AvailableEmojis> emojis,
  });
  Future<void> closeDataBase();
}