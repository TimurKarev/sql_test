import 'package:sql_test/src/presentation/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_repository.dart';

class SqlRepository extends IRepository {
  @override
  Future<void> changeEmoji({required int id}) {
    // TODO: implement changeEmoji
    throw UnimplementedError();
  }

  @override
  Future<List<TweetModel>> getTweets() {
    // TODO: implement getTweets
    throw UnimplementedError();
  }
}
