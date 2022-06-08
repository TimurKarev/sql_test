part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class InitialState extends AppState {}

class FetchingState extends AppState {}

class LoadedState extends AppState {
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
