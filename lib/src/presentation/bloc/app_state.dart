part of 'app_bloc.dart';

class AppState extends Equatable {
  factory AppState.fromFake(List<Map<String, dynamic>> data) {
    //TODO: make transfer object
    Map<int, TweetModel> resilt = {};
    for (final tweet in data) {
      Set<AvailableEmojis> emojiSet = {};
      if (tweet['emojis'].isNotEmpty) {
        final emojis = tweet['emojis'] as List<String>;
        for (final emoji in emojis) {
          emojiSet.add(AvailableEmojisExtentions.getFromUnicode(emoji));
        }
      }
      resilt[tweet['id']] = TweetModel(
        id: tweet['id'],
        name: tweet['name'],
        address: tweet['address'],
        body: tweet['body'],
        emojis: emojiSet,
      );
    }
    return AppState(tweets: resilt);
  }

  const AppState({
    required this.tweets,
    this.tweetIndex,
  });

  final Map<int, TweetModel> tweets;
  final int? tweetIndex;

  List<TweetModel> get tweetList {
    final result = <TweetModel>[];
    for (final tweet in tweets.entries) {
      result.add(tweet.value);
    }
    return result;
  }

  @override
  List<Object?> get props => [tweets, tweetIndex];
}
