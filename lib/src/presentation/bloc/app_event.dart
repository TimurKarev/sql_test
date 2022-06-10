part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const AppEvent();
}

class InitialEvent extends AppEvent {}

class TweetPressedEvent extends AppEvent {
  final int tweetId;

  @override
  List<Object?> get props => [tweetId];

  const TweetPressedEvent({required this.tweetId});

}

class EmojiPressedEvent extends AppEvent {
  final EmojisModel pressedEmoji;

  @override
  List<Object?> get props => [pressedEmoji];

  const EmojiPressedEvent({required this.pressedEmoji});
}
