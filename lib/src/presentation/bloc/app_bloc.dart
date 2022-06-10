import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/domain/model/available_emojis.dart';
import 'package:sql_test/src/domain/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_tweet_repository.dart';
import 'package:sql_test/src/repository/repository_exeptions.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ITweetRepository _repository;

  AppBloc(ITweetRepository repository)
      : _repository = repository,
        super(InitialState()) {
    on<InitialEvent>((_, emitter) => _onInitialEvent(emitter));
    on<TweetPressedEvent>(_onTweetPressedEvent);
    on<EmojiPressedEvent>(_onEmojiPressedEvent);

    add(InitialEvent());
  }

  @override
  Future<void> close() async {
    _repository.closeDataBase();

    return super.close();
  }

  Future<void> _onInitialEvent(
    Emitter<AppState> emitter,
  ) async {
    emitter(
      FetchingState(),
    );

    try {
      await _repository.init();

      await emitter.forEach<Map<int, TweetModel>>(
        _repository.tweetStream(),
        onData: (tweetMap) => LoadedState(
          tweets: tweetMap,
        ),
      );
    } on RepositoryException {
      emitter(ErrorState());
    }
  }

  Future<void> _onTweetPressedEvent(
    TweetPressedEvent event,
    Emitter<AppState> emitter,
  ) async {
    if (state is LoadedState) {
      final loadedState = state as LoadedState;
      if (loadedState.tweetId == event.tweetId) {
        emitter(
          LoadedState(
            tweets: loadedState.tweets,
            tweetId: null,
          ),
        );

        return;
      }

      emitter(
        LoadedState(
          tweets: loadedState.tweets,
          tweetId: event.tweetId,
        ),
      );
    }
  }

  Future<void> _onEmojiPressedEvent(
    EmojiPressedEvent event,
    Emitter<AppState> emitter,
  ) async {
    if (state is LoadedState) {
      final loadedState = state as LoadedState;

      if (loadedState.tweetId != null) {
        final emojis = loadedState.tweets[loadedState.tweetId]!.emojis;

        try {
          if (emojis.contains(event.pressedEmoji)) {
            emojis.remove(event.pressedEmoji);
          } else {
            emojis.add(event.pressedEmoji);
          }

          await _repository.changeEmoji(
            id: loadedState.tweetId!,
            emojis: emojis,
          );
        } on RepositoryException {
          emitter(ErrorState());
          add(InitialEvent());
        }
      }
    }
  }
}
