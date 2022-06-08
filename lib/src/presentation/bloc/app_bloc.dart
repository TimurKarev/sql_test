import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';
import 'package:sql_test/src/repository/i_repository.dart';
import 'package:sql_test/src/repository/sql/sql_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final IRepository _repository = SqlRepository();

  AppBloc() : super(InitialState()) {
    on<InitialEvent>(_onInitialEvent);
    on<TweetPressedEvent>(_onTweetPressedEvent);
    on<EmojiPressedEvent>(_onEmojiPressedEvent);

    add(InitialEvent());
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<AppState> emitter,
  ) async {
    emitter(
      FetchingState(),
    );
    await _repository.open();
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
      print('${loadedState.tweetId}   ${event.pressedEmoji.name}');
      emitter(
        LoadedState(
          tweets: loadedState.tweets,
          tweetId: null,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _repository.closeDataBase();
    return super.close();
  }
}
