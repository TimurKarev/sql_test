import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/domain/model/tweet_model.dart';

///Repository Interface
abstract class ITweetRepository {
  Future<void> init();
  Stream<Map<int, TweetModel>> tweetStream();
  Future<void> changeEmoji({required int id, required Set<EmojisModel> emojis});
  Future<void> closeDataBase();
}
