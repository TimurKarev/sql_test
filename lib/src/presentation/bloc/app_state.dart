part of 'app_bloc.dart';

class AppState {
  factory AppState.fromFake(List<Map<String, dynamic>> data) {
    //TODO: make transfer object
    List<TweetModel> tweetList = [];
    for (final tweet in data) {
      Set<AvailableEmojis> emojiSet = {};
      if (tweet['emojis'].isNotEmpty) {
        final emojis = tweet['emojis'] as List<String>;
        for (final emoji in emojis) {
          emojiSet.add(getFromUnicode(emoji));
        }
      }
      tweetList.add(
        TweetModel(
          id: tweet['id'],
          name: tweet['name'],
          address: tweet['address'],
          body: tweet['body'],
          emojis: emojiSet,
        ),
      );
    }
    return AppState(tweetList: tweetList);
  }

  AppState({required this.tweetList});

  late List<TweetModel> tweetList;
}
