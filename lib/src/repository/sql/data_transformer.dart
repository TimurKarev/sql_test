import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/domain/model/tweet_model.dart';

///Set of methods for transforming raw sql data and domain models
abstract class DataTransformer {
  static const _separator = '#';

  static TweetModel fromSqlToTweet(Map<String, Object?> sqlMap) {
    return TweetModel(
      id: sqlMap['id'] as int,
      name: sqlMap['name'] as String,
      address: sqlMap['address'] as String,
      body: sqlMap['body'] as String,
      emojis: _fromStringToEmojis(sqlMap['emojis'] as String?),
    );
  }

  static String fromEmojisToString(List<dynamic> emojisList) {
    if (emojisList.isEmpty) {
      return '';
    }

    return emojisList.join(_separator);
  }

  static Set<EmojisModel> _fromStringToEmojis(String? emojisString) {
    if (emojisString == null) {
      return <EmojisModel>{};
    }

    final result = <EmojisModel>{};
    if (emojisString.isNotEmpty) {
      final emojis = emojisString.split(_separator);
      for (final emoji in emojis) {
        result.add(AvailableEmojisExtentions.getFromUnicode(emoji));
      }
    }

    return result;
  }
}
