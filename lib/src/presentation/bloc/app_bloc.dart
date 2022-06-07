import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/initial_data/initial_data.dart';
import 'package:sql_test/src/presentation/model/tweet_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.fromFake(InitialData.data)) {
    on<TweetPressedEvent>(_onTweetPressedEvent);
    on<EmojiPressedEvent>(_onEmojiPressedEvent);
  }

  Future<void> _onTweetPressedEvent(
    TweetPressedEvent event,
    Emitter<AppState> emitter,
  ) async {
    if (state.tweetIndex == event.tweetIndex) {
      emitter(
        AppState(
          tweetList: state.tweetList,
          tweetIndex: null,
        ),
      );

      return;
    }

    emitter(
      AppState(
        tweetList: state.tweetList,
        tweetIndex: event.tweetIndex,
      ),
    );
  }

  Future<void> _onEmojiPressedEvent(
    EmojiPressedEvent event,
    Emitter<AppState> emitter,
  ) async {
    print('${state.tweetIndex}   ${event.pressedEmoji.name}');
    emitter(
      AppState(
        tweetList: state.tweetList,
        tweetIndex: null,
      ),
    );
  }
}
