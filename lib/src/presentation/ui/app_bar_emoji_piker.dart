import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
import 'package:sql_test/src/presentation/ui_kit/emoji_picker.dart';

class AppBarEmojiPicker extends StatelessWidget {
  const AppBarEmojiPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: _needRebuild,
      builder: (context, state) {
        if (state is LoadedState) {
          return BottomAppBar(
            child: state.tweetId != null
                ? EmojiPicker(
                    onTap: (emoji) => context.read<AppBloc>().add(
                          EmojiPressedEvent(
                            pressedEmoji: emoji,
                          ),
                        ),
                  )
                : null,
          );
        }

        return const BottomAppBar();
      },
    );
  }

  bool _needRebuild(AppState previous, AppState current) {
    if (current is LoadedState && previous is LoadedState) {
      return previous.tweetId != current.tweetId;
    }

    return false;
  }
}
