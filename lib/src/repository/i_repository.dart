import 'package:sql_test/src/presentation/model/tweet_model.dart';

abstract class IRepository {
  Future<void> open();
  Future<Map<int, TweetModel>> getTweets();
  Future<void> changeEmoji({required int id});
  Future<void> closeDataBase();
}
