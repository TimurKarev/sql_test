import 'package:sql_test/src/presentation/model/tweet_model.dart';

abstract class IRepository {
  Future<List<TweetModel>> getTweets();
  Future<void> changeEmoji({required int id});
}
