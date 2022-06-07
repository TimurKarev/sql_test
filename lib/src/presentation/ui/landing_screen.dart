import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
import 'package:sql_test/src/presentation/ui/emoji_picker.dart';
import 'package:sql_test/src/presentation/ui_kit/tweet.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is LoadedState) {
                final tweetList = state.tweetList;
                return ListView.builder(
                  itemCount: state.tweets.length,
                  itemBuilder: (_, index) {
                    final model = tweetList[index];
                    return InkWell(
                      onTap: () {
                        context.read<AppBloc>().add(
                              TweetPressedEvent(
                                tweetId: model.id,
                              ),
                            );
                      },
                      child: Tweet(
                        name: model.name,
                        address: model.address,
                        body: model.body,
                        emojis: model.emojis.toList(),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              ); //TODO: create landing page
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) {
            if (current is LoadedState && previous is LoadedState) {
              return previous.tweetId != current.tweetId;
            }
            return false;
          },
          builder: (context, state) {
            if (state is LoadedState) {
              return BottomAppBar(
                child: state.tweetId != null
                    ? EmojiPicker(
                        onTap: (emoji) {
                          context.read<AppBloc>().add(
                                EmojiPressedEvent(
                                  pressedEmoji: emoji,
                                ),
                              );
                        },
                      )
                    : null,
              );
            }
            return const BottomAppBar();
          },
        ),
      ),
    );
  }
}
