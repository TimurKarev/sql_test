part of 'app_bloc.dart';

class AppState extends Equatable {
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

  const AppState({
    required this.tweetList,
    this.showBottomBar = false,
  });

  final List<TweetModel> tweetList;
  final bool showBottomBar;

  @override
  List<Object?> get props => [tweetList, showBottomBar];
}
