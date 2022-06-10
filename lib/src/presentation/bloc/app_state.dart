part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  @override
  List<Object?> get props => [];

  const AppState();
}

class InitialState extends AppState {}

class FetchingState extends AppState {}

class ErrorState extends AppState {}

class LoadedState extends AppState {
  final Map<int, TweetModel> tweets;
  final int? tweetId;
  late final int _emojiNum;

  int get emojiNum => _emojiNum;

  List<TweetModel> get tweetList {
    final result = <TweetModel>[];
    for (final tweet in tweets.entries) {
      result.add(tweet.value);
    }

    return result;
  }

  @override
  List<Object?> get props => [tweets, tweetId];

  LoadedState({
    required this.tweets,
    this.tweetId,
  }) {
    var num = 0;
    for (var element in tweetList) {
      num += element.emojis.length;
    }
    _emojiNum = num;
  }
}
