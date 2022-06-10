import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/domain/model/tweet_model.dart';
import 'package:sql_test/src/repository/repository_exeptions.dart';

///Set of methods for transforming raw sql data and domain models
abstract class DataTransformer {
  static const separator = '#';

  static TweetModel fromSqlToTweet(Map<String, Object?> sqlMap) {
    try {
      return TweetModel(
        id: sqlMap['id'] as int,
        name: sqlMap['name'] as String,
        address: sqlMap['address'] as String,
        body: sqlMap['body'] as String,
        emojis: _fromStringToEmojis(sqlMap['emojis'] as String?),
      );
    } catch (error) {
      throw DataTransformerException(
        systemError: error.toString(),
        userError: 'fromSqlToTweet',
      );
    }
  }

  static String fromEmojisToString(List<EmojisModel> emojisList) {
    if (emojisList.isEmpty) {
      return '';
    }
    final emojisUnicode = [
      for (final emoji in emojisList) emoji.unicode,
    ];

    return emojisUnicode.join(separator);
  }

  static Set<EmojisModel> _fromStringToEmojis(String? emojisString) {
    if (emojisString == null) {
      return <EmojisModel>{};
    }

    final result = <EmojisModel>{};
    if (emojisString.isNotEmpty) {
      final emojis = emojisString.split(separator);
      try {
        for (final emoji in emojis) {
          result.add(AvailableEmojisExtentions.getFromUnicode(emoji));
        }
      } catch (error) {
        throw DataTransformerException(
          systemError: error.toString(),
          userError: '_fromStringToEmojis',
        );
      }
    }

    return result;
  }
}
