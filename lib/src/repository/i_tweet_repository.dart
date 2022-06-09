import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';

abstract class ITweetRepository {
  Future<void> init();
  Stream<Map<int, TweetModel>> tweetStream();

  Future<void> changeEmoji({
    required int id,
    required Set<AvailableEmojis> emojis,
  });
  Future<void> closeDataBase();
}
