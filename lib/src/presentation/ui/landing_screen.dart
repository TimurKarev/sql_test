import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_test/src/domain/constants/available_emojis.dart';
import 'package:sql_test/src/presentation/bloc/app_bloc.dart';
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
              return ListView.builder(
                itemCount: state.tweetList.length,
                itemBuilder: (_, index) {
                  final model = state.tweetList[index];
                  return InkWell(
                    onTap: () {
                      context.read<AppBloc>().add(TweetPressedEvent(tweetIndex: index));
                    },
                    child: Tweet(
                      name: model.name,
                      address: model.address,
                      body: model.body,
                      emojis: model.emojis.map((emoji) => emoji.unicode).toList(),
                    ),
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) => previous.showBottomBar != current.showBottomBar,
          builder: (context, state) {
            return BottomAppBar(
              child: state.showBottomBar
                  ? TextButton(
                      onPressed: () {
                        context.read<AppBloc>().add(EmojiPressedEvent());
                      },
                      child: EmojiPicker(),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
