part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class InitialEvent extends AppEvent {}

class TweetPressedEvent extends AppEvent {
  final int tweetId;

  const TweetPressedEvent({required this.tweetId});

  @override
  List<Object?> get props => [tweetId];
}

class EmojiPressedEvent extends AppEvent {
  final AvailableEmojis pressedEmoji;

  const EmojiPressedEvent({required this.pressedEmoji});

  @override
  List<Object?> get props => [pressedEmoji];
}
