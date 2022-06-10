import 'package:flutter_test/flutter_test.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/domain/model/tweet_model.dart';
import 'package:sql_test/src/repository/sql/data_transformer.dart';

void main() {
  group('DataTransformer tests', () {
    test('fromEmojisToString', () {
      final emojiList_2 = <EmojisModel>[
        EmojisModel.cryingFace,
        EmojisModel.fire,
      ];
      final emojiListEmpty = <EmojisModel>[];

      final string_2 = DataTransformer.fromEmojisToString(emojiList_2);
      final stringEmpty = DataTransformer.fromEmojisToString(emojiListEmpty);

      final testString_2 = emojiList_2.map((emoji) => emoji.unicode).toList().join(DataTransformer.separator);
      expect(string_2, testString_2);

      expect(stringEmpty, '');

      expect(string_2 != stringEmpty, true);
    });
    test('fromSqlToTweet', () {
      final sqlMap_1 = {
        'id': 1,
        'name': 'VimurKarev',
        'address': '@timurkarev',
        'body': 'Съеш этих французких булочек',
        'emojis': '\u{1F496}#\u{1F44D}#\u{1F970}',
      };
      final tweet_1 = DataTransformer.fromSqlToTweet(sqlMap_1);

      expect(
        tweet_1,
        TweetModel(
          id: sqlMap_1['id'] as int,
          name: sqlMap_1['name'] as String,
          address: sqlMap_1['address'] as String,
          body: sqlMap_1['body'] as String,
          emojis: const {
            EmojisModel.redHeart,
            EmojisModel.thumbsUp,
            EmojisModel.smilingFaceWithThreeHearts,
          },
        ),
      );
      final tweet_2 = DataTransformer.fromSqlToTweet(sqlMap_1);
      expect(
        tweet_2 !=
            TweetModel(
              id: sqlMap_1['id'] as int,
              name: sqlMap_1['name'] as String,
              address: sqlMap_1['address'] as String,
              body: sqlMap_1['body'] as String,
              emojis: const {
                EmojisModel.redHeart,
                EmojisModel.fire,
                EmojisModel.smilingFaceWithThreeHearts,
              },
            ),
        true,
      );
    });
  });
}
