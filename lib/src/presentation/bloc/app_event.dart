part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class TweetPressedEvent extends AppEvent {
  final int tweetIndex;

  const TweetPressedEvent({required this.tweetIndex});

  @override
  List<Object?> get props => [tweetIndex];
}

class EmojiPressedEvent extends AppEvent {
  final AvailableEmojis pressedEmoji;

  const EmojiPressedEvent({required this.pressedEmoji});

  @override
  List<Object?> get props => [pressedEmoji];
}
