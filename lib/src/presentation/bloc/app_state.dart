part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class InitialState extends AppState {}

class LoadedState extends AppState {
  factory LoadedState.fromFake(List<Map<String, dynamic>> data) {
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
    return LoadedState(tweets: resilt);
  }

  const LoadedState({
    required this.tweets,
    this.tweetId,
  });

  final Map<int, TweetModel> tweets;
  final int? tweetId;

  List<TweetModel> get tweetList {
    final result = <TweetModel>[];
    for (final tweet in tweets.entries) {
      result.add(tweet.value);
    }
    return result;
  }

  @override
  List<Object?> get props => [tweets, tweetId];
}
