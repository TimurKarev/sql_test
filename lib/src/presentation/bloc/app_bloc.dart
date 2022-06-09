import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_tweet_api.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ITweetApi _repository;

  AppBloc(ITweetApi repository)
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

    await _repository.init();
    final tweetsMap = await _repository.getTweets();
    emitter(
      LoadedState(
        tweets: tweetsMap,
      ),
    );
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
        if (emojis.contains(event.pressedEmoji)) {
          emojis.remove(event.pressedEmoji);
        } else {
          emojis.add(event.pressedEmoji);
        }

        final tweet = await _repository.changeEmoji(
          id: loadedState.tweetId!,
          emojis: emojis,
        );

        //TODO: need something better
        loadedState.tweets[loadedState.tweetId!] = tweet!;
        emitter(
          LoadedState(
            tweets: loadedState.tweets,
            tweetId: null,
          ),
        );
      }
    }
  }
}
